#!/usr/bin/env python
__author__ = 'tanjaymal'

import rospy
from geometry_msgs.msg import Point
from geometry_msgs.msg import Twist
from std_msgs.msg import String
import time
# Import sthe messages we're interested in sending and receiving
from geometry_msgs.msg import Twist  	 # for sending commands to the drone
from std_msgs.msg import Empty       	 # for land/takeoff/emergency
from ardrone_autonomy.msg import Navdata # for receiving navdata feedback

# An enumeration of Drone Statuses
from drone_status import DroneStatus

p = Point()

y_left =0.00
y_right=0.00
x_right=0.00
z_right=0.00
y_torso=0.00
x_torso=0.00
z_torso=0.00
pose=Twist()
st=String()
lt=String()
rt=String()


def EEG_drone():
  pubLand=rospy.Publisher('/ardrone/land',Empty)
  pubReset   = rospy.Publisher('/ardrone/reset',Empty)
  pubTakeoff= rospy.Publisher('/ardrone/takeoff',Empty)
  pubCommand = rospy.Publisher('/cmd_vel',Twist)
  pub=rospy.Publisher('/turtle1/cmd_vel',Twist)

  rospy.Subscriber("/skeleton", Skeleton, callback)
  rospy.init_node('EEG_drone')

  
  
  global count
  global x_left
  global y_left
  global x_right
  global y_right
  global x_torso
  global y_torso
  lt="left_hand"
  count = 0
  r = rospy.Rate(10) # 10hz
  while not rospy.is_shutdown():
       txt=open("/home/jay/bobos/vals.txt",'r+')    
       l= txt.read()
       txt.truncate(0)
       txt.close() 
      
       time.sleep(0.5)
       uniq=Empty()
       vel=Twist()
        
       if l == 't' :      
            #left hand to take off   
            rospy.loginfo("takeoff")
            pubTakeoff.publish(uniq)  
       
       elif l==  'g' :
            #left hand to land
            rospy.loginfo("land")
            pubLand.publish(uniq)  
       
       elif l== 'b' :
            #right hand pitch backward
            vel.linear.x=-0.25
            vel.linear.y=0
            vel.linear.z=0
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)       
            rospy.loginfo("back")
    
       elif l== 'f':
            #right hand pitch forward
            vel.linear.x=0.25
            vel.linear.y=0
            vel.linear.z=0
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("forward")

       elif l== 'r':

            #right hand roll right 
            vel.linear.x=0
            vel.linear.y=-0.25
            vel.linear.z=0
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("right")

       elif l=='l':
            #right hand roll left
            vel.linear.x=0
            vel.linear.y=0.25
            vel.linear.z=0
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("left")

       elif l== 'u':
            #right hand roll left
            count +=1
            vel.linear.x=0
            vel.linear.y=0
            vel.linear.z=0.20
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("up")
    
       elif l== 'd':
            #right hand roll left
            count-=1
            vel.linear.x=0
            vel.linear.y=0
            vel.linear.z=-0.20
            vel.angular.z=0
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("down")

       elif l== 'x':
            #right hand roll left
            vel.linear.x=0
            vel.linear.y=0
            vel.linear.z=0
            vel.angular.z=0.20
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("yaw left")
    
       elif l== 'y':
            #right hand roll left
            vel.linear.x=0
            vel.linear.y=0
            vel.linear.z=0
            vel.angular.z=-0.20
            pubCommand.publish(vel)
            pub.publish(vel)
            rospy.loginfo("yaw right")

       elif count == 9:
           for i in range(4):
              vel.linear.x=0
              vel.linear.y=0
              vel.linear.z=-0.20
              vel.angular.z=0
              pubCommand.publish(vel)
              pub.publish(vel)
              rospy.loginfo("down")
              count-=1
 
       elif count == -6:
           for i in range(4):
              count +=1
              vel.linear.x=0
              vel.linear.y=0
              vel.linear.z=0.20
              vel.angular.z=0
              pubCommand.publish(vel)
              pub.publish(vel)
              rospy.loginfo("up")

       
       else:
           # no motion no command
           vel.linear.x=0
           vel.linear.y=0
           vel.linear.z=0
           vel.angular.z=0
           pubCommand.publish(vel)        
           pub.publish(vel)
       
      
      
       	
       
       rospy.sleep(0.1)
       


if __name__ == '__main__':
    try:
        EEG_drone()
    except rospy.ROSInterruptException: 
        pass
