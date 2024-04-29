#!/usr/bin/env python3
import rospy
import serial
import utm
import sys
import numpy as np
from std_msgs.msg import Float64,Float32
from imu_driver.msg import imu_msg

if __name__ == '__main__':
    if len(sys.argv)>0:
        rospy.loginfo(sys.argv[1])

    SENSOR_NAME = 'imu'
    rospy.init_node("imu")
    serial_port = rospy.get_param('~port',sys.argv[1])
    serial_baud = rospy.get_param('~baudrate',115200)
    #sampling_rate = rospy.get_param('~sampling_rate',20.0)

    port = serial.Serial(serial_port, serial_baud, timeout=3.)
    imu=imu_msg()
    imu_pub=rospy.Publisher(SENSOR_NAME,imu_msg,queue_size=5)
    imu.Header.frame_id='IMU1_Frame'
    try:
        checksum=0
        for i in "VNWRG,07,40":
            checksum ^= ord(i)
        a='$VNWRG,07,40*'+str(checksum)
        port.write('$VNWRG,07,40*XX'.encode())

        while not rospy.is_shutdown():
        #rospy.sleep(1.)
            line = port.readline()
            line1=str(line)
            line1=line1.split(',')
            print(line)
            garbage=["\\x00","\\n","\\r","\\r\\n","'"]
            for i in garbage:
                for j in range(0,len(line1)):
                    if i in line1[j]:
                        line1[j]=line1[j].replace(i,"")
            print(line1[0])
            if line1[0]=="b$VNYMR":
                roll=float(line1[3])
                pitch=float(line1[2])
                yaw=float(line1[1])
                x = np.sin(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) - np.cos(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
                y = np.cos(roll/2) * np.sin(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.cos(pitch/2) * np.sin(yaw/2)
                z = np.cos(roll/2) * np.cos(pitch/2) * np.sin(yaw/2) - np.sin(roll/2) * np.sin(pitch/2) * np.cos(yaw/2)
                w = np.cos(roll/2) * np.cos(pitch/2) * np.cos(yaw/2) + np.sin(roll/2) * np.sin(pitch/2) * np.sin(yaw/2)
                
                imu.Header.stamp.secs=rospy.get_rostime().secs
                imu.Header.stamp.nsecs=rospy.get_rostime().nsecs
                imu.IMU.header.seq+=1
                imu.IMU.header.frame_id="IMU"
                imu.IMU.header.stamp.secs=rospy.get_rostime().secs
                imu.IMU.header.stamp.nsecs=rospy.get_rostime().nsecs
                imu.MagField.header.seq+=1
                imu.MagField.header.frame_id="MagField"
                imu.MagField.header.stamp.secs=rospy.get_rostime().secs
                imu.MagField.header.stamp.nsecs=rospy.get_rostime().nsecs
                imu.IMU.orientation.x=x
                imu.IMU.orientation.y=y
                imu.IMU.orientation.z=z
                imu.IMU.orientation.w=w
                imu.MagField.magnetic_field.x=float(line1[4])
                imu.MagField.magnetic_field.y=float(line1[5])
                imu.MagField.magnetic_field.z=float(line1[6])
                imu.IMU.linear_acceleration.x=float(line1[7])
                imu.IMU.linear_acceleration.y=float(line1[8])
                imu.IMU.linear_acceleration.z=float(line1[9])
                imu.IMU.angular_velocity.x=float(line1[10])
                imu.IMU.angular_velocity.y=float(line1[11])
                imu.IMU.angular_velocity.z=float(line1[12][0:9])
                rospy.loginfo(imu)
                imu_pub.publish(imu)

    except rospy.ROSInterruptException:
                port.close()
    except serial.serialutil.SerialException:
        rospy.loginfo("Shutting down node...")