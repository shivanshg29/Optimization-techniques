%Q2
%   Maximize 3x1+5x2
%   x1+2x2<=4
%   3x1+5x2<=15
%   x1,x2>=0
clc;clear;
% Phase-1 (Input Params)
c=[3 5];
A=[1 2;3 5];
B=[4;15];

% Phase-2 (Plotting Graph)
x1=0:1:max(B);
x21=(B(1)-A(1,1)*x1)/A(1,2);
x22=(B(2)-A(2,1)*x1)/A(2,2);
x21=max(0,x21);
x22=max(0,x22);
plot(x1,x21,'r',x1,x22,'b');
xlabel('x1');
ylabel('x2');

% Phase-3 (Find all Corner Points)
cx1=find(x1==0,1);
c1=find(x21==0,1);
c2=find(x22==0,1);
line1=[x1(:,[c1,cx1]);x21(:,[c2,cx1])]';
line2=[x1(:,[c2,cx1]);x22(:,[c2,cx1])]';
corner_pts=unique([line1;line2],"rows");

% Phase-4 (Find Intersection Points)
pts=[];
for i=1:size(A,1)
    for j=1:size(A,1)
        A1=[A(i,:),A(j,:)];
        B1=[B(i,:),B(j,:)];
        x=A\B;
        pts=[pts x];
    end
end
pts=pts';

% Phase-5 (Find all points)
all_points=[pts ; corner_pts];
points = unique(all_points,'rows');

% Phase-6 (Discard Points that are out of constraints)
for i=1:size(points)
    cons1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2)-B(1);
    cons2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2)-B(2);
end
s1=find(cons1>0);
s2=find(cons2>0);
s=unique([s1 ;s2]);
points(s,:)=[];

% Phase-7 (Obj Values & Points)
values=points*c';
table=[points,values]

% Phase-8 (Max Value)
max(values)
