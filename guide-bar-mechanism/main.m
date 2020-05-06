a = 10;
b = 7;
omega1 = 10;
alpha1 = 0;
c_all = [];
theta_1 = [];
theta_2 = [];
omega_2 = [];
vc_all = [];
alpha_2 = [];
ac_all = [];
hd = pi/180;
du = 180/pi;

for i=1:361
	theta1 = (i-1)*hd;
	theta_1 = [theta_1,(i-1)];
	[theta2,c,omega2,vc,alpha2,ac] = caculate_all(a,b,theta1,omega1,alpha1);
	theta_2 = [theta_2,theta2*du];
	c_all = [c_all,c];
	omega_2 = [omega_2,omega2];
	vc_all = [vc_all,vc];
    alpha_2 = [alpha_2,alpha2];
    ac_all = [ac_all,ac];
end

figure(1);
figure(1)
subplot(2,2,1);
plotyy(theta_1,theta_2,theta_1,c_all);
subplot(2,2,2);
plotyy(theta_1,omega_2,theta_1,vc_all);
subplot(2,2,3);
plotyy(theta_1,alpha_2,theta_1,ac_all);
figure(2);
figure(2)
hold on;
m = moviein(50);
j = 0;
for i=1:5:361
	j = j+1;
	clf;
	x(1) = 0;
	y(1) = 0;
	x(2) = (a+b)*1.5*cos(theta_2(i)*hd);
	y(2) = (a+b)*1.5*sin(theta_2(i)*hd);
	x(3) = c_all(i)*cos(theta_2(i)*hd);
	y(3) = c_all(i)*sin(theta_2(i)*hd);
	x(4) = b*cos(theta_1(i)*hd);
	y(4) = a+b*sin(theta_1(i)*hd);
	x(5) = 0;
	y(5) = a;
	x(6) = 0;
	y(6) = 0;
	plot(x,y);
    axis equal;
	axis([-b*1.5,b*1.5,-a*0.2,(a+b)*1.5]);
    hold on;
	m(j) = getframe;
end;
movie(m,5,25);

function [theta2,c,omega2,vc,alpha2,ac]=caculate_all(a,b,theta1,omega1,alpha1);
c = sqrt((b*cos(theta1))^2+(a+b*sin(theta1))^2);
theta2 = acos(b*cos(theta1)/c);
answer = [c*sin(theta2),-cos(theta2);c*cos(theta2),sin(theta2)]\[b*sin(theta1)*omega1;b*cos(theta1)*omega1];
omega2 = answer(1);
vc = answer(2);
answer = [cos(theta2),-sin(theta2)*c;sin(theta2),c*cos(theta2)]\[sin(theta2)*omega2*vc-b*(omega1^2*cos(theta1)+sin(theta1)*alpha1)+c*cos(theta2)*omega2^2;b*(-sin(theta1)*omega1^2+cos(theta1)*alpha1)+c*sin(theta2)*omega2^2-cos(theta2)*omega2*vc]
alpha2 = answer(2);
ac = answer(1);
end

