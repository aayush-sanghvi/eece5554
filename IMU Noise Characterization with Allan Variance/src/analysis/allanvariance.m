Fs = 40;
t0 = 1/Fs;
fl = readtable('imu_data.csv');

% orientation_x=fl{:,16};
% orientation_y=fl{:,17};
% orientation_z=fl{:,18};
linearacc_x=fl{:,27};
linearacc_y=fl{:,28};
linearacc_z=fl{:,29};
angularvel_x=fl{:,22};
angularvel_y=fl{:,23};
angularvel_z=fl{:,24};

% %orientation X
% 
% theta = cumsum(orientation_x, 1);
% maxNumM = 100;
% L = size(theta, 1);
% maxM = 2.^floor(log2(L/2));
% m = logspace(log10(1), log10(maxM), maxNumM).';
% m = ceil(m); % m must be an integer.
% m = unique(m); % Remove duplicates.
% tau = m*t0;
% avar = zeros(numel(m), 1);
% for i = 1:numel(m)
%     mi = m(i);
%     avar(i,:) = sum( ...
%         (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
% end
% avar = avar ./ (2*tau.^2 .* (L - 2*m));
% adev = sqrt(avar);
% 
% figure
% loglog(tau, adev)
% title('Allan Deviation Orientation X')
% xlabel('\tau');
% ylabel('\sigma(\tau)')
% grid on
% axis equal
% 
% %orientation Y
% theta = cumsum(orientation_y, 1);
% maxNumM = 100;
% L = size(theta, 1);
% maxM = 2.^floor(log2(L/2));
% m = logspace(log10(1), log10(maxM), maxNumM).';
% m = ceil(m); % m must be an integer.
% m = unique(m); % Remove duplicates.
% tau = m*t0;
% avar = zeros(numel(m), 1);
% for i = 1:numel(m)
%     mi = m(i);
%     avar(i,:) = sum( ...
%         (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
% end
% avar = avar ./ (2*tau.^2 .* (L - 2*m));
% adev = sqrt(avar);
% 
% figure
% loglog(tau, adev);
% title('Allan Deviation Orientation Y')
% xlabel('\tau')
% ylabel('\sigma(\tau)')
% legend('Manual Calculation', 'allanvar Function')
% grid on
% axis equal
% 
% %orientation Z
% theta = cumsum(orientation_z, 1);
% maxNumM = 100;
% L = size(theta, 1);
% maxM = 2.^floor(log2(L/2));
% m = logspace(log10(1), log10(maxM), maxNumM).';
% m = ceil(m); % m must be an integer.
% m = unique(m); % Remove duplicates.
% tau = m*t0;
% avar = zeros(numel(m), 1);
% for i = 1:numel(m)
%     mi = m(i);
%     avar(i,:) = sum( ...
%         (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
% end
% avar = avar ./ (2*tau.^2 .* (L - 2*m));
% adev = sqrt(avar);
% 
% figure
% loglog(tau, adev);
% title('Allan Deviation Orientation Z')
% xlabel('\tau')
% ylabel('\sigma(\tau)')
% legend('Manual Calculation', 'allanvar Function')
% grid on
% axis equal

%Linear Acceleration X
theta = cumsum(linearacc_x, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m); % m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev)
title('Allan Deviation Linear Acceleration X')
xlabel('\tau');
ylabel('\sigma(\tau)')
grid on
axis equal

% Find the index where the slope of the log-scaled Allan deviation is equal
% to the slope specified.
slope = 0;
logtau = log10(tau);
logadev = log10(adev);
dlogadev = diff(logadev) ./ diff(logtau);
[~, i] = min(abs(dlogadev - slope));

% Find the y-intercept of the line.
b = logadev(i) - slope*logtau(i);

% Determine the bias instability coefficient from the line.
scfB = sqrt(2*log(2)/pi);
logB = b - log10(scfB);
B = 10^logB

% Plot the results.
tauB = tau(i);
lineB = B * scfB * ones(size(tau));
figure
loglog(tau, adev, tau, lineB, '--', tauB, scfB*B, 'o')
title('Allan Deviation of Linear Acceleration X axis with Bias Instability')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('\sigma', '\sigma_B')
text(tauB, scfB*B, '0.00212')
grid on
axis equal

%Linear Acceleration Y
theta = cumsum(linearacc_y, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m); % m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev);
title('Allan Deviation Linear Acceleration Y')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('Manual Calculation', 'allanvar Function')
grid on
axis equal

%Linear Acceleration Z
theta = cumsum(linearacc_z, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m);% m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev);
title('Allan Deviation Linear Acceleration Z')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('Manual Calculation', 'allanvar Function')
grid on
axis equal

%Angular velocity X
theta = cumsum(angularvel_x, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m); % m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev)
title('Allan Deviation Angular Velocity X')
xlabel('\tau');
ylabel('\sigma(\tau)')
grid on
axis equal

% Find the index where the slope of the log-scaled Allan deviation is equal
% to the slope specified.
slope = 0;
logtau = log10(tau);
logadev = log10(adev);
dlogadev = diff(logadev) ./ diff(logtau);
[~, i] = min(abs(dlogadev - slope));

% Find the y-intercept of the line.
b = logadev(i) - slope*logtau(i);

% Determine the bias instability coefficient from the line.
scfB = sqrt(2*log(2)/pi);
logB = b - log10(scfB);
B = 10^logB

% Plot the results.
tauB = tau(i);
lineB = B * scfB * ones(size(tau));
figure
loglog(tau, adev, tau, lineB, '--', tauB, scfB*B, 'o')
title('Allan Deviation of Angular Velocity X axis with Bias Instability')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('\sigma', '\sigma_B')
text(tauB, scfB*B, '0.0001162')
grid on
axis equal

%Angular velocity Y
theta = cumsum(angularvel_y, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m); % m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev);
title('Allan Deviation Angular Velocity Y')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('Manual Calculation', 'allanvar Function')
grid on
axis equal

%ANgular velocity Z
theta = cumsum(angularvel_z, 1);
maxNumM = 100;
L = size(theta, 1);
maxM = 2.^floor(log2(L/2));
m = logspace(log10(1), log10(maxM), maxNumM).';
m = ceil(m);% m must be an integer.
m = unique(m); % Remove duplicates.
tau = m*t0;
avar = zeros(numel(m), 1);
for i = 1:numel(m)
    mi = m(i);
    avar(i,:) = sum( ...
        (theta(1+2*mi:L) - 2*theta(1+mi:L-mi) + theta(1:L-2*mi)).^2, 1);
end
avar = avar ./ (2*tau.^2 .* (L - 2*m));
adev = sqrt(avar);

figure
loglog(tau, adev);
title('Allan Deviation Angular Velocity Z')
xlabel('\tau')
ylabel('\sigma(\tau)')
legend('Manual Calculation', 'allanvar Function')
grid on
axis equal



