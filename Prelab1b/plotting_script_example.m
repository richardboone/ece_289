%% First, extract variables of interest from the "struct"
% where they are stored in the "MATLAB workspace":
Kp = 100;
Kd = 1;
T = 0.005;
f = 0.9;
A = (1-f)/T;
L1 = 14.5;
L2 = 10.5;
timetot = 10;
ytraj = [-2,   -2,   -2,   -2,   -2,   -2,   0,    1,    2,    3,    4,    5,    6,    7 ,   8,    9,    10,   11,   12,   13,   14,   15,   15,   15,   15,   15,   15,   15,  15,  15,  15,  15,  15,   14,   13,   12,   11,   10,   9,    8,    7,    6,    6,    6, 6, 6, 6,  6,  6,     7,     8,     9,     10,    11,    12,    12, 12, 12, 11.5, 11.25, 11, 11, 11, 11, 11, 11];
xtraj = [15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 14.5, 13.5, 12.5, 11.5, 10.5, 9.5, 8.5, 7.5, 6.5, 5.5, 4.75, 4.75, 4.75, 4.75, 4.75, 4.75, 4.75, 4.75, 4.75, 4.75, 5.75, 7, 8, 9, 10, 11, 12.25, 12.25, 12.25, 12.25, 12.25, 12.25, 12.25, 11, 10, 9,  8,    7,     6,  6,  6,  6,  6,  6];

t = my_data.time;
% You need to pay attention to the Simulink model, to interpret
% what each signal is, going sequentially (top to bottom ) into
% the "mux" before the "To Workspace" block, at the right in the model.

ang = my_data.signals.values(:,1);
des = my_data.signals.values(:,2);
cvel = my_data.signals.values(:,3);
%ang2 = my_data.signals.values(:,4);
ang2 = my_data.signals.values(:,5);
des2 = my_data.signals.values(:,6);

yloc = zeros(10001, 1);
xloc = zeros(10001, 1);
ylocref = zeros(10001, 1);
xlocref = zeros(10001, 1);


for i=1:3000
    yloc(i) = forwardKY(ang(i), ang2(i), L1, L2);
    xloc(i) = forwardKX(ang(i), ang2(i), L1, L2);
    ylocref(i) = forwardKY(des(i), des2(i), L1, L2);
    xlocref(i) = forwardKX(des(i), des2(i), L1, L2);
end
figure(11); clf
if 1
    plot(t,des,'b-');
    hold on
    plot(t,ang,'b.');
    hold on
    plot(t, des2, 'r-');
    hold on
    plot(t, ang2, 'r.');
    legend('My Trajectory Motor 1','Motor 1 Angle (rad)', 'My Trajectory Motor 2','Motor 2 Angle (rad)')
elseif 0
    plot(xloc, yloc,'b-');
    hold on
    plot(xlocref, ylocref, 'r-');
    legend('My EE Trajectory', 'Reference EE Trajectory');
end
% hold off
% hold on
% plot(t,cvel,'g-');
%hold on
%plot(t, ang2, 'y-');
title('From: plotting\_script\_example.m')
xlabel('Time (s)')
ylabel('[Here, we have mixed units...]')
grid on

set(gca,'FontSize',14); % Easier to read, in a print-out...


function y = forwardKY(theta1, theta2, L1, L2)
    y = (L1 * sin(theta1)) + (L2 * sin(theta1 + theta2));
end
function x = forwardKX(theta1, theta2, L1, L2)
   x = L1 * cos(theta1) + L2 * cos(theta1 + theta2);
end
