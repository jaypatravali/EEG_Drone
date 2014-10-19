EEG_Drone
=========

Brain EEG signals controled AR Drone



----------------------
We keep one PC running MATLAB connected with the Neurosky Mindwave headset and process brain EEG signals for attention values. With the blinks we generate bit patterns for directional control

On the second PC we run ROS-Hydro on Linux Ubuntu 12.04 and rosrun the neurosky.py file to fly the drone


>> The two PC's are connected by LAN cable and  we enable sharing. The values generated from the MATLAB are then stored on the Linux enabled PC and then using File streaming in python we then compare values for different controls of quadrotor.
