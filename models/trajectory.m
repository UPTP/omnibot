

xden = 100;
yden = 50;
step_size = 3000000;
t = linspace(0,300,step_size);
dt = t(2) - t(1);
c = 4;
scaler=2;
%x1 = sin(2* 0.1*t);
%x1 =  t/2;
%x1 = 1/10*t;
%x1 = -0.7+0.7*sin(2*pi()*t/120);
%x1 = -0.5+0.7*sin(2*pi()*t/62);
%x1 = 0.7*sin(2*pi()*t/80);
%x1 =(1-exp(-t.^3)).*cos(2*pi()*t/100*c)*scaler;

x1 =cos(2*pi()*t/xden*c)*scaler;%thesis
%x1 = 1/10*t;

%square
%x1 = zeros(step_size);
%x1 = [t(1:step_size/4)/24 ones(1,step_size/4)*t(step_size/4)/24 flip(t(1:step_size/4)/24) ones(1,step_size/4)*t(1)/24];


%linear_velocity_signals = 0.05 + 0.05*sin(2*t)+0.005*sin(7*t) + 0.05*sin(t) + 0.05*sin(t/3) + 0.05*sin(t/11)+0.005*sin(t/10);
%angular_velocity_signals = 1.5 + 0.5*sin(3*t/2)+0.002*sin(7*t) + 0.5*sin(t) + 0.25*sin(t/2) + 0.25*sin(t/5)+0.005*sin(t/7);


dx1 = diff(x1)/dt;
dx1(end+1) = dx1(end);
%dx1 = 3 * pi() * cos((pi() * t)/50)/200;
%y1 = 0.5*sin(1/20*pi()*t);
%y1 = 0.5*sin(2*1/140*pi()*t);
%y1 = 1*x1;
%y1 = 1/10*t;
%y1 = 0.1+0.7*sin(4*pi()*t/30);
%y1 = 0.1+0.4*sin(2*pi()*t/30);
%y1 = -0.7+0.7*cos(2*pi()*t/80);
%y1 = sin(2*pi()*t/50*c)*scaler;
%y1 = sin(2*pi()*t/100*c)*scaler;

y1 = sin(2*pi()*t/yden*c)*scaler;%thesis
%y1 = 1/10*t;

%y1 = [ones(1,step_size/4)*0 t(1:step_size/4)/24 ones(1,step_size/4)*t(step_size/4)/24 flip(t(1:step_size/4)/24)];


%y1 =  t/60;
dy1 = diff(y1)/dt;
dy1(end+1) = dy1(end);
%dy1 = (pi*cos((pi*t)/25))/25;
theta1 = unwrap(atan2(dy1./(t+dt),dx1./(t+dt)));
%theta1 = (atan2(dy1./(t+dt),dx1./(t+dt)));% there is warping in this due to the atan2

dtheta1 = diff(theta1)/dt;
%plot(t([1:end-1]),dtheta1);
%q_reference = [x1;y1;theta1]; %might raise an error because of uneven lengths
q_ref = [[x1(1:end-1)];[y1(1:end-1)];[theta1(1:end-1)]];
v_ref = [[dx1(1:end-1)];[dy1(1:end-1)];dtheta1];
sim_pose = [t(1:step_size-1)',q_ref'];
sim_velocity = [t(1:step_size-1)',v_ref'];

ddx1 = diff(dx1)/dt;
ddx1(end+1) = ddx1(end);
ddy1 = diff(dy1)/dt;
ddy1(end+1) = ddy1(end);
ddtheta1 = diff(theta1)/dt;
a_ref = [[ddx1(1:end-1)];[ddy1(1:end-1)];ddtheta1];
sim_acc = [t(1:step_size-1)',a_ref'];

f_multiplier = 0.3;
init_t1=1;
init_t2=1;
init_t3=1;
init_t4=1;
floe1 = 1;
floe2 = 1;
floe3 = 1;
floe4 = 1;

wear_rate_multiplier = 1;

loe_fault_slope = [0 0 0 0];
loe_fault_init_time = [0 0 0 0];
loe_fault_time = [15 20 50 30];
%loe_fault_time = [5 5 5 5]*0.1;
loe_fault_init_value = [1 1 1 1];
%loe_fault_end_value = [0.9 0.8 0.7 0.6];
loe_fault_end_value = [ 1 1 1 1];
time_constant = 0.05;
%loe_fault_end_value = [0.8 0.7 0.9 0.6];
imax = 300;


%% Bias Fault--------------------
%bias_fault_time = [35 35 35 35];
bias_fault_time = [35 35 50 35];

bias_fault_init_value = [0 0 0 0];
%bias_fault_end_value = [5 -5 5 -5];
bias_fault_end_value = [0 0 0 0 ];
bias_time_constant = time_constant;


%A = readmatrix("normal_4w.csv");
A = readmatrix("n4w.csv");

As = A(513:5120, 1:16);
[N,C,S] = normalize(As,"zscore","std");


%%
%NN settings
[0.19938903 0.20167496 0.20040237 0.20544421 0.30054876 0.35914803 0.29189526 0.37804367 0.28577235 0.28555074 0.13869561 0.13899693  0.64636551 0.60583125 0.63678585 0.61230131];
[0.12845826  0.13142938     0.13899888  0.14194257   0.19931939  0.26313103  0.17217288  0.31461229     0.1018101   0.1020744     0.15071236    0.14990974   0.22946558     0.24017739  0.23991848  0.2235588];

stcaec = [0.15474687 0.15978599 0.15328662 0.15907767 0.21256395 0.28108176 0.17550684 0.33193932 0.12112598 0.12984532 0.10711709 0.0969327 0.2608442  0.26124951 0.24228729 0.22781631];
overlap = 128+64;
