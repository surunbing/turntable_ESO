function [sys,x0,str,ts] = ESO(t,x,u,flag)

%
% is an S-function implementing the MPC controller intended for use
% with Simulink. The argument md, which is the only user supplied
% argument, contains the data structures needed by the controller. The
% input to the S-function block is a vector signal consisting of the
% measured outputs and the reference values for the controlled
% outputs. The output of the S-function block is a vector signal
% consisting of the control variables and the estimated state vector,
% potentially including estimated disturbance states.

switch flag
 case 0
  [sys,x0,str,ts] = mdlInitializeSizes; % Initialization
  
 case 2
  sys = mdlUpdates(t,x,u); % Update discrete states
  
 case 3
  sys = mdlOutputs(t,x,u); % Calculate outputs
 


 case {1,4,9} % Unused flags
  sys = [];
  
 otherwise
  error(['unhandled flag = ',num2str(flag)]); % Error handling
end
% End of dsfunc.

%==============================================================
% Initialization
%==============================================================

function [sys,x0,str,ts] = mdlInitializeSizes

% Call simsizes for a sizes structure, fill it in, and convert it 
% to a sizes array.

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 4;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1; % Matrix D is non-empty.
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);  
% Initialize the discrete states.
str = [];             % Set str to an empty matrix.

t = 0.00025;

ts  = [t 0];       % sample time: [period, offset]
x0 =[0;0;0;0];

wq = 80 * 2 * pi;
K = 1.56 * 180 / pi;
taue = 0.0039035;
taum = 0.984871194396488;
b2  = 1 / taue;
b1 = 1 / taum;
b0 = K / (taue * taum);

%% �б�ѩ��
global para z1 z2 z3 z4 num;
para.beta4 = 0.2756 * wq ^ 4;
para.beta1 = 0.9528 * wq - b1 - b2;
para.beta2 = 1.4539 * wq * wq - b2 * para.beta1 - b1 * para.beta1 - b1 * b2;
para.beta3 = 0.7426 * wq ^ 3 - b2 * para.beta2 - b1 * para.beta2 - b1 * b2 * para.beta1;
para.gain = b0;
para.t = t;
z1 = 0;
z2 = 0;
z3 = 0;
z4 = 0;
num = 0;




%End of mdlInitializeSizes
		      
%==============================================================
% Update the discrete states
%==============================================================
function sys = mdlUpdates(t,x,u)
global para z1 z2 z3 z4 num;
beta0 = para.beta1;
beta1 = para.beta2;
beta2 = para.beta3;
beta3 = para.beta4;
b0 = para.gain;
h = para.t;

num = num + 1;

uu = u(1);
y = u(2);

dx = zeros(4, 1);
e = z1 - y;
dx(1) = z2 - beta0 * e;
dx(2) = z3 - beta1 * e;
dx(3) = z4 - beta2 * e + b0 * uu - (1.015361202246130 + 2.561803509670808e+02) * z3 - (1.015361202246130 * 2.561803509670808e+02) * z2;
dx(4) = - beta3 * e;

c2 = 2 / 3;
z11 = z1 + c2 * h * dx(1);
z22 = z2 + c2 * h * dx(2);
z33 = z3 + c2 * h * dx(3);
z44 = z4 + c2 * h * dx(4);

dxy = zeros(4, 1);
e = z11 - y;
dxy(1) = z22 - beta0 * e;
dxy(2) = z33 - beta1 * e;
dxy(3) = z44 - beta2 * e + b0 * uu - (1.015361202246130 + 2.561803509670808e+02) * z33 - (1.015361202246130 * 2.561803509670808e+02) * z22;
dxy(4) = - beta3 * e;

z1 = z1 + h / 4 * (dx(1) + 3 * dxy(1));
z2 = z2 + h / 4 * (dx(2) + 3 * dxy(2));
z3 = z3 + h / 4 * (dx(3) + 3 * dxy(3));
z4 = z4 + h / 4 * (dx(4) + 3 * dxy(4));

x(1) = z1;
x(2) = z2;
x(3) = z3;
x(4) = z4;
sys = x;
%End of mdlUpdate.

%==============================================================
% Calculate outputs
%==============================================================
function sys = mdlOutputs(t,x,u)
sys = x;

 
% End of mdlOutputs.
