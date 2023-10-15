#!/usr/bin/env python3

import rosbag
from matplotlib import pyplot as plt
import matplotlib
import numpy as np


stationary = rosbag.Bag('stationary_data.bag')
walking=rosbag.Bag('walking_data_circle.bag')
stationary_occ= rosbag.Bag('stationary_data_occ.bag')
walking_occ= rosbag.Bag('walking_data_occ.bag')

sutmelis=[]
sutmnlis=[]
soutmelis=[]
soutmnlis=[]
ssec=[]
sosec=[]

wutmelis=[]
wutmnlis=[]
woutmelis=[]
woutmnlis=[]
wsec=[]
wosec=[]

for topic,msg,t in stationary.read_messages(topics=['/GPS']):
    sutmelis.append(msg.utm_easting)
    sutmnlis.append(msg.utm_northing)
    ssec.append(msg.header.stamp.secs)

for topic,msg,t in walking.read_messages(topics=['/GPS']):
    wutmelis.append(msg.utm_easting)
    wutmnlis.append(msg.utm_northing)
    wsec.append(msg.header.stamp.secs)

for topic,msg,t in stationary_occ.read_messages(topics=['/GPS']):
    soutmelis.append(msg.utm_easting)
    soutmnlis.append(msg.utm_northing)
    sosec.append(msg.header.stamp.secs)

for topic,msg,t in walking_occ.read_messages(topics=['/GPS']):
    woutmelis.append(msg.utm_easting)
    woutmnlis.append(msg.utm_northing)
    wosec.append(msg.header.stamp.secs)

se=sum(sutmelis)/len(sutmelis)
sn=sum(sutmnlis)/len(sutmnlis)
we=sum(wutmelis)/len(wutmelis)
wn=sum(wutmnlis)/len(wutmnlis)

avgse=[i-min(sutmelis) for i in sutmelis]
avgsn=[i-min(sutmnlis) for i in sutmnlis]
avgwe=[i-min(wutmelis) for i in wutmelis]
avgwn=[i-min(wutmnlis) for i in wutmnlis]
avgsoe=[i-min(soutmelis) for i in soutmelis]
avgson=[i-min(soutmnlis) for i in soutmnlis]
avgwoe=[i-min(woutmelis) for i in woutmelis]
avgwon=[i-min(woutmnlis) for i in woutmnlis]

#Stationary Data without occlusion
plt.plot(ssec,avgse,'r',label='UTM-Easting')
plt.plot(ssec,avgsn,'b',label='UTM-Easting')
plt.title("Stationary Data without occlusion")
plt.ylabel("Error in meters")
plt.xlabel("Time")
plt.show()

#Stationary Data Northing without occlusion
plt.axhline(sutmelis[0])
plt.plot(ssec,sutmelis,'g',label='UTM-Easting')
plt.title("Stationary Data without occlusion")
plt.ylabel("Error in meters")
plt.xlabel("Time")
plt.show()

#Stationary Data Northing without occlusion
plt.axhline(sutmnlis[0])
plt.plot(ssec,sutmnlis,'r',label='UTM-Easting')
plt.title("Stationary Data without occlusion")
plt.ylabel("Error in meters")
plt.xlabel("Time")
plt.show()

#Stationary Data Easting vs Northing without occlusion
plt.hist2d(sutmelis,sutmnlis,100,norm=matplotlib.colors.LogNorm())
plt.title("Stationary Data without occlusion")
plt.ylabel("UTM-Northing")
plt.xlabel("UTM-Easting")
plt.show()

#plt.subplot(2,2,3)
plt.plot(wsec,avgwe,'r',label='UTM-Easting')
plt.plot(wsec,avgwn,'b',label='UTM-Northing')
plt.xlim(57100,57450)
plt.title("Walking Data without occlusion")
plt.ylabel("UTM-Easting, UTM-Northing")
plt.xlabel("Time")
plt.show()

#plt.subplot(2,2,4)
plt.hist2d(wutmelis,wutmnlis,100,norm=matplotlib.colors.LogNorm())
plt.title("Walking Data without occlusion")
plt.xlabel("UTM-Easting")
plt.ylabel("UTM-Northing")
plt.show()

#plt.subplot(2,2,1)
plt.plot(sosec,avgsoe,'r',label='UTM-Easting')
plt.plot(sosec,avgson,'b',label='UTM-Northing')
plt.title("Stationary Data with occlusion")
plt.ylabel("UTM-Easting, UTM-Northing")
plt.xlabel("Time")
plt.show()

#plt.subplot(2,2,2)
plt.hist2d(soutmelis,soutmnlis,100,norm=matplotlib.colors.LogNorm())
plt.title("Stationary Data with occlusion")
plt.ylabel("UTM-Northing")
plt.xlabel("UTM-Easting")
plt.show()

#plt.subplot(2,2,3)
plt.plot(wosec,avgwoe,'r',label='UTM-Easting')
plt.plot(wosec,avgwon,'b',label='UTM-Northing')
plt.title("Walking Data with Occlusion")
plt.ylabel("UTM-Easting, UTM-Northing")
plt.xlabel("Time")
plt.show()

#plt.subplot(2,2,4)
plt.hist2d(woutmelis,woutmnlis,100,norm=matplotlib.colors.LogNorm())
plt.title("Walking Data with occlusion")
plt.xlabel("UTM-Easting")
plt.ylabel("UTM-Northing")
plt.show()

stationary.close
walking.close
stationary_occ.close
walking_occ.close