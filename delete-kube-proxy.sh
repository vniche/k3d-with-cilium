#!/bin/bash

kubectl -n kube-system delete ds kube-proxy
kubectl -n kube-system delete cm kube-proxy

