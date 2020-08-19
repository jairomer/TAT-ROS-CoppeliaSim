/*
----------------------------------------------------------------------------
"THE BEER-WARE LICENSE" (Revision 42):
<jairomer@protonmail.com> wrote this file. As long as you retain this notice you
can do whatever you want with this stuff. If we meet some day, and you think
this stuff is worth it, you can buy me a beer in return.  Jaime R.M.
----------------------------------------------------------------------------
*/
#include <iostream>
#include <mutex>
#include <chrono>
#include <string>
#include <vector>
#include "ros/ros.h"
#include "std_msgs/Bool.h"

/* Globals */
std::mutex mtx; 
std::chrono::time_point<std::chrono::steady_clock> start;
std::chrono::time_point<std::chrono::steady_clock> end;
std::chrono::duration<double> tatd;
std::vector<double> tats_vector;


void ping_callback(const std_msgs::Bool::ConstPtr& msg) 
{
    if (msg->data) {
        end = std::chrono::steady_clock::now();
        tatd = end - start;
        std::cout << ", " << tatd.count()*1000 << std::endl;
        tats_vector.push_back(tatd.count()*1000);
        mtx.unlock();
    }
}

int main(int argc, char** argv) 
{
    ros::init(argc, argv, "ping");
    ros::NodeHandle nh; 
    const char* PONG_TOPIC =  "/coppeliaSIM/pong"; 

    ros::Subscriber ping_sub = nh.subscribe(PONG_TOPIC, 1, ping_callback);
    ros::Publisher ping_pub = nh.advertise<std_msgs::Bool>(PONG_TOPIC, 1);

    std_msgs::Bool ping_msg;
    ping_msg.data = false;

    std::cout << "Press Enter to start testing" << std::endl;
    std::cin.ignore();

    /* Get data. */
    std::cout << "id, turn_around_time" << std::endl;
    for (int i=0; i<500 && ros::ok(); ++i) 
    {
        while(!mtx.try_lock()) { ros::spinOnce(); }

        std::cout << i;
        start = std::chrono::steady_clock::now();
        ping_pub.publish(ping_msg);
    }

    /* Compute average */
    double acc = 0;
    for (auto it = tats_vector.begin(); it!=tats_vector.end(); ++it)
    {
        acc += *it;
    }
    std::cout << std::endl;
    std::cout << "average: " << acc/tats_vector.size() << std::endl;
    
    ping_sub.shutdown();
    ping_pub.shutdown();

    return 0;
}