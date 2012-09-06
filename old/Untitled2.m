%% matlab calculation of system matrix sys and input matrix B
%% mass of pendulum ( ~ Body)
mp = 0.6
%% length of pendulum
l = 0.02
%% center of mass 
ls = 0.01
%% wheel radius
R = 0.04
%% wheel mass
mr = 0.03
%% Weight factor of stateerror
wtheta = 0.02
wtheta_speed = 1000
wphi = 1e-04
wphi_speed = 0.04
Rmax = 900
%% Wheel Inertia (not used currently)
Jr = mr  *R^2 /2
%% Pendulum Inertia    moved by Steiner-theorem along the pendulum axe to the wheelpoint
Jp = 1/3 * mp * ls^2 + mp * (l^2 - ls^2)

%% Systemmatrix
sys = [0,1,0,0;
       mp*g*(l-ls)/Jp, 0 , 0 , ls/(R*2.4);
       0,0,0,1;
       0,0,0,-10]
%% Inputmatrix
B = [0; ls/(R*2.4);0;10]

%% calculate weight matrix
Q = [wtheta,0,0,0;
     0,wtheta_speed,0,0;
     0,0,wphi,0;
     0,0,0,wphi_speed]
 %% calculate weight output matrix
R = 1/(Rmax)^2

%% calculate gain