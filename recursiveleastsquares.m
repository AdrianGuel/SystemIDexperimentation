%Recursive least squares
%Adrian-Josue Guel-Cortez 2020
%If you use my codes do not forget to cite me
%https://scholar.google.com.mx/citations?user=gZcBLuoAAAAJ&hl=es
function [theta_k,P_k,f_k]=recursiveleastsquares(u_k,y_k,P,theta,f_k,a,gamma,n)
    L_k=(1/gamma)*P*f_k./((1/a)+(1/gamma)*f_k'*P*f_k);
    theta_k=theta+L_k*(y_k-f_k'*theta);
    P_k=(1/gamma)*(eye(length(P))-L_k*f_k'*P);
    Ya = circshift(f_k(1:n),1);
    Yb = circshift(f_k(n+1:end),1);
    f_k=[Ya; Yb];
    f_k(1)=y_k;
    f_k(n+1)=u_k;
end
