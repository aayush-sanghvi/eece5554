#!/usr/bin/env python3

import rosbag
import math
from matplotlib import pyplot as plt
import matplotlib
import numpy as np
from scipy.optimize import curve_fit
import scipy
from geopy.distance import geodesic

def f(data,r):
    x,y=data
    return np.sqrt((x)**2 + (y)**2)-r

stationary = rosbag.Bag('imu_data.bag')
gpsdata=rosbag.Bag('gps_data.bag')
print(stationary)
print(gpsdata)
#Variable declaration
orientation_x,orientation_y,orientation_z,orientation_w=[],[],[],[]
linearacc_x,linearacc_y,linearacc_z=[],[],[]
angularvel_x,angularvel_y,angularvel_z=[],[],[]
magfield_x,magfield_y,magfield_z=[],[],[]
cal_mag_x,cal_mag_y,cir_x,cir_y, radius= [],[],[],[],[]
path_mag_x,path_mag_y,path_mag_z = [],[],[]
sec=[]


for topic,msg,t in stationary.read_messages(topics=['/imu']):
    orientation_x.append(msg.IMU.orientation.x)
    orientation_y.append(msg.IMU.orientation.y)
    orientation_z.append(msg.IMU.orientation.z)
    orientation_w.append(msg.IMU.orientation.w)

    linearacc_x.append(msg.IMU.linear_acceleration.x)
    linearacc_y.append(msg.IMU.linear_acceleration.y)
    linearacc_z.append(msg.IMU.linear_acceleration.z)

    angularvel_x.append(msg.IMU.angular_velocity.x)
    angularvel_y.append(msg.IMU.angular_velocity.y)
    angularvel_z.append(msg.IMU.angular_velocity.z)

    magfield_x.append(msg.MagField.magnetic_field.x)
    magfield_y.append(msg.MagField.magnetic_field.y)
    magfield_z.append(msg.MagField.magnetic_field.z)

    tym1 =str(float(str(t))-1.698267706*1e+18)
    sec.append(float(tym1[:3]+'.'+tym1[-11:-2])-100.673790976)
roll=[]
for i in range(0,len(orientation_x)):
    t0 = +2.0 * (orientation_w[i] * orientation_x[i] + orientation_y[i] * orientation_z[i])
    t1 = +1.0 - 2.0 * (orientation_x[i] * orientation_x[i] + orientation_y[i] * orientation_y[i])
    roll.append(math.degrees(math.atan2(t0, t1)))
pitch=[]
for i in range(0,len(orientation_y)):
    t2 = +2.0 * (orientation_w[i] * orientation_y[i] - orientation_z[i] * orientation_x[i])
    t2 = +1.0 if t2 > +1.0 else t2
    t2 = -1.0 if t2 < -1.0 else t2
    pitch.append(math.degrees(math.asin(t2)))
yaw=[]
for i in range(0,len(orientation_z)):
    t3 = +2.0 * (orientation_w[i] * orientation_z[i] + orientation_x[i] * orientation_y[i])
    t4 = +1.0 - 2.0 * (orientation_y[i] * orientation_y[i] + orientation_z[i] * orientation_z[i])
    yaw.append(math.degrees(math.atan2(t3, t4)))

#circular data extraction from complete rosbag
for i in range(20036):
    if 12.39<= sec[i]<= 71.71:
        cir_x.append(magfield_x[i])
        cir_y.append(magfield_y[i])

#hard iron offset setting
for i in range(20036):
    if 12.39<= sec[i]<= 71.71:
        cal_mag_x.append(magfield_x[i]-((max(cir_x)+min(cir_x))/2))
        cal_mag_y.append(magfield_y[i]-((max(cir_y)+min(cir_y))/2))
print()
for i in range(len(cal_mag_x)):
    radius.append(np.sqrt((cal_mag_x[i]*cal_mag_x[i]) + (cal_mag_y[i]*cal_mag_y[i])))

x_major=max(cal_mag_x)
y_major=max(cal_mag_y)

r_major=max(radius)
r_minor=min(radius)
sig=1.5*(r_minor/r_major)
mat=[[1,0],[0,sig]]

V=[cal_mag_x,cal_mag_y]

r=math.sqrt((x_major**2)+(y_major**2))
t=np.arcsin(y_major/r)

rot=np.matmul(mat,V)
R=[[np.cos(-t),np.sin(t)],[np.sin(-t),np.cos(-t)]]
V1=np.matmul(R,rot)

#Least-fit squares method to obtain soft iron calibration
#1st quadrant
x1,y1,z1=[],[],[]
for i in range(len(cal_mag_x)):
    z1.append(f((cal_mag_x[i],cal_mag_y[i]),sum(radius)/len(radius)))
for i in range(len(cal_mag_x)):
    x1.append(cal_mag_x[i]+z1[i])
    y1.append(cal_mag_y[i]+z1[i])

#3rd quadrant
x3,y3,z3=[],[],[]
for i in range(len(cal_mag_x)):
    z3.append(f((x1[i],y1[i]),sum(radius)/len(radius)))
for i in range(len(cal_mag_x)):
    x3.append(x1[i]-z3[i])
    y3.append(y1[i]-z3[i])

#2nd quadrant
x2,y2,z2=[],[],[]
for i in range(len(cal_mag_x)):
    z2.append(f((x3[i],y3[i]),sum(radius)/len(radius)))
for i in range(len(cal_mag_x)):
    x2.append(x3[i]-z2[i])
    y2.append(y3[i]+z2[i])

#4th quadrant
x4,y4,z4=[],[],[]
for i in range(len(cal_mag_x)):
    z4.append(f((x2[i],y2[i]),sum(radius)/len(radius)))
for i in range(len(cal_mag_x)):
    x4.append(x2[i]+z4[i])
    y4.append(y2[i]-z4[i])



#plotting of before, hard iron correction, soft iron correction
plt.grid(visible='True')
#plt.plot(V1[0],V1[1])
#plt.plot(mat[0],mat[1],label='softiron')
circle = plt.Circle((0, 0), sum(radius)/len(radius), fill=False, linewidth=2, label='Best Fit Cicle')
plt.gca().add_artist(circle)
plt.plot(cir_x,cir_y, color='blue',label='before')
plt.plot(cal_mag_x,cal_mag_y,color='red',label='hard iron')
plt.plot(x4,y4,color= 'green',label='soft iron')
plt.ylabel('MF Y-axis')
plt.xlabel('MF X-axis')
plt.title('Hard Iron & Soft Iron correction')
plt.legend()
plt.axis("equal")
plt.show()

#Path Data Extraction
path_start,path_end=0,0
path_x,path_y =[],[]
path_yaw, path_av_z = [],[]
for i in range(20036):
    if 71.715<= sec[i]<= 436.82:
        # print(sec[i])
        if path_end == 0:
            path_start = i
        path_end+=1
        path_x.append(magfield_x[i]-0.3070) # Mag x with hard iron
        path_y.append(magfield_y[i]-0.71) # Mag y with hard iron
        path_yaw.append(yaw[i]*-1) # Raw Yaw
        path_av_z.append(-angularvel_z[i]) # Gyro Z axis


#yaw estimation of Magnetometer
scaling_factor = 45
v2 = [path_x, path_y]
mat2 = np.matmul(mat, v2)
sp_mag_x,sp_mag_y = mat2[0],mat2[1]
normalized_mag_vecs = np.array([(x / np.sqrt(x**2 + y**2), y / np.sqrt(x**2 + y**2)) for x, y in zip(sp_mag_x, sp_mag_y)])
yaw_angles_from_mag = np.array([math.atan2(y, x) for x, y in normalized_mag_vecs])
yaw_cali_unwrapped = np.unwrap(yaw_angles_from_mag)*scaling_factor
# Yaw estimation of Gyro Z axis
gyro_yaw = scipy.integrate.cumtrapz(path_av_z,initial=0)
# Raw Yaw estimation of Raw data
yaw_unwrapped = np.unwrap(path_yaw)
gyro_unwrapped=np.unwrap(gyro_yaw)

plt.plot(yaw_cali_unwrapped, label='magnetic Yaw', c='orange')
plt.plot(gyro_unwrapped, label='Gyro Yaw', c='blue')
plt.plot(yaw_unwrapped, label='Raw Yaw', c='red')
plt.grid(color='grey', linestyle='--', linewidth=1)
plt.title('Estimation of Yaw for Magnetometer')
plt.legend()
plt.xlabel('samples')
plt.ylabel('Yaw')
plt.show()

#Filtering 
lpf = scipy.signal.filtfilt(*scipy.signal.butter(3, 0.1, "lowpass",fs = 40, analog=False), yaw_cali_unwrapped)
hpf = scipy.signal.filtfilt(*scipy.signal.butter(3, 0.0001, 'highpass', fs = 40, analog=False), gyro_yaw)
alpha = 0.75
yaw_filtered = []
yaw_filtered = np.append(yaw_filtered,0)
for i in range(len(hpf)-1):
  yaw_filtered = np.append(yaw_filtered, alpha*(yaw_filtered[i] + hpf[i+1]*0.05) + ((1-alpha)*lpf[i+1]))

#plotting Filters
plt.plot(yaw_filtered, label='Complementary Filter')
plt.plot(lpf, label='Low Pass Filter')
plt.plot(hpf, label='High Pass Filter')
plt.legend(loc='lower right', fontsize='x-large')
plt.grid(color='grey', linestyle='--', linewidth=1)
plt.xlabel('Samples')
plt.ylabel('Yaw')
plt.title(' Complementary Filter Yaw')
plt.show()

#Linear Acceleration Data Extraction
la_x,la_y,la_end=[],[],[]
la_start=0
for i in range(20036):
    if 150.715<= sec[i]:
        # print(sec[i])
        if la_end == 0:
            la_start = i
        la_end.append(sec[i])
        la_x.append(linearacc_x[i])
        la_y.append(linearacc_y[i])
        

#Windowing mean 
mean_val = []
for i in range(int(len(la_x)/10)):
    mean_val.append(np.mean(la_x[i*10:(i+1)*10]))
    for j in range(10):
        la_x[i*10+j]-=mean_val[i]

#GPS velocity
velocity_estimation = scipy.integrate.cumtrapz(la_x,la_end)
vel_y=scipy.integrate.cumtrapz(la_x,la_end)
gps_lat,gps_lon,time = [],[],[]
utm_e,utm_n = [],[]
for topic,msg,t in gpsdata.read_messages(topics=['/gps']):
    gps_lat.append(msg.latitude)
    gps_lon.append(msg.longitude)
    time.append(msg.Header.stamp.secs-1698267659)
    utm_e.append(msg.utm_easting)
    utm_n.append(msg.utm_northing)



vx = []
for i in range(len(gps_lon)-1):
    distance = geodesic([gps_lat[i], gps_lon[i]],[gps_lat[i+1], gps_lon[i+1]]).meters
    vx.append(distance/time[i])
vx.append(0)
velocity = [] #is in m/s
for i in range(len(vx)):
    velocity.append(vx[i])
plt.figure(figsize=(16, 8))
plt.plot(time,velocity,c='Orange',label='Gps Velocity')
plt.plot(la_end[1:],velocity_estimation,c='blue',label='Velocity Estimation')
plt.legend(fontsize='x-large')
plt.grid(color='grey', linestyle='--', linewidth=1)
plt.xlabel('Time(Seconds)')
plt.ylabel('Velocity(m/s)')
plt.title(' Complementary Filter Yaw')
plt.show()


dis_x=scipy.integrate.cumtrapz(velocity_estimation,initial=0)
#Linear Acceleration Data Extraction
xdot1,la_end,av_z,y_obs,mf_x=[],[],[],[],[]
ox,oy,oz,ow=[],[],[],[]
la_start=0
for i in range(20036):
    if 150<= sec[i]:
        # print(sec[i])
        if la_end == 0:
            la_start = i
        la_end.append(sec[i])
        xdot1.append(linearacc_x[i])
        av_z.append(angularvel_z[i])
        y_obs.append(linearacc_y[i])
        mf_x.append(magfield_x[i])
        ox.append(orientation_x[i])
        oy.append(orientation_y[i])
        oz.append(orientation_z[i])
        ow.append(orientation_w[i])


yaw=[]
for i in range(len(oz)):
    t3 = +2.0 * (ow[i] * oz[i] + ox[i] * oy[i])
    t4 = +1.0 - 2.0 * (oy[i] * oy[i] + oz[i] * oz[i])
    yaw.append(math.degrees(math.atan2(t3, t4)))
    
xdot=scipy.integrate.cumtrapz(xdot1)
y=av_z[1:]*xdot
plt.plot(la_end,y_obs,label='y observed')
plt.plot(la_end[1:],-y/1000,label='y calculated')
plt.legend()
plt.show()

fv=np.unwrap(velocity_estimation)
fy=np.unwrap(vel_y)
print(fv)
mg=yaw
rot=1
print(len(fv),len(yaw))
ve,vn=[],[]
for i in range(1,len(mg)-1):
    unit1 = np.cos(mg[i]+rot)*fv[i]
    unit2 = -np.sin(mg[i]+rot)*fv[i]
    unit3 = np.cos(mg[i]+rot)*fv[i]
    unit4 = np.sin(mg[i]+rot)*fv[i]
    ve.append(mg[i]+rot*fv[i]-mg[i]+rot*fv[i])
    vn.append(mg[i]+rot*fy[i]+mg[i]+rot*fy[i])


xe = scipy.integrate.cumtrapz(ve)
xn = scipy.integrate.cumtrapz(vn)

plt.figure(1)
plt.plot((xe/(10**6))/2,xn/(10**5), c='crimson')
plt.figure(2)
plt.grid(color='grey', linestyle='--', linewidth=1)
plt.plot(utm_n, utm_e, c ='palevioletred')
plt.title('UTME vs UTMN')
plt.xlabel('e')
plt.ylabel('n')
plt.plot()
plt.show()


gpsdata.close
stationary.close


