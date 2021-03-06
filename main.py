from functools import reduce
from typing import AbstractSet
import bottle
import json
from bottle import route, run, template, request, response, redirect, static_file, error, post, view
from numpy import percentile
from numpy.core.numeric import indices
import pandas
from pandas.io.parsers import read_csv
from attrs import attr_data
from itertools import groupby

from functions import open_dataset, get_columns, porcDeNullsXColumn, porcDeNullsTotal, cantNullxColumns, compValNull, \
    maxYmin, leerCSV, get_lost_data, reduce_data

dataframe = open_dataset()
total_columns = get_columns()


@route('/')
def index():
    column_detail = {}
    for column in total_columns:
        null_num = (dataframe[column] == '?').sum()
        null_percentage = round(null_num * 100 /
                                len(dataframe[column]), 2)
        # print(f"{column}: ", null_num, null_percentage)
        column_detail[column] = null_percentage
    return template("index", attr_data=attr_data, attr_detail=column_detail)


@route('/nulos')
def funnull():
    # listanulos = porcDeNullsXColumn(dataframe)
    # nombres = total_columns

    null_detail = get_lost_data(dataframe, return_only_nulls=True)

    return template("null", nullDetail=json.dumps(null_detail))


@route('/mym')
def funmym():
    maxs, mins = maxYmin(dataframe)
    return template("maxymin", columns_detail=total_columns, maxs=maxs, mins=mins)


@route('/explore')
def index():
    return template("explore", attr_data=attr_data)


@post('/select_attrs')
def select_attrs():
    attrs = request.forms.getall('attrs[]')
    attribute_based = request.forms.get('attr_based')
    filtered_dataframe = dataframe[attrs]
    filtered_dataframe.index = dataframe['communityname']
    # If not attribute based then its based on places
    column_detail = {}
    for column in attrs:
        null_num = (filtered_dataframe[column] == '?').sum()
        null_percentage = round(null_num * 100 /
                                len(filtered_dataframe[column]), 2)
        print(f"{column}: ", null_num, null_percentage)
        column_detail[column] = {"perc": null_percentage, "len": null_num}

    if attribute_based != "true":
        filtered_dataframe = filtered_dataframe.T

    # dataF= filtered_dataframe.columns(column_detail)
    # print(filtered_dataframe.to_dict())
    # filtered_dataframe.to_json("static/tmpresult.json", orient='index')

    # return filtered_dataframe.to_dict()
    return template("explore", columns_data=filtered_dataframe.to_dict(), columns_detail=column_detail, type_info='Lugares' if attribute_based != 'true' else 'Atributos')


@route('/datared')
def data_reduction():
    # normalized_dataframe = pandas.read_csv(
    #     'communities.txt', delimiter=',', header=None)
    print("Comps:", request.query.n_comp)

    n_components = 2 if request.query.n_comp is None else 3
    columns = ['x', 'y'] if request.query.n_comp is None else ['x', 'y', 'z']
    print(repr(n_components))
    raw_dataframe = open_dataset()

    reduced_data = reduce_data(raw_dataframe, n_components)

    reduced_dataframe = pandas.DataFrame(
        reduced_data, columns=columns)
    reduced_dataframe['comm_alias'] = raw_dataframe['communityname'] + \
        '_'+raw_dataframe['state']
    # return reduced_dataframe.to_json(orient="records")
    return template('reduction', reduced_data=reduced_dataframe.to_json(orient="records"))

@route('/hyerarchy')
def data_hyerarchy():
    predictable = attr_data['Metas a Predecir']
    violence_types = []
    for attr in predictable:
        if "Pop" not in attr:
            violence_types.append(attr)

    communities = dataframe[['communityname', 'state']].groupby('state')
    communities_json = communities.apply(lambda x: x.to_dict(orient='records'))
    result = {}
    result['name'] = 'States'
    result['children'] = []
    for state, communities in communities_json.items():
        state_data = {'name':  state}
        state_data['children'] = []
        for communitie in communities:
            state_data['children'].append({"name": communitie['communityname']})
            communitie.pop('state', None)
        result['children'].append(state_data)

    filtered_dataframe = dataframe[violence_types + ['communityname', 'state']]

    filtered_dataframe['comm_alias'] = filtered_dataframe['communityname'] + '_'+filtered_dataframe['state']
    filtered_dataframe = filtered_dataframe.groupby('comm_alias').apply(lambda x: x.to_dict(orient='records'))
    # return filtered_dataframe
    return template('hyerarchy', communities = result, communities_data = filtered_dataframe.to_dict())


@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./static')


run(host="localhost", port=1234, debug=True, reloader=True)
