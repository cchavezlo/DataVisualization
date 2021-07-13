import bottle
import json
from bottle import route, run, template, request, response, redirect, static_file, error, post
from numpy import percentile
from attrs import attr_data

import json

from functions import get_lost_data, open_dataset, get_columns, porcDeNullsXColumn, porcDeNullsTotal, cantNullxColumns, compValNull, maxYmin, leerCSV

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
    maxs,mins=maxYmin(dataframe)
    return template("maxymin", columns_detail=total_columns,maxs=maxs,mins=mins)

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

    #dataF= filtered_dataframe.columns(column_detail)
    # print(filtered_dataframe.to_dict())
    #filtered_dataframe.to_json("static/tmpresult.json", orient='index')

    # return filtered_dataframe.to_dict()
    return template("explore", columns_data=filtered_dataframe.to_dict(), columns_detail=column_detail, type_info='Lugares' if attribute_based != 'true' else 'Atributos')


@route('/static/<filepath:path>')
def server_static(filepath):
    return static_file(filepath, root='./static')


run(host="localhost", port=1234, debug=True, reloader=True)
