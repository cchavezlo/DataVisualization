from matplotlib.pyplot import get, table

from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import KNNImputer, SimpleImputer, IterativeImputer

import numpy as np
import pandas as pd
import collections
import statsmodels.api as sm

from scipy import fft
from scipy import signal as sig

from attrs import attr_data


def get_columns():
    columns = []
    for _, attrs in attr_data.items():
        for attr_name, _ in attrs.items():
            columns.append(attr_name)
    # print(columns, len(columns))
    return columns


def cantNullxColumns(df):
    x = []
    for c in df.columns:
        x.append(collections.Counter(df[c])["?"])
    return x


def porcDeNullsTotal(df):
    f = df.shape[0]
    c = df.shape[1]
    cantFalta = sum(cantNullxColumns(df))
    porcentFalta = 100 * cantFalta / (f * c)
    print(porcentFalta, "%")
    return porcentFalta


def porcDeNullsXColumn(df):
    total = df.shape[0]
    nulos = cantNullxColumns(df)
    nulos = [round(i * 100 / total, 2) for i in nulos]
    return (nulos)


def compValNull(df):
    mod = SimpleImputer(missing_values="?", strategy="most_frequent")
    dfcompleto = pd.DataFrame(mod.fit_transform(df))
    return (dfcompleto)


def maxYmin(df):
    dfcompleto = compValNull(df)
    maximo = dfcompleto.max()
    minimo = dfcompleto.min()
    print(minimo)
    return maximo, minimo


def knnOp(df, ng):
    imputer = KNNImputer(missing_values="?", n_neighbors=ng)
    imputer.fit_transform(df)
    return df


def get_columns():
    columns = []
    for _, attrs in attr_data.items():
        for attr_name, _ in attrs.items():
            columns.append(attr_name)
    # print(columns, len(columns))
    return columns


def leerCSV(ruta, rutaNames=False):
    if (rutaNames != False):
        titulos = pd.read_csv(rutaNames, header=None, )
        cabeceras = titulos[0].tolist()
        df = pd.read_csv(ruta, header=None, names=cabeceras)
        return df, cabeceras
    elif (rutaNames == "sin cabecera"):
        df = pd.read_csv(ruta, header=None)
        return df
    else:
        df = pd.read_csv(ruta)
        return df


def open_dataset():
    dataframe = pd.read_csv('db.txt', sep=',', header=None)
    # columns = dataframe.iloc[0]
    # dataframe.drop(0, inplace=True)
    # dataframe.reset_index(inplace=True, drop=True)
    dataframe.columns = get_columns()
    # print(dataframe)
    return dataframe


def get_lost_data(dataframe, return_only_nulls=False):
    column_detail = {}
    for column in dataframe.columns:
        null_num = (dataframe[column] == '?').sum()
        null_percentage = round(null_num * 100 /
                                len(dataframe[column]), 2)
        # print(f"{column}: ", null_num, null_percentage)
        if return_only_nulls:
            if null_percentage != 0:
                column_detail[column] = null_percentage
            else:
                continue
        else:
            column_detail[column] = null_percentage
    return column_detail


if __name__ == '__main__':
    open_dataset()
