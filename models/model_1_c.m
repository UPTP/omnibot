function model_1(block)
% Level-2 MATLAB file S-Function for limited integrator demo.

%   Copyright 1990-2009 The MathWorks, Inc.

  setup(block);
  
%endfunction

function setup(block)
  
  %% Register number of dialog parameters   
  %block.NumDialogPrms = 3;

  %% Register number of input and output ports
  block.NumInputPorts  = 4;
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

  block.NumDworks = 11;
  block.Dwork(1).Name = 'Kt'; 
  block.Dwork(1).Dimensions      =  4;
  block.Dwork(1).DatatypeID      =  0;
  block.Dwork(1).Complexity      = 'Real';
  block.Dwork(1).UsedAsDiscState =  false;


  block.Dwork(2).Name = 'Ra'; 
  block.Dwork(2).Dimensions      =  4;
  block.Dwork(2).DatatypeID      =  0;
  block.Dwork(2).Complexity      = 'Real';
  block.Dwork(2).UsedAsDiscState =  false;


  block.Dwork(3).Name = 'l'; 
  block.Dwork(3).Dimensions      =  4;
  block.Dwork(3).DatatypeID      =  0;
  block.Dwork(3).Complexity      = 'Real';
  block.Dwork(3).UsedAsDiscState =  false;


  
  block.Dwork(4).Name = 'Bv_Bw'; 
  block.Dwork(4).Dimensions      =  3;
  block.Dwork(4).DatatypeID      =  0;
  block.Dwork(4).Complexity      = 'Real';
  block.Dwork(4).UsedAsDiscState =  false;


  block.Dwork(5).Name = 'M_In'; 
  block.Dwork(5).Dimensions      =  2;
  block.Dwork(5).DatatypeID      =  0;
  block.Dwork(5).Complexity      = 'Real';
  block.Dwork(5).UsedAsDiscState =  false;



  block.Dwork(6).Name = 'b'; 
  block.Dwork(6).Dimensions      =  1;
  block.Dwork(6).DatatypeID      =  0;
  block.Dwork(6).Complexity      = 'Real';
  block.Dwork(6).UsedAsDiscState =  false;


  block.Dwork(7).Name = 'C'; 
  block.Dwork(7).Dimensions      =  3;
  block.Dwork(7).DatatypeID      =  0;
  block.Dwork(7).Complexity      = 'Real';
  block.Dwork(7).UsedAsDiscState =  false;

  block.Dwork(8).Name = 'r'; 
  block.Dwork(8).Dimensions      =  4;
  block.Dwork(8).DatatypeID      =  0;
  block.Dwork(8).Complexity      = 'Real';
  block.Dwork(8).UsedAsDiscState =  false;


  block.Dwork(9).Name = 'A'; 
  block.Dwork(9).Dimensions      =  9;
  block.Dwork(9).DatatypeID      =  0;
  block.Dwork(9).Complexity      = 'Real';
  block.Dwork(9).UsedAsDiscState =  false;

   block.Dwork(10).Name = 'B'; 
  block.Dwork(10).Dimensions      =  12;
  block.Dwork(10).DatatypeID      =  0;
  block.Dwork(10).Complexity      = 'Real';
  block.Dwork(10).UsedAsDiscState =  false;

  block.Dwork(11).Name = 'K'; 
  block.Dwork(11).Dimensions      =  9;
  block.Dwork(11).DatatypeID      =  0;
  block.Dwork(11).Complexity      = 'Real';
  block.Dwork(11).UsedAsDiscState =  false;

function InitConditions(block)

  %% Initialize Dwork
  %block.ContStates.Data(1) = block.DialogPrm(3).Data;
 block.ContStates.Data = [0;0;0];
  block.Dwork(1).Data(1)=0.1;%Kt
  block.Dwork(1).Data(2)=0.1;
  block.Dwork(1).Data(3)=0.1;
  block.Dwork(1).Data(4)=0.1;

  block.Dwork(2).Data(1)=4;%Ra
  block.Dwork(2).Data(2)=4;
  block.Dwork(2).Data(3)=4;
  block.Dwork(2).Data(4)=4;

  block.Dwork(3).Data(1)=6.75;%l
  
  block.Dwork(3).Data(2)=12.25;
  block.Dwork(3).Data(3)=6.75;
  block.Dwork(3).Data(4)=12.25;

     
  block.Dwork(4).Data(1)=3.73;%Bv
  block.Dwork(4).Data(2)=3.34;%Bvn
  block.Dwork(4).Data(3)=0.73;%Bw

  block.Dwork(5).Data(1)=35;%M
  block.Dwork(5).Data(2)=1.37;%In
     
  block.Dwork(6).Data(1)=0.2;%b

  block.Dwork(7).Data(1)= 29.45;%Cv
  block.Dwork(7).Data(2)=29.61;%Cvn
  block.Dwork(7).Data(3)=5.12;%Cw

  block.Dwork(8).Data(1)=0.07;%r
  block.Dwork(8).Data(2)=0.1;
  block.Dwork(8).Data(3)=0.07;
  block.Dwork(8).Data(4)=0.1;

     Kt_1 = block.Dwork(1).Data(1);
     Kt_2 = block.Dwork(1).Data(2);
     Kt_3 = block.Dwork(1).Data(3);
     Kt_4 = block.Dwork(1).Data(4);

     Ra_1 = block.Dwork(2).Data(1);
     Ra_2 = block.Dwork(2).Data(2);
     Ra_3 = block.Dwork(2).Data(3);
     Ra_4 = block.Dwork(2).Data(4);

     l_1 = block.Dwork(3).Data(1);
     l_2 = block.Dwork(3).Data(2);
     l_3 = block.Dwork(3).Data(3);
     l_4 = block.Dwork(3).Data(4);

     
     Bv= block.Dwork(4).Data(1);
     Bvn= block.Dwork(4).Data(2);
     Bw = block.Dwork(4).Data(3);

     M = block.Dwork(5).Data(1);
     In = block.Dwork(5).Data(2);
     
     b = block.Dwork(6).Data(1);

     Cv= block.Dwork(7).Data(1);
     Cvn= block.Dwork(7).Data(2);
     Cw = block.Dwork(7).Data(3);

     r_1 = block.Dwork(8).Data(1);
     r_2 = block.Dwork(8).Data(2);
     r_3 = block.Dwork(8).Data(3);
     r_4 = block.Dwork(8).Data(4);

     A11 = -(l_2^2*Kt_2^2)/(r_2^2*Ra_2*M)-(l_4^2*Kt_4^2)/(r_4^2*Ra_2*M)-Bv/M;
     A12 = 0;
     A13 = -(l_4^2*Kt_4^2*b)/(r_4^2*Ra_4*M)+(l_2^2*Kt_2^2*b)/(r_2^2*Ra_2*M);
     A21 = 0;
     A22 = -(l_3^2*Kt_3^2)/(r_3^2*Ra_3*M)-(l_1^2*Kt_1^2)/(r_1^2*Ra_1*M)-Bvn/M;
     A23 = -(l_1^2*Kt_1^2*b)/(r_1^2*Ra_1*M)+(l_3^2*Kt_3^2*b)/(r_3^2*Ra_3*M);
     A31 = (l_2^2*Kt_2^2*b)/(r_2^2*Ra_2*In)-(l_4^2*Kt_4^2*b)/(r_4^2*Ra_4*In);
     A32 = -(l_1^2*Kt_1^2*b)/(r_1^2*Ra_1*In)+(l_3^2*Kt_3^2*b)/(r_3^2*Ra_3*In);
     A33 = -(l_1^2*Kt_1^2*b^2)/(r_1^2*Ra_1*In)-(l_2^2*Kt_2^2*b^2)/(r_2^2*Ra_2*In)-...
            (l_3^2*Kt_3^2*b^2)/(r_3^2*Ra_3*In)-(l_4^2*Kt_4^2*b^2)/(r_4^2*Ra_4*In)-Bw/In;
   
     dA = 0.5*(rand(3,3)-1/2);
     dA = 1*rand(3,3)-1/2;

     A = [A11 A12 A13;A21 A22 A23;A31 A32 A33]



     B11 = 0;
     B12 = -(l_2*Kt_2)/(r_2*Ra_2*M);
     B13 = 0;
     B14 = (l_4*Kt_4)/(r_4*Ra_4*M);
     B21 = (l_1*Kt_1)/(r_1*Ra_1*M);
     B22 = 0;
     B23 = -(l_3*Kt_3)/(r_3*Ra_3*M);
     B24 = 0;
     B31 = (l_1*Kt_1)/(r_1*Ra_1*In);
     B32 = (l_2*Kt_2)/(r_2*Ra_2*In);
     B33 = (l_3*Kt_3)/(r_3*Ra_3*In);
     B34 = (l_4*Kt_4)/(r_4*Ra_4*In);

     dB = 0.5*rand(3,4)-0.5/2;
     dB = 1*rand(3,4)-1/2;
     B = [B11 B12 B13 B14;B21 B22 B23 B24;B31 B32 B33 B34]

     K11 = -Cv/M;K22 = -Cvn/M; K33 = -Cw/In;
     K = diag([K11,K22,K33])
    
    block.Dwork(9).Data = reshape(A,[3*3,1]);
    block.Dwork(10).Data = reshape(B,[4*3,1]);
    block.Dwork(11).Data = reshape(K,[3*3,1]);



    Ac = A;
    Bc = B;
Cc = eye(3);
Dc = zeros(3,4);
    
r = 0.5;
h=0.04 %sampling interval
[Ap,Bp,Cp,Dp]=c2dm(Ac,Bc,Cc,Dc,h,'zoh');
[m1,n1]=size(Cp);
[n1,n_in]=size(Bp);

a1=0;
N1=1;

a2=0;
N2=1;

a3=0;
N3=1;

a4=0;
N4=1;

a=[a1 a2 a3 a4];
N=[N1 N2 N3 N4];

Np=10;
Nc=1;

A_e=eye(n1+m1,n1+m1);
A_e(1:n1,1:n1)=Ap;
A_e(n1+1:n1+m1,1:n1)=Cp*Ap;
B_e=zeros(n1+m1,n_in);
B_e(1:n1,:)=Bp;
B_e(n1+1:n1+m1,:)=Cp*Bp;
C_e=zeros(m1,n1+m1);
C_e(:,n1+1:n1+m1)=eye(m1,m1);
Q=C_e'*C_e;
R= r*eye(n_in,n_in);
%[Omega,Psi]=dmpc(A_e,B_e,a,N,Np,Q,R);
%disp("Omega size ");
%size(Omega);
%disp("Psi size");
%size(Psi);



  %endfunction

function Output(block)

  block.OutputPort(1).Data = block.ContStates.Data;
  
%endfunction

function Derivative(block)
     u =  block.InputPort(1).Data;
     p =  block.InputPort(2).Data;
     d =  block.InputPort(3).Data;
     frict_multiplier =  block.InputPort(4).Data;

     x =  block.ContStates.Data;
     A = reshape(block.Dwork(9).Data,3,3);
     B = reshape(block.Dwork(10).Data,3,4);
     K = reshape(block.Dwork(11).Data,3,3);
    
     E = eye(3);


     %block.Derivatives.Data = [ 0 0 0;0  0 0 ;0 0 0]*x+[1 0 0 0.3;0 1 0 0.3;0 0 1 0.3]*u ;
     %block.Derivatives.Data = A*x+B*u;
     %block.Derivatives.Data = p*A*x+p*B*u+E*d;
     %block.Derivatives.Data = A*x+B*u;
     %block.Derivatives.Data = A*x+B*u + K*sign(x); % this causes issues
     %when not controlled
     %because it is not differentiable
     %K*tanh(10*x)
     %block.Derivatives.Data = A*0.99*x+B*0.99*u + K*tanh(20*x);%tanh is a good alternative
     block.Derivatives.Data = 1/p*A*x+1/p*B*u + 1/p*frict_multiplier*K*tanh(5*x)+E*d;%tanh is a good alternative


  
%endfunction

