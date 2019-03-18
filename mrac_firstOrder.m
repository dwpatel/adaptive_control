
clear;
clc;

a = 1;
b = 3;
a_ref = -4;
b_ref = 4;
r = 'r = 4sin(3t)';
[t,X] = ode45(@(t,X) func(t,X,4*sin(3*t),a,b,a_ref,b_ref),[0 8],[0; 0; 0; 0]);

k_x_need = (a_ref-a)/b;
k_r_need = b_ref/b;

figure();
plot(t,X(:,1),'Linewidth',2);
hold on;
plot(t,X(:,2),'--','Linewidth',2);
xlabel('time [second]');
ylabel('x');
legend('prediction','reference');
title(r);

figure();
plot(t,X(:,3),'Linewidth',2);
hold on;
plot(t,k_x_need*ones(numel(t),1),'--','Linewidth',2);
xlabel('time [second]');
ylabel('k_x');
legend('prediction','reference');
title('k_x');

figure();
plot(t,X(:,4),'Linewidth',2);
hold on;
plot(t,k_r_need*ones(numel(t),1),'--','Linewidth',2);
xlabel('time [second]');
ylabel('k_r');
legend('prediction','reference');
title('k_r');


function dX = func(t,X,r,a,b,a_ref,b_ref)

x = X(1,1);
x_m = X(2,1);
k_x = X(3);
k_r = X(4);
g = 2; % gamma

e = x - x_m;
u = k_x*x + k_r*r;

dx = a*x + b*u;
dx_m = a_ref*x_m + b_ref*r; 
dk_x = -g*x*e;
dk_r = -g*r*e; 

dX = [dx; dx_m; dk_x; dk_r];
end