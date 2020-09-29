%Recursive Least squares for an adaptative controller
%Adrian J Guel C
%29/Sep/2020
clear all
close all
%% Global parameteres
gamma=1;
a=1;
n=2;
ts=1e-1;
%% Finding the initial condition of our parameters
num=[1];
den=[1,5,10];
out=sim('experimentident',30);
t=out.experiment{1}.Values.Time;
u=out.experiment{1}.Values.Data(:,1);
y=out.experiment{1}.Values.Data(:,2);
[theta_0,P,f_0]=LeastSquaresOffline(u,y,n,a,gamma);
G=tf(num,den);
numdi=zeros(1,n);
dendi=zeros(1,n+1);
dendi(1)=1;
for i=1:n
    numdi(i)=theta_0(n+i);
    dendi(i+1)=-theta_0(i);
end
sysi=tf(numdi,dendi,ts);
step(G,5)
hold on
step(sysi,5,'k')
%% Recursive LQS simulation
figure
num=[1];
den=[1,5,8];
G=tf(num,den);
t = 0:ts:20;
u=sin(t);
y=lsim(G,u,t);
[theta_k,P_k,f_k]=recursiveleastsquares(u(1),y(1),P,theta_0,f_0',a,gamma,n);
for k=i:length(t)
    [theta_k,P_k,f_k]=recursiveleastsquares(u(k),y(k),P_k,theta_k,f_k,a,gamma,n);
end
numdi=zeros(1,n);
dendi=zeros(1,n+1);
dendi(1)=1;
for i=1:n
    numdi(i)=theta_k(n+i);
    dendi(i+1)=-theta_k(i);
end
sysi=tf(numdi,dendi,ts);
step(G,20)
hold on
step(sysi,20,'k')