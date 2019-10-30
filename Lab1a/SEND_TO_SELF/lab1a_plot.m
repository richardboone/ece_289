dt = 5e-3;
f = 0.9;
T = 0.005;
A = (1-f)/T;
Kp = 100;
Kd = 0.5;
Kp_2 = 200;
Kd_2 = 0.5;
L1 = 14.5;
L2 = 10.5;
figure(1);
clf;
if 0
    subplot(311);
    plot(my_data1.time, my_data1.signals.values(:,1), '-g')
    hold on
    plot(my_data1.time, my_data1.signals.values(:,2))
    title('motor 1')
    xlabel('Time (s)')
    ylabel('motor position (rad)')


    subplot(312);
    plot(my_data1.time, my_data1.signals.values(:,5), '-g')
    hold on
    plot(my_data1.time, my_data1.signals.values(:,6))
    title('motor 2')
    xlabel('Time (s)')
    ylabel('motor position (rad)')
elseif 1
    xgoal = zeros(1027, 1);
    ygoal = zeros(1027, 1);
    xactual = zeros(1027, 1);
    yactual = zeros(1027, 1);
    for i=1:1027
        xgoal(i) = InverseX(my_data1.signals.values(i,2), pi - my_data1.signals.values(i, 6), L1, L2);
        ygoal(i) = InverseY(my_data1.signals.values(i,2), pi - my_data1.signals.values(i, 6), L1, L2);
        xactual(i) = InverseX(my_data1.signals.values(i,1), pi - my_data1.signals.values(i, 5), L1, L2);
        yactual(i) = InverseY(my_data1.signals.values(i,1), pi - my_data1.signals.values(i, 5), L1, L2);
    end
    
    plot(xgoal, ygoal);
    hold on
    plot(xactual, yactual, '-g');
end

function x =  InverseX(theta1, theta2, L1, L2)
    x = L1*cos(theta1) + L2*cos(theta1 + theta2);
end

function y = InverseY(theta1, theta2, L1, L2)
    y = L1*sin(theta1) + L2*sin(theta1 + theta2);
end
