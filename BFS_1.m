% Max. z = x1 + 2x2, subject to 
% − x1 + x2 ≤ 1,
% x1 + x2 ≤ 2,
% x1, x2 ≥ 0.

% Phase-1 (Input Parameters)
c=[1 2];
A=[-1 1;1 1];
B=[1;2];

% Phase-2 (NCM)
m=size(A,1);
n=size(A,2);
nv=nchoosek(n,m);
t=nchoosek(1:n,m);

% Phase-3 (Basic Sol)
sol=[];
for i=1:nv
    y=zeros(n,1);
    x=A(:,t(i,:))\B;
    if all(x>=0 & x~=-inf & x~=inf)
        y(t(i,:))=x;
        sol=[sol y]
    end
end

% Phasr-4 (Obj Value)
z=c*sol;
[zmax,zind]=max(z)
BFS=sol(:,zind);

optval=[BFS',zmax];
array2table(optval,'variablenames',{'x1','x2','z'})