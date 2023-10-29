% Load the data from circular.mat
load('circular.mat');

% Constants
R = 0.208;  % Radius of the antenna array in meters
f = 5.5e9;  % Frequency of the signal in Hz
speed_of_light = 299792458; % meters per second

% Define rotations per ms and initial angular position
rotations_per_ms = 1 / 12.25 / 1000;  % Example value
initial_angular_position = 0;  % Initial angle in degrees (adjust as needed)

% Calculate angular position for each time value
phi = initial_angular_position + (rotations_per_ms * 360 * t);

% Create an array to store the multipath profile
theta_values = -180:180;  % Adjusted θ' values at 3-degree intervals
multipath_profile = zeros(size(theta_values));

% Calculate the multipath profile for different θ' values
for i = 1:length(theta_values)
    theta_prime = theta_values(i);
    mpsum = zeros(size(t));
    for j = 1:length(h)
        hk = h(j,2) / h(j,1);
        mpsum(j) = hk * exp(-1j * 2 * pi * (f/speed_of_light) * R * cosd(phi(j)-theta_prime));
    end
    multipath_profile(i) = abs(sum(mpsum)).^2; 
end

% Load the provided multipath profile values
load('MultipathProfile.mat');

% Plot both the calculated multipath profile and the provided values
plot(theta_values, multipath_profile, 'b', 'LineWidth', 2);
hold on;
% theta_values3 = -180:3:180;
% plot(theta_values3, P, 'r', 'LineWidth', 2);
hold off;

xlabel('θ'' (degrees)');
ylabel('Power (P)');
title('Multipath Profile Comparison');
legend('Calculated', 'Provided');
grid on;
