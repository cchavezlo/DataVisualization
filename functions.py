from matplotlib.pyplot import get, table

from sklearn.preprocessing import MinMaxScaler
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA

from sklearn.experimental import enable_iterative_imputer
from sklearn.impute import KNNImputer, SimpleImputer, IterativeImputer

import numpy as np
import pandas as pd
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


def open_dataset():
    dataframe = pd.read_csv('db.txt', sep=',', header=None)
    # columns = dataframe.iloc[0]
    # dataframe.drop(0, inplace=True)
    # dataframe.reset_index(inplace=True, drop=True)
    dataframe.columns = get_columns()
    # print(dataframe)
    return dataframe


def get_lost_data(dataframe):
    res = {}
    for column in dataframe.columns:
        lost_data, indices = dataframe.get_lost_data(column)

        res[column] = {'porcentaje': lost_data, 'indices': indices}
    return res


if __name__ == '__main__':
    open_dataset()
