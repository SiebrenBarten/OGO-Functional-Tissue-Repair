clear all; 

%% Parameters
E_m = 1.1811e+06; % Young's modulus of the matrix % functie
E_f = 5.3481e+08; % Young's modulus of the fibers % functie
V_f = 0.02; % Volume fraction of the fibers (variabel)
nu_m = 0.14; % Poisson's ratio of the matrix  %functie
alpha = 0; % angle of the fibers with respect to the applied load (voor tweede fiber)
theta = 0:1:180; % Range of angles to plot (in degrees)

%% effectieve Young's Modulus 
E_eff = E_m * (1 + nu_m * (V_f * E_f / E_m - 1) * cosd(theta).^2) ./ (1 - V_f * nu_m * cosd(theta).^2);


%% grafiekje, met variabele hoek 
% Plot the curve
plot(theta, E_eff/1e9, 'LineWidth', 2);
xlabel('Angle of fibers with respect to applied load (degrees)');
ylabel('Effective Young''s modulus (GPa)');
title('Relationship between effective Young''s modulus and fiber angle, vf - 0.5');

%% secundairi fiber 

% Given parameters
V_fiber1 = 0.05; 
E_fiber1 = 10e6;
alpha_fiber1 = 15*pi/180;
V_matrix = 0.45;
E_matrix = 35e3;
E_fiber2 = 1e6;

% Range of secondary fiber volume fraction and angle
V_fiber2_range = linspace(0, 0.3, 50);
alpha_fiber2_range = linspace(0, pi/2, 50);

% Initialize matrices to store results
E_eff_vfiber2 = zeros(size(V_fiber2_range));
E_eff_afiber2 = zeros(size(alpha_fiber2_range));

% Calculate effective Young's modulus for varying V_fiber2 and alpha_fiber2
for i = 1:length(V_fiber2_range)
    V_fiber2 = V_fiber2_range(i);
    E_eff_vfiber2(i) = V_fiber1*E_fiber1*cos(alpha_fiber1)^2 + V_fiber2*E_fiber2*cos(alpha_fiber1)^2 + V_matrix*E_matrix;
end

for i = 1:length(alpha_fiber2_range)
    alpha_fiber2 = alpha_fiber2_range(i);
    E_eff_afiber2(i) = V_fiber1*E_fiber1*cos(alpha_fiber1)^2 + V_fiber2*E_fiber2*cos(alpha_fiber2)^2 + V_matrix*E_matrix;
end

% Plot the results
%figure;
%plot(V_fiber2_range, E_eff_vfiber2, 'LineWidth', 2);
%xlabel('V_{fiber2}');
%ylabel('Effective Young''s Modulus');
%title('Effect of Secondary Fiber Volume Fraction');
figure;
plot(alpha_fiber2_range*180/pi, E_eff_afiber2, 'LineWidth', 2);
xlabel('\alpha_{fiber2} (deg)');
ylabel('Effective Young''s Modulus');
title('Effect of Secondary Fiber Angle');