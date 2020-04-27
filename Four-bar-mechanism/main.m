
l1 = 101.6;
l2 = 254;
l3 = 177.8;
l4 = 304.8;
omega1 = 250;
alpha1 = 0;
hd = pi/180;
du = 180/pi;
theta_3 = [];
theta_1 = [];
theta_2 = [];
omega_2 = [];
omega_3 = [];
for i = 1:361
    theta1 = (i-1)*hd;
    theta_1 = [theta_1,theta1*du];
    [theta,omega] = caculate_all(theta1,omega1,alpha1,l1,l2,l3,l4);
    theta2 = theta(1);
    theta3 = theta(2);
    theta_3 = [theta_3,theta3*du];
    theta_2 = [theta_2,theta2*du];
    omega_2 = [omega_2,omega(1)];
    omega_3 = [omega_3,omega(2)];
end
subplot(2,2,1);
plot(theta_1,theta_3,theta_1,theta_2)
axis([0,360,0,200]);
subplot(2,2,2);
plot(theta_1,omega_2,theta_1,omega_3);
axis([0,360,-200,200]);
function [theta,omega] = caculate_all(theta1,omega1,alpha1,l1,l2,l3,l4)
x = sqrt((l1^2+l4^2-2*cos(theta1)*l1*l4));
phi1 = asin(l1*sin(theta1)/x);
phi2 = acos((l3^2+x^2-l2^2)/(2*l3*x));
phi = [phi1,phi2];
theta3 = pi-(phi1+phi2);
theta2 = asin((l3*sin(phi2))/l2);
theta = [theta2,theta3];
omega = [cos(theta3)*l3,-cos(theta2)*l2;sin(theta3)*l3,-sin(theta2)*l2]\[cos(theta1)*l1*omega1;sin(theta1)*l1*omega1];
end
