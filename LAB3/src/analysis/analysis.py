#!/usr/bin/env python3

import rosbag
import math
from matplotlib import pyplot as plt
import matplotlib
import numpy as np
from scipy.io import savemat


stationary = rosbag.Bag('aayush_stationary_data.bag')
savemat('stationary.mat',stationary)
orientation_x=[]
orientation_y=[]
orientation_z=[]
orientation_w=[]

linearacc_x=[]
linearacc_y=[]
linearacc_z=[]

angularvel_x=[]
angularvel_y=[]
angularvel_z=[]

magfield_x=[]
magfield_y=[]
magfield_z=[]

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

    s=float(str(msg.header.stamp.secs)+"."+str(msg.header.stamp.nsecs))
    sec.append(s)

roll=[]
for i in range(0,len(orientation_x)):
    t0 = +2.0 * (orientation_w[i] * orientation_x[i] + orientation_y[i] * orientation_z[i])
    t1 = +1.0 - 2.0 * (orientation_x[i] * orientation_x[i] + orientation_y[i] * orientation_y[i])
    roll.append(math.degrees(math.atan2(t0, t1)))
roll_mean=np.mean(roll)
roll_std=np.std(roll)
print(roll_mean,roll_std)


pitch=[]
for i in range(0,len(orientation_y)):
    t2 = +2.0 * (orientation_w[i] * orientation_y[i] - orientation_z[i] * orientation_x[i])
    t2 = +1.0 if t2 > +1.0 else t2
    t2 = -1.0 if t2 < -1.0 else t2
    pitch.append(math.degrees(math.asin(t2)))
pitch_mean=np.mean(pitch)
pitch_std=np.std(pitch)
print(pitch_mean,pitch_std)

yaw=[]
for i in range(0,len(orientation_z)):
    t3 = +2.0 * (orientation_w[i] * orientation_z[i] + orientation_x[i] * orientation_y[i])
    t4 = +1.0 - 2.0 * (orientation_y[i] * orientation_y[i] + orientation_z[i] * orientation_z[i])
    yaw.append(math.degrees(math.atan2(t3, t4)))
yaw_mean=np.mean(yaw)
yaw_std=np.std(yaw)
print(yaw_mean,roll_std)

linearacc_x_mean=np.mean(linearacc_x)
linearacc_x_std=np.std(linearacc_x)
linearacc_y_mean=np.mean(linearacc_y)
linearacc_y_std=np.std(linearacc_y)
linearacc_z_mean=np.mean(linearacc_z)
linearacc_z_std=np.std(linearacc_z)

angularvel_x_mean=np.mean(angularvel_x)
angularvel_x_std=np.std(angularvel_x)
angularvel_y_mean=np.mean(angularvel_y)
angularvel_y_std=np.std(angularvel_y)
angularvel_z_mean=np.mean(angularvel_z)
angularvel_z_std=np.std(angularvel_z)

magfield_x_mean=np.mean(magfield_x)
magfield_x_std=np.std(magfield_x)
magfield_y_mean=np.mean(magfield_y)
magfield_y_std=np.std(magfield_y)
magfield_z_mean=np.mean(magfield_z)
magfield_z_std=np.std(magfield_z)

plt.subplot(3,1,1)
plt.plot(sec,roll)
plt.ylabel('Roll(in degrees)')
plt.subplot(3,1,2)
plt.plot(sec,pitch)
plt.ylabel('Pitch(in degrees)')
plt.subplot(3,1,3)
plt.plot(sec,yaw)
plt.ylabel('Yaw(in degrees)')
plt.xlabel('Time (in seconds)')
plt.show()

plt.subplot(3,1,1)
plt.hist(roll,50)
plt.axvline(x=roll_mean,ymin=0,ymax=max(roll),color='r')
plt.axvline(x=roll_mean-roll_std,ymin=0,ymax=max(roll),color='g',linestyle='--')
plt.axvline(x=roll_mean+roll_std,ymin=0,ymax=max(roll),color='g',linestyle='--')
plt.xlabel('Roll (in degrees)')
plt.subplot(3,1,2)
plt.hist(pitch,50)
plt.axvline(x=pitch_mean,ymin=0,ymax=max(pitch),color='r')
plt.axvline(x=pitch_mean-pitch_std,ymin=0,ymax=max(pitch),color='g',linestyle='--')
plt.axvline(x=pitch_mean+pitch_std,ymin=0,ymax=max(pitch),color='g',linestyle='--')
plt.ylabel('Frequency')
plt.xlabel('Pitch (in degrees)')
plt.subplot(3,1,3)
plt.hist(yaw,50)
plt.axvline(x=yaw_mean,ymin=0,ymax=max(yaw),color='r')
plt.axvline(x=yaw_mean-yaw_std,ymin=0,ymax=max(yaw),color='g',linestyle='--')
plt.axvline(x=yaw_mean+yaw_std,ymin=0,ymax=max(yaw),color='g',linestyle='--')
plt.xlabel('Yaw (in degrees)')
plt.show()

plt.subplot(3,1,1)
plt.plot(sec,linearacc_x)
plt.ylabel('Linear Acceleration X')
plt.subplot(3,1,2)
plt.plot(sec,linearacc_y)
plt.ylabel('Linear Acceleration Y')
plt.subplot(3,1,3)
plt.plot(sec,linearacc_z)
plt.ylabel('Linear Acceleration Z')
plt.xlabel('Time (in seconds)')
plt.show()

plt.subplot(3,1,1)
plt.hist(linearacc_x,100)
plt.axvline(x=linearacc_x_mean,color='r')
plt.axvline(x=linearacc_x_mean-linearacc_x_std,color='g',linestyle='--')
plt.axvline(x=linearacc_x_mean+linearacc_x_std,color='g',linestyle='--')
plt.xlabel('Linear Acceleration X')
plt.subplot(3,1,2)
plt.hist(linearacc_y,100)
plt.axvline(x=linearacc_y_mean,color='r')
plt.axvline(x=linearacc_y_mean-linearacc_y_std,color='g',linestyle='--')
plt.axvline(x=linearacc_y_mean+linearacc_y_std,color='g',linestyle='--')
plt.ylabel('Frequency')
plt.xlabel('Linear Acceleration Y')
plt.subplot(3,1,3)
plt.hist(linearacc_z,100)
plt.axvline(x=linearacc_z_mean,color='r')
plt.axvline(x=linearacc_z_mean-linearacc_z_std,color='g',linestyle='--')
plt.axvline(x=linearacc_z_mean+linearacc_z_std,color='g',linestyle='--')
plt.xlabel('Linear Acceleration Z')
plt.show()

plt.subplot(3,1,1)
plt.plot(sec,angularvel_x)
plt.ylabel('Angular Velocity X')
plt.subplot(3,1,2)
plt.plot(sec,angularvel_y)
plt.ylabel('Angular Velocity Y')
plt.subplot(3,1,3)
plt.plot(sec,angularvel_z)
plt.ylabel('Angular Velocity Z')
plt.xlabel('Time (in seconds)')
plt.show()

plt.subplot(3,1,1)
plt.hist(angularvel_x,100)
plt.axvline(x=angularvel_x_mean,color='r')
plt.axvline(x=angularvel_x_mean-angularvel_x_std,color='g',linestyle='--')
plt.axvline(x=angularvel_x_mean+angularvel_x_std,color='g',linestyle='--')
plt.xlabel('Angular Velocity X')
plt.subplot(3,1,2)
plt.hist(angularvel_y,100)
plt.axvline(x=angularvel_y_mean,color='r')
plt.axvline(x=angularvel_y_mean-angularvel_y_std,color='g',linestyle='--')
plt.axvline(x=angularvel_y_mean+angularvel_y_std,color='g',linestyle='--')
plt.ylabel('Frequency')
plt.xlabel('Angular Velocity Y')
plt.subplot(3,1,3)
plt.hist(angularvel_z,100)
plt.axvline(x=angularvel_z_mean,color='r')
plt.axvline(x=angularvel_z_mean-angularvel_z_std,color='g',linestyle='--')
plt.axvline(x=angularvel_z_mean+angularvel_z_std,color='g',linestyle='--')
plt.xlabel('Angular Velocity Z')
plt.show()

plt.subplot(3,1,1)
plt.plot(sec,magfield_x)
plt.ylabel('Magnetic Field X')
plt.subplot(3,1,2)
plt.plot(sec,magfield_y)
plt.ylabel('Magnetic Field Y')
plt.subplot(3,1,3)
plt.plot(sec,magfield_z)
plt.ylabel('Magnetic Field Z')
plt.xlabel('Time (in seconds)')
plt.show()

plt.subplot(3,1,1)
plt.hist(magfield_x,100)
plt.axvline(x=magfield_x_mean,color='r')
plt.axvline(x=magfield_x_mean-magfield_x_std,color='g',linestyle='--')
plt.axvline(x=magfield_x_mean+magfield_x_std,color='g',linestyle='--')
plt.xlabel('Magnetic Field X')
plt.subplot(3,1,2)
plt.hist(magfield_y,100)
plt.axvline(x=magfield_y_mean,color='r')
plt.axvline(x=magfield_y_mean-magfield_y_std,color='g',linestyle='--')
plt.axvline(x=magfield_y_mean+magfield_y_std,color='g',linestyle='--')
plt.ylabel('Frequency')
plt.xlabel('Magnetic Field X')
plt.subplot(3,1,3)
plt.hist(magfield_z,100)
plt.axvline(x=magfield_z_mean,color='r')
plt.axvline(x=magfield_z_mean-magfield_z_std,color='g',linestyle='--')
plt.axvline(x=magfield_z_mean+magfield_z_std,color='g',linestyle='--')
plt.xlabel('Magnetic Field X')
plt.show()

stationary.close
