# TAT-ROS-CoppeliaSim 

## What is this?

This is a set of scripts designed to measured the turn around time between a node in a ROS network and a node running in a CoppeliaSim instance. 

The purpose is to obtain statistics for the latency between both nodes over a link like WiFi. 

The code is divided into two nodes: 

pong-coppeliaSIM: Code running in CoppeliaSim that pong's a {data=true} message when a {data=false} message is received on topic `\CoppeliaSim\pong`. 

ping-ros-cpp: Sends a {data=false} message to `\CoppeliaSim\pong` and measures the time until the callback on a {data=true} message arrives, it then prints values as a csv in the standard output of the node. 
This node will ping 500 times by default. 

## Why? 

I needed to get some measurements for my final undergraduate thesis in 2020. 

## How to use it?

First you will need to adapt the network parameters on the run_* scripts to your setup. 

If you have not built the docker images before, then it will take a long time to build. This is normal. 

Then you can start: 
1. Open two terminals. 
2. In one of them execute: `./run_ping.sh`
3. Wait until message "Press Enter to start testing appears".
4. Execute in the other: `./run_coppeliaSim.sh`
5. Wait until is launched, verify on the logs that the ROS interface is loaded: `Plugin 'ROSInterface': load succeeded.`
6. Select the scene camera and add a Non-Threaded script. 
7. Copy the contents of `pong.lua` into the Non-Threades script and run the simulation. 
8. Start test, if everything goes well, you should get a csv on the standard output and the averate turn around time. 
9. ??? 
10. Profit.

