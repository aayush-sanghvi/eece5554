import rospy
from std_msgs.msg import String

def callback(data):
    rospy.loginfo(rospy.get_caller_id() + 'Hey! I am listening')

def test_sub():
    rospy.init_node('sub', anonymous=True)
    rospy.Subscriber('chatter', String, callback)

    rospy.spin()

if __name__ == '__main__':
    test_sub()
