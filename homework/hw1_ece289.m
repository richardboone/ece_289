dt = 1e-2; % seconds
tdata = -0.1:dt:3.1; % time vector
y = 20*cos(4*tdata); % true angle, in degrees
y_enc = round(y); % discretized measurement from encoder
vel = -80*sin(4*tdata);
%part b
vel_est = zeros(length(vel),1);
previtems =  zeros(length(vel),1);
nextitems =  zeros(length(vel),1);
zindex = find(tdata == 0);
tindex = find(tdata == 3);
for m=zindex:tindex
    previtem = y_enc(m-1);
    previtems(m) = previtem;
    nextitem = y_enc(m+1);
    nextitems(m) = nextitem;
    vel_est(m) = (nextitem - previtem)/(2.0*dt);
end

%plot part b
figure(1);
clf;
subplot(3, 1, 1);
smvel = vel(zindex:tindex);
smtdata = tdata(zindex:tindex);
%vel_est = vel_est(zindex:tindex);
plot(smtdata, smvel)
hold on
plot(smtdata, vel_est(zindex:tindex))
hold off

%part c
vel_est_two = zeros(length(vel),1);
for m=zindex:tindex
    previtem = y_enc(m-10);
    nextitem = y_enc(m+10);
    vel_est_two(m) = (nextitem - previtem)/(2.0*dt*10);
end

%plotting part c
figure(1);
subplot(312);
plot(smtdata, smvel)
hold on
plot(smtdata, vel_est_two(zindex:tindex),'.-')
hold off

%part d
vel_est_mat = zeros(length(vel), 10);
%generate all velocity estimates for N = 1:10
for m=1:10
    for n=zindex:tindex
        previtem = y_enc(n - m);
        nextitem = y_enc(n + m);
        vel_est_mat(n, m) = (nextitem - previtem)/(2*dt*m);
    end
end

weights = zeros(10, 1);
k = 1/385;
for m=1:10
    weights(m) = k * m*m;
end
vel_est_d = zeros(length(vel), 1);
for m = zindex:tindex
    vel_est_d(m) = dot(vel_est_mat(m,:), transpose(weights));
end
%vel_est_d = dot(vel_est_mat, weights, 1)

%plotting part d
figure(1);
subplot(313);
plot(smtdata, smvel)
hold on
plot(smtdata, vel_est_d(zindex:tindex))
hold off

vb2 = filter([1, 0, -1], 2*dt, y_enc);
vc2 = filter([1, 0, 0, 0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0, 0, -1], 2*dt*10, y_enc);

vector_d2 = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10];
vd2 = filter(vector_d2, 2*dt/k, y_enc);


%E bmax
bmax = max(abs(transpose(vel_est(zindex:tindex)) - vb2(zindex+1:tindex+1)));

cmax = max(abs(transpose(vel_est_two(zindex:tindex)) - vc2(zindex+10:tindex+10)));
dmax = max(abs(transpose(vel_est_d(zindex:tindex)) - vd2(zindex+10:tindex+10)));

fprintf("max difference part b:")
bmax
fprintf("max difference part c:")
cmax
fprintf("max difference part d:")
dmax
fprintf("Because the differences for part b and c are both 0, and the difference for part d is very close to 0, we know that the filter() function is doing the same thing as each of the individual parts")
