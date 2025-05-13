% Phase-Shift Full Bridge DC-DC Converter Design Script
% Automotive Application (Vout = 14V)
clc
clear all
% Input parameters
Vin = 400;               % Input voltage (V)
Pin = 2000;              % Input power (W)
Pout = 1900;             % Output power (W)
efficiency = 0.95;       % Estimated efficiency
Iout_ripple = 0.1;       % Output current ripple (fraction of Iout)
Vout_ripple = 0.02;      % Output voltage ripple (fraction of Vout)
Fsw = 250e3;             % Switching frequency (Hz)

% Fixed output voltage
Vout = 14;               % Output voltage (V)
Iout = Pout / Vout;      % Output current (A)
Iout_peak = Iout * (1 + Iout_ripple);  % Peak output current (A)

% Transformer turns ratio
n = Vin / Vout;          % Transformer turns ratio

% Primary and Secondary Voltages
Vp = Vin;                % Primary voltage (V)
Vs = Vout;               % Secondary voltage (V)

% Calculating inductance L on the secondary side
D = 0.5; % duty cycle
L = (Vout / (Fsw * Iout_ripple * Iout)) * (1 - D); % Output inductance (H)

% Transformer inductances
L1 = 1e-3; % Primary inductance (H)
L2 = L1 * n^2; % Secondary inductance (H)

% Calculating capacitance C
Iripple_C = Iout_ripple * Iout;        % Capacitor ripple current (A)
C = Iripple_C / (8 * Fsw * Vout_ripple * Vout); % Output capacitance (F)

% Currents
Imax_primary = Pin / Vin;              % Maximum current in primary (A)
Imax_secondary = Iout_peak;            % Maximum current in secondary (A)

% Results
disp("=== Phase-Shift Full Bridge DC-DC Converter Design ===");
disp(["Vin: ", num2str(Vin), " V"]);
disp(["Vout: ", num2str(Vout), " V"]);
disp(["Iout: ", num2str(Iout), " A"]);
disp(["Estimated Efficiency: ", num2str(efficiency * 100), " %"]);
disp(["Switching Frequency: ", num2str(Fsw / 1e3), " kHz"]);
disp(["Inductance L: ", num2str(L), " H"]);
disp(["Primary Inductance L1: ", num2str(L1), " H"]);
disp(["Secondary Inductance L2: ", num2str(L2), " H"]);
disp(["Capacitance C: ", num2str(C), " F"]);
disp(["Primary Current Imax: ", num2str(Imax_primary), " A"]);
disp(["Secondary Current Imax: ", num2str(Imax_secondary), " A"]);
disp(["Output Current Ripple: ", num2str(Iout_ripple * 100), " %"]);
disp(["Output Voltage Ripple: ", num2str(Vout_ripple * 100), " %"]);

