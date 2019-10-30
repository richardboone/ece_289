figure(33)
clf


Kp = 10;
Kd = 1;
T = 0.005;
f = 0.9;
A = (1-f)/T;
L1 = 11.2;
L2 = 8;
% set 1:1 scaling and axes:
axis ([-1 18 -1 18]);
axis equal
hold on
grid on

% Define maze walls:
x2 = [17.5,17.5,3,3,13.5,13.5,6.5,9]; %10];
y2 = [0,17,17,4.5,4.5,13,13,11]; %9-sqrt(2)];
x3 = [13.5,13.5,6.5,6.5,11,11,9]; %10];
y3 = [0,13,13,7.5,7.5,11,11];

% Sort corner locations, to set axis tick marks:
xu = [x2, x3]; yu = [y2,y3];
xu = sort(xu); yu = sort(yu);
fi = find(xu(2:end)~=xu(1:end-1));
xu = [xu(fi), xu(end)];
fi = find(yu(2:end)~=yu(1:end-1));
yu = [yu(fi), yu(end)];
set(gca,'XTick',xu,'YTick',yu)

% Define waypoints, wrt center of path:
xm = .5*(x2(1:end-1)+x3);
ym = .5*(y2(1:end-1)+y3);
dx = diff(xm); dy = diff(ym);
d = (dx.^2 + dy.^2).^.5;
dway = [0, cumsum(d)];
npts = 50;
nlist = max(dway)*[0:(1/npts):1];
xp2 = interp1(dway,x2(1:end-1),nlist);
yp2 = interp1(dway,y2(1:end-1),nlist);
xp3 = interp1(dway,x3,nlist);
yp3 = interp1(dway,y3,nlist);

% Draw the tick marks every 2% along the path.
% Draw a dash line every 10% along the path.
for n=1:length(xp2)
    % p0 = plot([xp2(n) xp3(n)],[yp2(n) yp3(n)],'k:');
    p1 = plot([xp2(n) .9*xp2(n)+.1*xp3(n)],[yp2(n) .9*yp2(n)+.1*yp3(n)],'k-');
    p2 = plot([xp3(n) .9*xp3(n)+.1*xp2(n)],[yp3(n) .9*yp3(n)+.1*yp2(n)],'k-');
    if mod(n,5)==1
        p0 = plot([xp2(n) xp3(n)],[yp2(n) yp3(n)],'k:');
        %set(p0,'LineWidth',2);
        set(p1,'LineWidth',4);
        set(p2,'LineWidth',4);
    end
end
set(p0,'LineWidth',2,'Color',[0 .7 0],'LineStyle',':');

% Draw the actual MAZE:
plot (x2(1:end-1),y2(1:end-1),'-','LineWidth',6);
plot (x3,y3,'-','LineWidth',6);

plot(xloc, yloc,'b-');
hold on
plot(xlocref, ylocref, 'r-');
% Label the start and finish lines:
text(15.5,-.5,'start line','HorizontalAlignment','center')
text(7.7,11.6,'finish line','HorizontalAlignment','center','Rotation',-40)

% add (0,0) location coordinate
textString = sprintf('(0,0)');
text(0 + 0.3, 0, textString, 'FontSize', 15);
