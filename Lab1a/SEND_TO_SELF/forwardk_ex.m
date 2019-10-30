%% First, extract variables of interest from the "struct"
% where they are stored in the "MATLAB workspace":
% Kp = 20;
% Kd = 10;
% T = 0.005;
% f = 0.9;
% A = (1-f)/T;
% L1 = 11.2;
% L2 = 8;
L1 = 14.5;
L2 = 10.5;

t = my_data1.time;

% You need to pay attention to the Simulink model, to interpret
% what each signal is, going sequentially (top to bottom ) into
% the "mux" before the "To Workspace" block, at the right in the model.

ang = my_data1.signals.values(:,1);
des = my_data1.signals.values(:,2);
cvel = my_data1.signals.values(:,3);
%ang2 = my_data.signals.values(:,4);
ang2 = my_data1.signals.values(:,5);
des2 = my_data1.signals.values(:,6);

yloc = zeros(900, 1);
xloc = zeros(900, 1);
ylocref = zeros(900, 1);
xlocref = zeros(900, 1);


for i=1:900
    yloc(i) = forwardKY(ang(i), ang2(i), L1, L2);
    xloc(i) = forwardKX(ang(i), ang2(i), L1, L2);
    ylocref(i) = forwardKY(des(i), des2(i), L1, L2);
    xlocref(i) = forwardKX(des(i), des2(i), L1, L2);
end
figure(11); clf
if 0
    plot(t,des,'b-');
    hold on
    plot(t,ang,'b.');
    hold on
    plot(t, des2, 'r-');
    hold on
    plot(t, ang2, 'r.');
    legend('My Trajectory Motor 1','Motor 1 Angle (rad)', 'My Trajectory Motor 2','Motor 2 Angle (rad)')
elseif 1
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
