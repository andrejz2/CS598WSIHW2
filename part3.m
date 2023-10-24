% Load the data from circular.mat
load('circular.mat');

% Constants
R = 0.208;  % Radius of the antenna array in meters
f = 5.5e9;  % Frequency of the signal in Hz

% Calculate the time difference between consecutive timestamps
time_diff = diff(t);
angular_velocity = 360 / (12.25 / time_diff(1));  % Degrees per second

% Calculate angular positions (φ) for each measurement in radians
phi = cumsum(angular_velocity * time_diff) * pi / 180; % Convert to radians

% Create an array to store the multipath profile
theta_values = -180:180;  % Adjusted θ' values at 3-degree intervals
multipath_profile = zeros(size(theta_values));

% Calculate the multipath profile for different θ' values
for i = 1:length(theta_values)
    mpsum = zeros(size(theta_values));
    for j = 1:length(theta_values)
        theta_prime = theta_values(i) - theta_values(j);  % θ' in degrees
        hk = h(i);
        mpsum(j) = abs((hk * exp(1j * 2 * pi * f * R * cos(theta_prime)))).^2;
    end
    multipath_profile(i) = sum(mpsum); 
end

% Normalize the multipath profile for better visualization
multipath_profile = multipath_profile / max(multipath_profile);

% Load the provided multipath profile values
load('MultipathProfile.mat');

% Plot both the calculated multipath profile and the provided values
plot(theta_values, multipath_profile, 'b', 'LineWidth', 2);
hold on;
plot(theta_values, P, 'r', 'LineWidth', 2);
hold off;

xlabel('θ'' (degrees)');
ylabel('Normalized Power (P)');
title('Multipath Profile Comparison');
legend('Calculated', 'Provided');
grid on;
