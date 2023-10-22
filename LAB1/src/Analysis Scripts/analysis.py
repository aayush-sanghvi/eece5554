#!/usr/bin/env python3

import rosbag
from matplotlib import pyplot as plt
import utm

stationary = rosbag.Bag('stationary_data.bag')
walking=rosbag.Bag('walking_data.bag')

sutmelis=[]
sutmnlis=[]
ssec=[]

wutmelis=[]
wutmnlis=[]
wsec=[]



for topic,msg,t in stationary.read_messages(topics=['/GPS']):
    sutmelis.append(msg.utm_easting)
    sutmnlis.append(msg.utm_northing)
    ssec.append(msg.header.stamp.secs)

for topic,msg,t in walking.read_messages(topics=['/GPS']):
    wutmelis.append(msg.utm_easting)
    wutmnlis.append(msg.utm_northing)
    wsec.append(msg.header.stamp.secs)

avgse=[i-min(sutmelis) for i in sutmelis]
avgsn=[i-min(sutmnlis) for i in sutmnlis]
avgwe=[i-min(wutmelis) for i in wutmelis]
avgwn=[i-min(wutmnlis) for i in wutmnlis]

plt.subplot(2,2,1)
#plt.axhline(6694.93,color='g')
plt.plot(ssec,avgse,'r',label='UTM-Easting')
#plt.axhline(46743.4686,color='g')
plt.plot(ssec,avgsn,'b',label='UTM-Northing')
plt.xlim(51800,52400)
plt.ylim(-0.01, 0.07)
plt.title("Stationary Data")
plt.ylabel("UTM-Easting, UTM-Northing")
plt.xlabel("Time")

plt.subplot(2,2,2)
plt.plot(sutmelis,sutmnlis,'r')
plt.xlim(6694.85, 6695)
plt.ylim(46743.4, 46743.5)
plt.title("Stationary Data")
plt.ylabel("UTM-Northing")
plt.xlabel("UTM-Easting")

plt.subplot(2,2,3)
#plt.axhline(6694.93,color='g')
plt.plot(wsec,avgwe,'r',label='UTM-Easting')
#plt.axhline(46743.4686,color='g')
plt.plot(wsec,avgwn,'b',label='UTM-Northing')
#plt.xlim(51800,52400)
#plt.ylim(-0.01, 0.07)
plt.title("Walking Data")
plt.ylabel("UTM-Easting, UTM-Northing")
plt.xlabel("Time")

plt.subplot(2,2,4)
plt.plot(wutmelis,wutmnlis,'r')
#plt.plot(wsec,wutmelis,'r')
#plt.xlim(68500,69100)
plt.title("Walking Data")
plt.xlabel("UTM-Easting")
plt.ylabel("UTM-Northing")

plt.show()
stationary.close
walking.close
