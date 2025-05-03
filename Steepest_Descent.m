% Steepest Descent Method for Unconstrained
% It is a first order iterative optimization used to minimum
syms x1 x2
% Define objective function
f1=x1-x2+2*x1^2+2*x1*x2+x2^2;
fx=inline(f1);
fobj=@(x1) fx(x(:,1),x(:,2));
% Gradient of f
grad=gradient(f1);
G=inline(grad);
gradx=@(x)G(x(:,1),x(:,2));
% Hessian Matrix
H1=hessian(f1);
Hx=inline(H1);
x0=[1 1];
maxiter=4;
tot=1e-3;
iter=0;
x=[];
while norm((gradx(x0)))>tot && iter<maxiter
    x=[x;x0];
    s=-grad(x0);
    H=Hx(x0);
    lam=s'*s./(s'*H*s);
    xnew=x0+lam.*s';
    x0=xnew;
    iter=iter+1;
end
fprintf('Optimal Solution x=[%f,%f]',x0(1),x0(2))

% clc 
% clear all
% syms x1 x2
% f1 = x1-x2+2*x1^2+2*x1*x2+x2^2;
% fx = inline(f1);
% fobj = @(x) fx(x(:, 1), x(:, 2));
% 
% grad = gradient(f1);
% G = inline(grad);
% gradx = @(x) G(x(:, 1), x(:, 2));
% 
% h = hessian(f1);
% hx = inline(h);
% 
% x0 = [1 1];
% maxiter = 4;
% tol = 1e-3; 
% iter = 0;
% X = [];
% 
% while norm(double(gradx(x0)))>tol&&iter<maxiter
%     X = [X; x0];
%     S = -double(gradx(x0));
%     hval = double(hx(x0));
%     lam = (S' * S)/(S' *hval*S);
%     x0 = x0+lam*S';
%     iter = iter+1;
% end
% 
% fprintf("optimal solution x = [%f %f] \n", x0(1), x0(2));
% fprintf("optimal value f(x) = %f \n", fobj(x0));