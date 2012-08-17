%%
%%Messauswertung / -plotter:

clc
clear all
close all

pfad1 = '/Users/korbi/Studium/Master/Forschungspraxis/Labview/Testwerte/22.05/';

pfad2 = 'horst_6.txt';
savefile = 'horst_1.mat';
savefile2 = 'untitled.fig';
savefile3 = 'pgf.pgf';

s = [pfad1,pfad2];
daten = importdata([pfad1,pfad2]);
save([pfad1,savefile],'daten');
clear mat;
load([pfad1,savefile]);

plotbereich = 1:1:length(daten(:,11));                                         % Auswahl der dargestellten Daten
daten(plotbereich,11) = daten(plotbereich,11) - daten(plotbereich(1),11);      % Zeitachse ab Null Sekunden starten

Acc           = daten(plotbereich,1);
GyroSpeed     = daten(plotbereich,2);
GyroWinkel    = daten(plotbereich,3);
FilterWinkel  = daten(plotbereich,4);
Regler        = daten(plotbereich,5);
MotorSumme    = daten(plotbereich,6);
MotorPos      = daten(plotbereich,7);
MotorSpeed    = daten(plotbereich,8);
WinkelS30     = daten(plotbereich,9);
ACCKor        = daten(plotbereich,10);
Zeit_in_ms    = daten(plotbereich,11);

Zeit          = Zeit_in_ms ./ 1000;           % Zeit in Sekunden Anzeigen

Winkel_Acc    = Acc * (-5.78862);             % Winkel aus Acc Wert mit Kleinwinkelnährung berechen

AccKorr       = MotorPos ./ 1000;             % Acc Korrektur für Schwerpunktanpassung


figure(1)
hold on

% Erster Plot: 

h(1) = subplot(211);      
hold on
title('Acc\_Sensor', 'FontName', 'Helvetica', 'FontSize',12)
xlabel('t in [s]', 'FontName', 'Helvetica', 'FontSize',12)
ylabel('Acc in m/s^2', 'FontName', 'Helvetica', 'FontSize',12)

plot(Zeit,Acc,'color','r','linestyle','-', 'lineWidth',1.25)  

legend('Acc\_Werte','Filterwinkel','Location','SW')

box on
axis tight

 grid on;
 
% Zweiter Plot: 
 
h(2) = subplot(212);      
hold on
title('Winkel', 'FontName', 'Helvetica', 'FontSize',12)
xlabel('t in [s]', 'FontName', 'Helvetica', 'FontSize',12)
ylabel('Winkel in °', 'FontName', 'Helvetica', 'FontSize',12)

plot(Zeit,GyroWinkel,'color','b','linestyle','-', 'lineWidth',1.25) 
plot(Zeit,FilterWinkel,'color','g','linestyle','-', 'lineWidth',1.25)

legend('Gyrowinkel','Filterwinkel','Location','SW')
 
 box on
 axis tight
 
    grid on;    
    
% Dritter Plot    
    
% h(2) = subplot(313);      
% hold on
% title('Testplot', 'FontName', 'Helvetica', 'FontSize',12)
% xlabel('t in [ms]', 'FontName', 'Helvetica', 'FontSize',12)
% ylabel('Gyro (deg/s)', 'FontName', 'Helvetica', 'FontSize',12)

% plot(daten(plotbereich,11),daten(plotbereich,1),'color','b','linestyle','-', 'lineWidth',1.25)  % Beschleinigung
% plot(daten(plotbereich,11),daten(plotbereich,3),'color','r','linestyle','-', 'lineWidth',1.25)  % Gyrowinkel
% plot(daten(plotbereich,11),daten(plotbereich,4),'color','g', 'lineWidth',1.25)                  % Filterausgan

% legend('Speed','Winkel','Location','SW')
 
% box on
% axis tight
 
%    grid on;


linkaxes (h,'x')

%close all;
%clear all;