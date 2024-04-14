function model_1_h(block)
% Level-2 MATLAB file S-Function for limited integrator demo.

%   Copyright 1990-2009 The MathWorks, Inc.

    setup(block);
  
%endfunction

function setup(block)
  
  %% Register number of dialog parameters   
  %block.NumDialogPrms = 3;

  %% Register number of input and output ports
  block.NumInputPorts  = 5;
  block.NumOutputPorts = 1;

  %% Setup functional port properties to dynamically
  %% inherited.
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;
 
  block.InputPort(1).Dimensions        = 4;
  block.InputPort(1).DirectFeedthrough = false;
  
  
  
  block.InputPort(2).Dimensions        = 1;
  block.InputPort(2).DirectFeedthrough = false;

  block.InputPort(3).Dimensions        = 3;
  block.InputPort(3).DirectFeedthrough = false;

  block.InputPort(4).Dimensions        = 1;
  block.InputPort(4).DirectFeedthrough = false;


  block.InputPort(5).Dimensions        = 7;
  block.InputPort(5).DirectFeedthrough = false;
  


 block.OutputPort(1).Dimensions       = 3;
  %% Set block sample time to continuous
  block.SampleTimes = [0 0];
  
  %% Setup Dwork
  block.NumContStates = 3;

  %% Set the block simStateCompliance to default (i.e., same as a built-in block)
  block.SimStateCompliance = 'DefaultSimState';

  %% Register methods
  block.RegBlockMethod('InitializeConditions',    @InitConditions);  
  block.RegBlockMethod('Outputs',                 @Output);  
  block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
  block.RegBlockMethod('Derivatives',             @Derivative);  
  
%endfunction

function DoPostPropSetup(block)
%% Setup Dwork

  block.NumDworks = 4;

  block.Dwork(1).Name = 'c'; 
  block.Dwork(1).Dimensions      =  9;
  block.Dwork(1).DatatypeID      =  0;
  block.Dwork(1).Complexity      = 'Real';
  block.Dwork(1).UsedAsDiscState =  false;

   block.Dwork(2).Name = 'B'; 
  block.Dwork(2).Dimensions      =  12;
  block.Dwork(2).DatatypeID      =  0;
  block.Dwork(2).Complexity      = 'Real';
  block.Dwork(2).UsedAsDiscState =  false;

  block.Dwork(3).Name = 'K'; 
  block.Dwork(3).Dimensions      =  9;
  block.Dwork(3).DatatypeID      =  0;
  block.Dwork(3).Complexity      = 'Real';
  block.Dwork(3).UsedAsDiscState =  false;

   block.Dwork(4).Name = 'M'; 
  block.Dwork(4).Dimensions      =  9;
  block.Dwork(4).DatatypeID      =  0;
  block.Dwork(4).Complexity      = 'Real';
  block.Dwork(4).UsedAsDiscState =  false;


function InitConditions(block)

  %% Initialize Dwork
  %block.ContStates.Data(1) = block.DialogPrm(3).Data;
 %block.ContStates.Data = [0.2;0.3;-0.2];
 block.ContStates.Data = [0;0;0];


M =  [35.0000         0      0;
         0   35.0000         0;
         0         0    1.3700];

C = [-26.5113    0.0000   -0.0000;
       0.0000  -26.5112    0.0000;
      -0.0000    0.0000   -2.5525];

B = [-1.1932   -1.1932    1.1932    1.1932;
    1.1932   -1.1932   -1.1932    1.1932;
    0.3375    0.3375    0.3375    0.3375];

K = [29.4500         0         0;
         0   29.4500         0;
         0         0    5.1200];
    
    block.Dwork(1).Data = reshape(C,[3*3,1]);
    block.Dwork(2).Data = reshape(B,[4*3,1]);
    block.Dwork(3).Data = reshape(K,[3*3,1]);
    block.Dwork(4).Data = reshape(M,[3*3,1]);


  %endfunction

function Output(block)

  block.OutputPort(1).Data = block.ContStates.Data;
  
%endfunction

function Derivative(block)
     u =  block.InputPort(1).Data;
     p =  block.InputPort(2).Data;
     th = p;
     Td =  block.InputPort(3).Data;
     frict_multiplier =  block.InputPort(4).Data;
     in1 = block.InputPort(5).Data(1:3);
     in2 = block.InputPort(5).Data(4:7);

     deltaA = diag(in1);
     deltaB = diag(in2);

     x =  block.ContStates.Data;
     M = reshape(block.Dwork(4).Data,3,3);
     A = M^-1*reshape(block.Dwork(1).Data,3,3);
     B = M^-1*reshape(block.Dwork(2).Data,3,4);
     K = M^-1*reshape(block.Dwork(3).Data,3,3);
     
     omega = x(3);
     E = M^-1*eye(3);

f =[    0, -omega, 0;
    omega,      0, 0;
    0,      0, 0];

     H = [cos(th) -sin(th) 0
      sin(th) cos(th) 0
      0 0 1];
     H_inv = [cos(th) sin(th) 0
             -sin(th) cos(th) 0
               0 0 1];


     block.Derivatives.Data = f*x+A*(eye(3)+deltaA)*x+H*(B*(eye(4)+deltaB)*u+frict_multiplier*K*tanh(18*H_inv*x)+E*Td);%tanh is a good alternative


  