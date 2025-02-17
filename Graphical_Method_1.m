% Q1
%   Maximize 3x1+5x2
%   x1+2x2<=2000
%   x1+x2<=1500
%   x2<=600  x1,x2>=0
clc;
clear;
% Phase-1 (Input Params)
c = [3 5]; % Objective function coefficients
A = [1 2; 1 1; 0 1]; % Coefficients of the constraints
B = [2000; 1500; 600]; % Right-hand side of the constraints

% Phase-2 (Plot the graph)
x1 = 0:1:max(B); % Range of x1
x21 = (B(1) - A(1,1) * x1) ./ A(1,2); % Solve for x2 from the first constraint
x22 = (B(2) - A(2,1) * x1) ./ A(2,2); % Solve for x2 from the second constraint
x23 = (B(3) - A(3,1) * x1) ./ A(3,2); % Solve for x2 from the third constraint

% Ensure x2 >= 0
x21 = max(0, x21);
x22 = max(0, x22);
x23 = max(0, x23);

% Plot the constraint lines
plot(x1, x21, 'r', x1, x22, 'b', x1, x23, 'k');
xlabel('x1');
ylabel('x2');
grid on;

% Phase-3 (Find corner Points with axis)
cx1 = find(x1 == 0);
c1 = find(x21 == 0);
c2 = find(x22 == 0);
c3 = find(x23 == 0);

% Get the corner points from the plot lines
line1 = [x1(:, [c1, cx1]); x21(:, [c1, cx1])]';
line2 = [x1(:, [c2, cx1]); x22(:, [c2, cx1])]';
line3 = [x1(:, [c3, cx1]); x23(:, [c3, cx1])]';

corner_pts = unique([line1; line2; line3], 'rows');

% Phase-4 (Find the point of Intersection)
pts = [0; 0];
for i = 1:size(A,1)
    for j = i+1:size(A,1)
        A1 = [A(i,:); A(j,:)];
        B1 = [B(i,:); B(j,:)];
        X = A1 \ B1; % Solve the system of equations
        pts = [pts X]; % Add the intersection points
    end
end
pts = pts';

% Phase-5 (Find all points)
all_points = [pts; corner_pts];
points = unique(all_points, 'rows');

% Phase-6 (Discard Points that are out of constraints)
for i = 1:size(points, 1)
    const1(i) = A(1,1) * points(i,1) + A(1,2) * points(i,2) - B(1);
    const2(i) = A(2,1) * points(i,1) + A(2,2) * points(i,2) - B(2);
    const3(i) = A(3,1) * points(i,1) + A(3,2) * points(i,2) - B(3);
end

% Find which points are feasible
s1 = find(const1 > 0);
s2 = find(const2 > 0);
s3 = find(const3 > 0);
s = unique([s1 s2 s3]);

% Remove infeasible points
points(s, :) = [];

% Phase-7 (Obj Values & Points)
values = points * c'; % Calculate the objective function values
table = [points, values]; % Combine the points and their corresponding values

% Phase 8 - Objective Value
optimal_value = max(table(:, end)); % Get the highest objective value
disp('Optimal Points and Objective Values:');
disp(table);
disp('Optimal Objective Value:');
disp(optimal_value);
