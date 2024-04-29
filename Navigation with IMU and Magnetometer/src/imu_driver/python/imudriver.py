#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# --- RSN - EECE 5554 assignment LAB3 Srijan ---

import rospy
import utm
import serial
import sys
import glob
from std_msgs.msg import Float64, String, Float32
from imu_driver.msg import imu_msg
import numpy as np

def euler_to_quarternion(roll,pitch,yaw):
    """
    Takes roll, pitch, yaw values as float in degrees and converts to radians, 
    Then, calculates quaternion qx, qy, qz, qx as type float
    """
    # Convert degrees to radians
    roll = roll*np.pi/180
    pitch = pitch*np.pi/180
    yaw = yaw*np.pi/180

    
    # use quaternion conversion
    qx = (np.sin(roll/2) * np.cos(pitch/2) * np.cos(yaw/2)) - (np.cos(roll/2) * np.sin(pitch/2) * np.sin(yaw/2))
    qy = (np.cos(roll/2) * np.sin(pitch/2) * np.cos(yaw/2)) + (np.sin(roll/2) * np.cos(pitch/2) * np.sin(yaw/2))
    qz = (np.cos(roll/2) * np.cos(pitch/2) * np.sin(yaw/2)) - (np.sin(roll/2) * np.sin(pitch/2) * np.cos(yaw/2))
    qw = (np.cos(roll/2) * np.cos(pitch/2) * np.cos(yaw/2)) + (np.sin(roll/2) * np.sin(pitch/2) * np.sin(yaw/2))

    return qx,qy,qz,qw

def available_port(argument):

    available_ports = glob.glob(argument)

    # Filter out and prioritize USB ports
    usb_ports = [port for port in available_ports if "ttyUSB" in port]
    usb_ports.sort()

    if usb_ports:
        rospy.logwarn("Port set to - %s", usb_ports[0])
        return usb_ports[0]  # Return the first available port
    else:
        raise Exception("No available USB port found.") 

def driver():
    rospy.init_node('imu_node', anonymous=True)
    pub = rospy.Publisher("imu",imu_msg,queue_size=10)
    msg = imu_msg()

    if len(sys.argv)>1:
        if "pts" in sys.argv[1]:
            port = rospy.get_param('~port', sys.argv[1])
        else:
            port = rospy.get_param('~port', available_port(sys.argv[1]))
    else:
        port = rospy.get_param('~port','/dev/ttyUSB0')

    baud_rate = rospy.get_param('~baudrate',115200)

    rate = rospy.Rate(40)
    # Serial port is initialised for communication with sensor
    serial_port = serial.Serial(port, baud_rate, timeout=3)
    sequence_id = 1
    
    # defining string for setting frequency and receiving data
    hertz = "$VNWRG,07,40*xx"
    time = rospy.get_rostime()
    # writing string to register in byte format
    serial_port.write(hertz.encode('utf-8'))
    
    try:    
        while not rospy.is_shutdown():
            rospy.logwarn_once("ROS Driver started")
            recieved_line = serial_port.readline().decode('utf-8').replace("\r\n","").replace("\x00","").replace("\r","")
            final_line = recieved_line.split('*')
            data = final_line[0].split(',')
            print(data)
            if '$VNYMR' not in data[0]:
                rospy.logwarn('Different data type detected.')
            elif data[2] == '':
                rospy.logwarn('Empty Data Recieved.')
            elif len(data) != 13:
                rospy.logwarn('Data is in wrong shape! Too many or too few arguments.')
            elif "$VNYMR" in data:
                print(data)
                 # store required values collected into corresponding variables
                yaw = float(data[1])
                pitch = float(data[2])
                roll = float(data[3])
                qx,qy,qz,qw = euler_to_quarternion(roll=roll, yaw=yaw, pitch=pitch)

                mag_x = float(data[4])
                mag_y = float(data[5])
                mag_z = float(data[6])

                acc_x = float(data[7])
                acc_y = float(data[8])
                acc_z = float(data[9])

                ang_x = float(data[10])
                ang_y = float(data[11])
                ang_z = float(data[12])

                # now  = rospy.get_rostime() - time

                # Putting everything in the message and publishing the msg
                msg.Header.seq = sequence_id
                msg.Header.stamp.secs = rospy.get_rostime().secs
                msg.Header.stamp.nsecs = rospy.get_rostime().nsecs
                msg.Header.frame_id = 'IMU1_Frame'   
                msg.IMU.orientation.w = qw
                msg.IMU.orientation.x = qx
                msg.IMU.orientation.y = qy
                msg.IMU.orientation.z = qz

                msg.IMU.linear_acceleration.x = acc_x
                msg.IMU.linear_acceleration.y = acc_y
                msg.IMU.linear_acceleration.z = acc_z

                msg.IMU.angular_velocity.x = ang_x
                msg.IMU.angular_velocity.y = ang_y
                msg.IMU.angular_velocity.z = ang_z

                msg.MagField.magnetic_field.x = mag_x
                msg.MagField.magnetic_field.y = mag_y
                msg.MagField.magnetic_field.z = mag_z

                msg.raw_data = recieved_line
                
                pub.publish(msg)
                rate.sleep()
                sequence_id+=1
          
            else:
                rospy.logwarn("No IMU Data Recieved")
                        
    except serial.serialutil.SerialException:
        rospy.loginfo("Serial Exception, Shutting down GPS node")
        serial_port.close()
    except rospy.ROSInterruptException:
        print("ROS error, failed")
        pass


if __name__ == '__main__':
    try:
        driver()
    except rospy.ROSInterruptException:
        pass