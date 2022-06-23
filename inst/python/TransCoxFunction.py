#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Feb  8 13:36:43 2022

@author: zli16
"""

# import sys, os
# os.chdir('/Users/zli16/Dropbox/TransCox')
# import pkg_resources
# pkg_resources.require("tensorflow==2.1.0")
import tensorflow as tf
# print(tf.__version__)
import tensorflow_probability as tfp
# print(tfp.__version__)

import numpy as np
#import pandas as pd

# CovData = pd.read_csv('/Users/zli16/Dropbox/TransCox/CovData.csv')
# cumH = pd.read_csv('/Users/zli16/Dropbox/TransCox/cumData.csv')
# hazards = pd.read_csv('/Users/zli16/Dropbox/TransCox/hazards.csv')
# status = pd.read_csv('/Users/zli16/Dropbox/TransCox/status.csv')
# estR = pd.read_csv('/Users/zli16/Dropbox/TransCox/estR.csv')
# Xinn = pd.read_csv('/Users/zli16/Dropbox/TransCox/Xinn.csv')


# lambda1 = 0.5
# lambda2 = 0.5

# learning_rate = 0.0001
# nsteps = 100

def TransCox(CovData, cumH, hazards, status, estR, Xinn, lambda1, lambda2, learning_rate, nsteps):
    xi = tf.Variable(np.repeat([0.], repeats = len(hazards)), dtype = "float64")
    eta = tf.Variable(np.repeat([0.], repeats = len(estR)), dtype = "float64")
   # eta = tf.Variable([0., 0.], shape = (len(estR),), dtype = "float64")
    XiData = np.float64(Xinn)
    ppData = np.float64(CovData)
    cQ_np = np.float64(cumH).reshape((len(cumH),))
    dq_np  = np.float64(hazards).reshape((len(hazards),))
    estR2 = np.float64(estR).reshape((len(estR),))
    status_np = np.float64(status).reshape((len(status),))
    smallidx = tf.where(status_np == 2)
    loss_fn = lambda: tf.math.negative(tf.reduce_sum(tf.gather(tf.math.reduce_sum(tf.math.multiply(ppData, tf.math.add(estR2,eta)), axis = 1), indices=smallidx)) + tf.reduce_sum(tf.math.log(tf.math.add(dq_np,xi))) - tf.reduce_sum(tf.math.multiply(tf.math.add(cQ_np, tf.math.reduce_sum(tf.math.multiply(XiData, xi), axis = 1)), tf.math.exp(tf.math.reduce_sum(tf.math.multiply(ppData, tf.math.add(estR2, eta)), axis = 1))))) + lambda1*tf.math.reduce_sum(abs(eta)) + lambda2*tf.math.reduce_sum(abs(xi))
    loss = tfp.math.minimize(loss_fn,
                           num_steps=nsteps,
                           optimizer=tf.optimizers.Adam(learning_rate=learning_rate))
    return eta.numpy(), xi.numpy()


# TransCox(CovData, cumH, hazards, status, estR, Xinn, lambda1, lambda2, learning_rate = 0.03)

# eta.numpy() + estR2
# tf.math.add(eta, estR2)
# tf.math.add(dq_np, xi)

