import rospy
from std_msgs.msg import String

def test_pub():
    pub = rospy.Publisher('chatter', String, queue_size=10)
    rospy.init_node('pub', anonymous=True)
    rate = rospy.Rate(10) # 10hz
    while not rospy.is_shutdown():
        hello_str = "Hi! Are you listening?"
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()

if __name__ == '__main__':
    try:
        test_pub()
    except rospy.ROSInterruptException:
        pass
