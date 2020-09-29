%Least squares offline
function [theta_0,P,f_0]=LeastSquaresOffline(u,y,n,a,gamma)
N=length(u)-1;
W=zeros(N-n+1,N-n+1);
%Y=zeros(N-n+1,1);
F=zeros(N-n+1,2*n);
    for i=1:N-n+1
       for j=1:N-n+1
            if i==j
                 W(i,j)=a*gamma^(N-i);
            end
       end
    end
    
Y=y(n+1:end);
for k=1:N-n+1
    for i=n:-1:1
        F(k,i)=y(k+n-i);
        F(k,i+n)=u(k+n-i);
    end
end
P=inv(F'*W*F);
f_0=F(end,:);
theta_0=P*F'*W*Y;
end