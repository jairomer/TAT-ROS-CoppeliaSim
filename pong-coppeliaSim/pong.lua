-- ----------------------------------------------------------------------------
-- "THE BEER-WARE LICENSE" (Revision 42):
-- <jairomer@protonmail.com> wrote this file.  As long as you retain this notice you
-- can do whatever you want with this stuff. If we meet some day, and you think
-- this stuff is worth it, you can buy me a beer in return.   Jaime R.M
-- ----------------------------------------------------------------------------

function pong_callback(msg)
    -- If data is 'false', return 'true'.
    if not msg.data then 
        print("pong")
        simROS.publish(pongpub, {data=true})
    end 
end 

function sysCall_init()
    if simROS then 
        print("<font color='#0F0'>ROS interface was found.</font>@html")

        PONG_TOPIC  = "/coppeliaSIM/pong"
        pongpub     =  simROS.advertise(PONG_TOPIC, 'std_msgs/Bool', 1, false)
        pongsub     =  simROS.subscribe(PONG_TOPIC, 'std_msgs/Bool', "pong_callback", 1)

        print("Ready")
    else 
        print("<font color='#F00'>ROS interface was not found. Cannot run.</font>@html")
        print("Is the ros master ready and reachable?")
        sim.stopSimulation()
    end
end 

function sysCall_cleanup()
    if simROS then 
        simROS.shutdownSubscriber(pongsub)
        simROS.shutdownPublisher(pongpub)
    end
end