clc; close all; clear all;
% Derivation of transfer function for a 7th-order low-pass elliptic filter
% Define the symbolic variables
syms s L1 L2 L3 C1 C2 C3 C4 C5 C6 C7 R1 R2 V_R2

% Define the impedances with symbolic variables
Z_L1 = s*L1;
Z_L2 = s*L2;
Z_L3 = s*L3;
Z_C1 = 1/(s*C1);
Z_C2 = 1/(s*C2);
Z_C3 = 1/(s*C3);
Z_C4 = 1/(s*C4);
Z_C5 = 1/(s*C5);
Z_C6 = 1/(s*C6);
Z_C7 = 1/(s*C7);
Z_R1 = R1;
Z_R2 = R2;

Z_C1_L1 = par(Z_C1, Z_L1); % impedance of capacitor C1 and inductor L1 connected in parallel
Z_C2_L2 = par(Z_C2, Z_L2); % impedance of capacitor C2 and inductor L2 connected in parallel
Z_C3_L3 = par(Z_C3, Z_L3); % impedance of capacitor C3 and inductor L3 connected in parallel

Z_R2_C7 = par(Z_R2, Z_C7); % impedance of resistive R2 and capacitor C7 connected in parallel

% parallel C7 is connected in series with the parallel impedance of C3, L3
Z_R2_C7_C3_L3 = Z_R2_C7 + Z_C3_L3;

% component series voltage divider
V_R2_C7_C3_L3 = Z_R2_C7_C3_L3 / Z_R2_C7 * V_R2;

% and the result is connected in parallel with C6
Z_R2_C7_C3_L3_C6 = par(Z_R2_C7_C3_L3, Z_C6);

% voltages of parallel elements are equal
V_R2_C7_C3_L3_C6 = V_R2_C7_C3_L3;

% and the result obtained is connected in series with the parallel impedance of C2 and L2
Z_R2_C7_C3_L3_C6_C2_L2  = Z_R2_C7_C3_L3_C6 + Z_C2_L2;

% component series voltage divider
V_R2_C7_C3_L3_C6_C2_L2 = Z_R2_C7_C3_L3_C6_C2_L2 / Z_R2_C7_C3_L3_C6 * V_R2_C7_C3_L3;

% and the result is then connected in parallel with C5
Z_R2_C7_C3_L3_C6_C2_L2_C5 = par(Z_R2_C7_C3_L3_C6_C2_L2, Z_C5);

% voltages of parallel elements are equal
V_R2_C7_C3_L3_C6_L2_C5 = V_R2_C7_C3_L3_C6_C2_L2;

% and the result is then connected in series with the parallel impedance of C1 and L1
Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1  = Z_R2_C7_C3_L3_C6_C2_L2_C5 + Z_C1_L1;

% component series voltage divider
V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1 = Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1 / Z_R2_C7_C3_L3_C6_C2_L2_C5 * V_R2_C7_C3_L3_C6_C2_L2;

% and the result is then connected in parallel with C4
Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4 = par(Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1, Z_C4);

% voltages of parallel elements are equal
V_R2_C7_C3_L3_C6_L2_C5_C1_L1_C4 = V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1;

% and the result is then connected in parallel with R1
Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1 = par(Z_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4, Z_R1);

% voltages of parallel elements are equal
V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1 = V_R2_C7_C3_L3_C6_L2_C5_C1_L1_C4;

% Total equivalent impedance
V1 = V_R2_C7_C3_L3_C6_C2_L2_C5_C1_L1_C4_R1;

% Define the transfer function H(s)
H_s = V_R2/V1;

% Simplify the transfer function
H_s_simp = simplify(H_s);

% Display the simplified transfer function
disp('The transfer function H(s) is:');
H_s_simp

% Substitute specific values
L1_val = 470e-9;  % 470 nH
L2_val = 390e-9;  % 390 nH
L3_val = 390e-9;  % 390 nH
C1_val = 1e-12;   % 1 pF
C2_val = 5.6e-12; % 5.6 pF
C3_val = 4.7e-12; % 4.7 pF
C4_val = 22e-12;  % 22 pF
C5_val = 33e-12;  % 33 pF
C6_val = 22e-12;  % 22 pF
C7_val = 22e-12;  % 22 pF
R1_val = 200;     % 200 ohm
R2_val = 200;     % 200 ohm

% Substitute values into the transfer function
H_s_val = subs(H_s_simp, {L1, L2, L3, C1, C2, C3, C4, C5, C6, C7, R1, R2}, ...
                   {L1_val, L2_val, L3_val, C1_val, C2_val, C3_val, C4_val, C5_val, C6_val, C7_val, R1_val, R2_val});

H_s_val_simp = simplify(H_s_val);

% Convert symbolic function to numeric function for further analysis
[num, den] = numden(H_s_val_simp);
num = simplify(num);
den = simplify(den);

% % Display numerator and denominator with formatted output
% fprintf('Numerator: \n');
% disp(vpa(num, 3)); % Display with 4 significant figures
% 
% fprintf('Denominator: \n');
% disp(vpa(den, 3)); % Display with 4 significant figures

% Find the highest order coefficient of the denominator (s^7)
coefficient_den = sym2poly(den);
highest_order_coefficient = coefficient_den(1);

% Normalize the numerator and denominator
num_normalized = num / highest_order_coefficient;
den_normalized = den / highest_order_coefficient;

% Display normalized numerator and denominator
fprintf('Normalized numerator:\n');
disp(vpa(num_normalized, 3)); % Display with 4 significant figures

fprintf('Normalized denominator:\n');
disp(vpa(den_normalized, 3)); % Display with 4 significant figures

% Display the normalized transfer function
H_s_num_normalized = vpa(num_normalized, 3);
H_s_den_normalized = vpa(den_normalized, 3);

fprintf('Transfer function H(s):\n');
disp(sprintf('H(s) = (%s) / (%s)', char(H_s_num_normalized), char(H_s_den_normalized)));

% Extract the numerator and denominator
[num, den] = numden(H_s_val_simp);

% Convert symbolic expressions to numeric arrays
num = double(sym2poly(num));
den = double(sym2poly(den));

% Define the transfer function using the Control System Toolbox
sys = tf(num, den);

% Define frequency range from 1 kHz to 1 THz
freq_range = logspace(3, 12, 1000);

% Plot the Bode plot with the specified frequency range
figure;
bode(sys, freq_range);
grid on;
title('Bode Plot of H(s)');
