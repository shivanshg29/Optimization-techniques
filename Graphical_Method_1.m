% Q1
%   Maximize 3x1+5x2
%   x1+2x2<=2000
%   x1+x2<=1500
%   x2<=600  x1,x2>=0

% Phase-1 (Input Params)
c=[3 5];
A=[1 2;1 1;0 1];
B=[2000;1500;600];

% Phase-2 (Plot the graph)
x1=0:1:max(B);
x21=(B(1)-A(1,1)*x1)./A(1,2);
x22=(B(2)-A(2,1)*x1)./A(2,2);
x23=(B(3)-A(3,1)*x1)./A(3,2);

    % Ensure x2 >= 0
x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);

plot(x1,x21,'r',x1,x22,'b',x1,x23,'k')
xlabel('x1');
ylabel('x2');

% Phase-3 (Find corner Points with axis)
cx1=find(x1==0);
c1=find(x21==0);
c2=find(x22==0);
c3=find(x23==0);

line1=[x1(:,[c1,cx1]) ; x21(:,[c1,cx1])]';
line2=[x1(:,[c2,cx1]) ; x22(:,[c2,cx1])]';
line3=[x1(:,[c3,cx1]) ; x23(:,[c3,cx1])]';

corner_pts=unique([line1;line2;line3],'rows');

% Phase-4 (Find the point of Intersection)
pts=[0;0];
for i=1:size(A,1)
    for j=i+1:size(A,1)
        A1=[A(i,:);A(j,:)];
        B1=[B(i,:);B(j,:)];
        X=A1\B1;
        pts=[pts X];
    end
end
pts=pts';

% Phase-5 (Find all points)
all_points=[pts;corner_pts];
points=unique(all_points,'rows');

% Phase-6 (Discard Points that are out of constraints)
p1=points(:,1);
p2=points(:,2);
cons1=p1+2*p2-B(1);
cons2=p1+p2-B(2);
cons3=p2-B(3);

valid_points=find(cons1 <= 0 & cons2 <= 0 & cons3 <= 0);
valid_points_coords = points(valid_points, :);

% Phase -7 (Obj Values & Points)
values=valid_points_coords *c';
table = [valid_points_coords, value]

% Phase 8 - Objective Value
optimal_value = max(table)
