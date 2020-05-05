clear;
hd = pi/180;
du = 180/pi;
l1 = 100;
l2 = 300;
omega1 = 10
alpha1 = 0


theta_2 = [];
s_all = [];
theta_1 = [];
omega_2 = [];
v_all = [];
alpha_2 = [];
a_all = [];

for i=1:721
	theta1 = (i-1)*hd;
	[theta2,s,omega2,v,alpha2,a] = caculate_all(l1,l2,theta1,omega1,alpha1);
	theta_2 = [theta_2,theta2*du];
	s_all = [s_all,s];
    theta_1 = [theta_1,theta1*du];
	omega_2 = [omega_2,omega2];
	v_all = [v_all,v];
	alpha_2 = [alpha_2,alpha2];
	a_all = [a_all,a];

figure(1)
subplot(2,2,1);
plotyy(theta_1,theta_2,theta_1,s_all);
figure(1)
subplot(2,2,2);
plotyy(theta_1,omega_2,theta_1,v_all);
figure(1)
subplot(2,2,3);
plotyy(theta_1,alpha_2,theta_1,a_all);

figure(2);
m = moviein(20);
j = 0;
end
for i = 1:5:361
	j = j+1;
	clf;
	x(1) = 0;
	y(1) = 0;
	x(2) = cos((i-1)*hd)*l1;
	y(2) = sin((i-1)*hd)*l1;
	x(3) = s_all(i);
	y(3) = 0;
    x(4) = 0;
    y(4) = 0;
	plot(x,y);
    hold on;
    plot([0,(l1+l2)*1.5],[0,0]);
    hold on;
    rectangle('Position',[-l1,-l1,2*l1,2*l1],'Curvature',[1,1]);
	axis([-l1*1.5,(l1+l2)*1.5,-l1*1.5,l1*1.5]);
    axis equal;
	m(j)=getframe;
end
movie(m,5,25);

function [theta2,s,omega2,v,alpha2,a] = caculate_all(l1,l2,theta1,omega1,alpha1)
theta2 = asin(l1*sin(theta1)/l2*(-1));
s = l1*cos(theta1)+l2*cos(theta2);
omega2 = (-1*l1*cos(theta1)*omega1)/(cos(theta2)*l2);
v = -sin(theta2)*omega2*l2-sin(theta1)*l1*omega1;
alpha2 = (-l1*(-sin(theta1)*omega1*omega1+cos(theta1)*alpha1)+l2*sin(theta2)*omega2*omega2)/(cos(theta2)*l2);
a = -l2*(omega2*omega2*cos(theta2)+sin(theta2)*alpha2)-l1*(cos(theta1)*omega1*omega1+sin(theta1)*alpha1);
end



