%% lab04.m by Alec Dryden
%% Options
clear,clc,close all
my_options;


%% Known Parameters
% Measured values
Rs = 50;        % Source resistance (Ohms)
R = 66.43;      % Resistor (Ohms)
L = 100e-6;     % Inductor (H)
C = 670e-12;    % Capacitor (F)
A = 1.06;       % Source voltage (not in Vpp form)


%% Import lab data
T = xlsread('data.xlsx');
f = T(:,1)*1e3;             % kHz conversion
w = 2*pi*f;                 % Get frequencies
Vsource = T(:,3);         % Get source voltage (/2 for Vpp)
vc_m = T(:,4);            % Get output voltage (/2 for Vpp)
phi_m = T(:,5);             % Get capacitor phase shift
phi_m(phi_m > 90) = phi_m(phi_m > 90) - 180;    % Reformat for -90 < phi < 90


%% Calculated values
zeta = (Rs+R)/2*sqrt(C/L);  % damping ratio
wn = 1/sqrt(C*L);           % natural frequency (s^-1)
a = w*C*(R + Rs);           % simplifying variable a
b = 1-w.^2*C*L;             % simplifying variable b
phi_t = atan(a./b);         % theoretical phase shift
K = sqrt(a.^2 + b.^2);      % resulting impedance magnitude for vc
vc_t = A./K;                % capacitor voltage amplitude


%% Plotting
% magnitude ratio plot
figure('units','normalized','outerposition',[0 0 1 1])
set(gca, 'XScale', 'log');
hold on
semilogx(w,vc_m./Vsource,'o-');
semilogx(w,vc_t./A,'*-');
semilogx([wn,wn],[0,6],'k--');
xlabel('$\omega$ ($s^{-1}$)')
ylabel('$M(\omega)$')
legend('Measured','Analytic','Natural frequency')
ylim([0,6])
xlim([1e3,1e8])
grid on
hold off

% phase shift plot
figure('units','normalized','outerposition',[0 0 1 1])
set(gca, 'XScale', 'log');
hold on
semilogx(w,phi_m,'o-');
semilogx(w,phi_t*180/pi,'*-');
semilogx([wn,wn],[-100,100],'k--');
xlabel('$\omega$ ($s^{-1}$)')
ylabel('$\phi$ ($^{\circ}$)')
legend('Measured','Analytic','Natural frequency')
ylim([-100,100])
xlim([1e3,1e8])
grid on
hold off

