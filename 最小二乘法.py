#!/usr/bin/env python
# -*-coding:utf-8-*-
# author:King time:2019/9/11
import numpy as np
from scipy.optimize import leastsq

Xi = np.array([0.9, 2.5, 3.3, 4.5, 5.7, 6.7])
Yi = np.array([1.1, 1.6, 2.6, 3.2, 4.0, 5.0])


def func(p, x):
    k, b = p
    return k * x + b


def error(p, x, y):
    return func(p, x) - y


p0 = [Xi[0], Yi[0]]

factors = leastsq(error, p0, args=(Xi, Yi))
print('k=', factors[0][0], '\nb=', factors[0][1])

quit()