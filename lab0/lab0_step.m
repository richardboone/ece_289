dt = 5e-3;
figure(1);
clf;
plot(EncData.time, EncData.signals.values(:,1))
hold on;

plot(EncData1.time, EncData1.signals.values(:,1), '-r') 