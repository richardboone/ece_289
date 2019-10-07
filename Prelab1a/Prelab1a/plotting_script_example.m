%% First, extract variables of interest from the "struct"
% where they are stored in the "MATLAB workspace":

t = my_data.time;

% You need to pay attention to the Simulink model, to interpret
% what each signal is, going sequentially (top to bottom ) into
% the "mux" before the "To Workspace" block, at the right in the model.

ang = my_data.signals.values(:,1);
des = my_data.signals.values(:,2);

figure(11); clf
plot(t,des,'b-');
hold on
plot(t,ang,'r.');
legend('My Trajectory','Motor Angle (rad)')
title('From: plotting\_script\_example.m')
xlabel('Time (s)')
ylabel('[Here, we have mixed units...]')
grid on

set(gca,'FontSize',14); % Easier to read, in a print-out...