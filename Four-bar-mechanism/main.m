
int main()
{
l1 = 10;
l2 = 25;
l3 = 17;
l4 = 30;
omega1 = 250;
alpha1 = 0;
hd = pi/180;
du = 180/pi;
theta_3 = [];
theta_1 = [];
theta_2 = [];
omega_2 = [];
omega_3 = [];
alpha_2 = [];
alpha_3 = [];
for i = 1:361
    theta1 = (i-1)*hd;
    theta_1 = [theta_1,theta1*du];
    [theta,omega,alpha] = caculate_all(theta1,omega1,alpha1,l1,l2,l3,l4);
    
    theta2 = theta(1);
    theta3 = theta(2);
    theta_3 = [theta_3,theta3*du];
    theta_2 = [theta_2,theta2*du];
    
    omega_2 = [omega_2,omega(1)];
    omega_3 = [omega_3,omega(2)];
    
    alpha_2 = [alpha_2,alpha(2)];
    alpha_3 = [alpha_3,alpha(1)];
end
figure(1)
subplot(2,2,1);
plot(theta_1,theta_3,theta_1,theta_2);

subplot(2,2,2);
plot(theta_1,omega_2,theta_1,omega_3);

subplot(2,2,3);
plot(theta_1,alpha_2,theta_1,alpha_3);
figure(1)
subplot(2,2,4);
x(1) = 0;
y(1) = 0;
x(2) = l1*cos(45*hd);
y(2) = l1*sin(45*hd);
x(3) = l4+l3*cos(theta_3(46)*hd);
y(3) = l3*sin(theta_3(46)*hd);
x(4) = l4;
y(4) = 0;
plot(x,y)
axis([-l1*1.5,l4*1.5,-l1-l2,l1+l2]);

figure(2);
m = moviein(20);
j=0;
for n1=1:5:360
    j = j+1;
    clf;
    x(1) = 0;
    y(1) = 0;
    x(2) = l1*cos((n1-1)*hd);
    y(2) = l1*sin((n1-1)*hd);
    x(3) = l4+l3*cos(theta_3(n1)*hd);
    y(3) = l3*sin(theta_3(n1)*hd);
    x(4) = l4;
    y(4) = 0;
    plot(x,y)
    hold on;
    axis([-l1*1.5,l4*1.5,-l1-l2,l1+l2]);
    m(j) = getframe;
end
movie(m,5,25);

function [theta,omega,alpha] = caculate_all(theta1,omega1,alpha1,l1,l2,l3,l4)
x = sqrt((l1^2+l4^2-2*cos(theta1)*l1*l4));
phi1 = asin(l1*sin(theta1)/x);
phi2 = acos((l3^2+x^2-l2^2)/(2*l3*x));
phi = [phi1,phi2];
theta3 = pi-(phi1+phi2);
theta2 = asin((l3*sin(phi2))/l2);
theta = [theta2,theta3];

omega = [cos(theta3)*l3,-cos(theta2)*l2;sin(theta3)*l3,-sin(theta2)*l2]\[cos(theta1)*l1*omega1;sin(theta1)*l1*omega1];
omega2 = omega(2);
omega3 = omega(1);

a = [cos(theta3)*l3,-cos(theta2)*l2;sin(theta3)*l3,-sin(theta2)*l2];
b1 = -sin(theta1)*omega1^2*l1+cos(theta1)*l1*alpha1-sin(theta2)*l2*omega2^2+sin(theta3)*omega3^2*l3;
b2 = cos(theta1)*omega1^2*l1+sin(theta1)*alpha1*l1+cos(theta2)*omega2^2*l2-cos(theta3)*omega3^2*l3;
b = [b1;b2];
alpha = a\b;
end
