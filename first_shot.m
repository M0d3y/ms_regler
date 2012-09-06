%% Parameters
%% -----------------------------------------------------------------------

%% Body mass [kg]
mp = 0.8
%% length of Pendulum in total [m]
l = 0.03
%% center of mass distance from wheel [m]
ls = 0.02
%% Inertia of Wheel [kg * (m/s)^2]
Jr = 2.4e-5
%% Wheel radius
R = 0.04
%% Weight factor of stateerror
wtheta = 1/(20^2)
wtheta_speed = 1/(1000^2)
wphi = 1e-8
wphi_speed = 1/(900^2)
Rmax = 900

%% Constants
%% -----------------------------------------------------------------------

%% Gravitational constant [m/s^2]
g = 9.81


%% Calculation
%% -----------------------------------------------------------------------

%% Calc Inertia of Pendulum
%% Center of Mass => mass in [ls:l] equals mass in [0:ls] (todo:picture) 
Jp = mp * (0.04^2 + 0.144^2)/12 +  mp*((l-ls)^2)

%% systemmatrix
 
A = [       0    ,   1    ,    0    ,    0        ;
     mp*g*(l-ls)/Jp,   0    ,    0    , 20*Jr*ls/(Jp*R) ;
            0    ,   0    ,    0    ,    1        ;
            0    ,   0    ,    0    ,    -10 ]

 %% inputmatrix
 
 B = [  0; 20*Jr*ls/(Jp*R) ; 0 ; 10 ]
 
 
 %% ----------------------------------------------------------------------
 %% Based on
 %% theta_acc = 1/Jp * (mg(l-ls)sin(theta) + 2*Jr*ls*(phi_speed - u)*cos(theta)/t)
 %% phi_acc   = -1/t * (phi_speed - k*u)
 %% where t is the motors reaction constant and k is phi_speed/u, the stellgröße's conversion factor
 %% (used 0.1 for t and 1 for k here, b/c stellgröße = phi_speed
 %% ----------------------------------------------------------------------
 
 %% calculate weight matrix
Q = [wtheta,0,0,0;
     0,wtheta_speed,0,0;
     0,0,wphi,0;
     0,0,0,wphi_speed]
  %% Weightfactors calculated by weight = 1/(max)^2 mostly except for theta_acc (no easy accessable max(theta_acc) & must be weighted more for stablizing)
 %% Weightmatrix for output
 R = 1/(Rmax^2)
  %% same for R : phi_speed [-900;900], b/c max rpm ~ 150 (see http://www.philohome.com/nxtmotor/nxtmotor.htm )
  %% 1 rpm = 360° / 60 s = 6 °/s
  
  
 %% calculate optimal gain factor using lqr
 Gain = lqr(A,B,Q,R)
 
 
 
  
  
  
