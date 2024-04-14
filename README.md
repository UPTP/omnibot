# Omnibot
## Project
Omni-directional Robot controller design and verification on self-build prototype
## Objective: 
Learn how to design the controller for an Omni-directional Robot and implement it on a prototype using the simulation model. 
## Tasks description:
1. Robot Controller Design: Use ROS2 and MATLAB for Modelling, Simulation, and control of the robot (Mobile Robot Modeling)
2. Omni-directional Robot Design: Create 3D models (tentative) with the bill of material
3. Build the prototype: Assemble and test the prototype
4. Test and verification: Apply the controller on the prototype and calibrate its configuration (write a test report)
5. Documentation: Write a report and post technical information on Github
### Robot Controller Design
- Use ROS2 and MATLAB for Modelling and Simulation of the robot (Mobile Robot Modeling).
- Create and simulate a mathematical model of the robot.
  - Write S-function to describe the robot model and simulate the response in Simulink
  - Apply the controller on the model and calibrate its configuration (write a test report) 
- Write algorithms to do the following in real-time in ROS2:
  - Measure various motors and robot body states, such as position, velocity, and current. 
  - Estimate or filter the robot motor shaft.
  - Estimate the robot pose using the odometry and Inertial Measurement Unit (IMU).
  - Generate control actions to drive the motors and robot towards desired outputs(PID, sliding mode(tentative), Model Predictive Control (tentative).
  - Handle Communication between the various robot components
### Build the prototype
- Create 3D models (tentative)
- Select the components and generate a Bill of Materials.
- Assemble and test the prototype.
### Test and verification
- Apply the controller on the prototype and calibrate its configuration (write a test report)
- Documentation: Write a report and post technical information on the project's GitHub. The documentation will include the following:
  - Robot specifications
  - Bill of materials
  - Results of the tests
### Tasks map 
- Simulation – controller 
- Omni-robot design
- Assembling and Test 
- Calibration
- Verification
![image](https://github.com/iiotntust/Omnibot/assets/56021651/499e18c3-785c-474d-bdde-22ca7f4a7866)
## Notes
- The areas marked as “tentative” are not guaranteed to be taught. 
  - Those within the controller section are very likely to be taught
  - Others are currently not likely to be taught.
## Reference
1. Omnidirectional robot modeling and simulation - https://arxiv.org/pdf/2211.08532.pdf
2. Installation Matlab;
Download link (only available on NTUST campus): https://www.cc.ntust.edu.tw/p/412-1050-8352.php
3. ROS 2: https://github.com/ros2
