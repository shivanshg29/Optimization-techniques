% Min z=2x1+x3
% x1+x2-x3>=5
% x1-2x2+4x3>=8
% xi>=0 for i=1,2,3
clc
variables={'x_1','x_2','x_3','s_1','s_2','sol'};
cost=[-2 0 -1 0 0 0];
info=[-1 -1 1;-1 2 -4];
b=[-5;-8];
s=eye(size(info,1));
A=[info s b];

% Find starting BFS
Bv=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            Bv=[Bv i];
        end
    end
end
fprintf('Basic Variables (BV)=')
disp(variables(Bv))

zjcj=cost(Bv)*A-cost;

% Print Table
zcj=[zjcj;A];
SimpTable=array2table(zcj)
SimpTable.Properties.VariableNames(1:size(zcj,2))=variables;

% Dual Simplex
Run=true;
while Run
    sol=A(:,end);
    if any (sol<0)
        fprintf('The current BFS is not Feasible\n')
    
    
        % Find the leaving variable
        [leaving_val,put_row]=min(sol);
        fprintf('Leaving row=%d\n',put_row)
        
        % Find the entering Variable
        row=A(put_row,1:end-1);
        zj=zjcj(:,1:end-1);
        for i=1:size(row,2)
            if row(i)<0
                ratio(i)=abs(zj(i)./row(i));
            else
                ratio(i)=inf;
            end
        end
        [min_value,put_col]=min(ratio);
        fprintf('Entering Variable=%d\n',put_col)
        
        % Update the basic variable
        Bv(put_row)=put_col;
        fprintf("Basic Variables(Bv)=")
        disp(Bv)
        
        % Pivot Key
        put_key=A(put_row,put_col)
        
        % Update the table for next iteration
        A(put_row,:)=A(put_row,:)./put_key
        
        for i =1:size(A,1)
            if i~=put_row
                A(i,:)=A(i,:)-A(i,put_col)*A(put_row,:)
            end
        end
        zjcj=cost(Bv)*A-cost
        
        % print table
        zcj=[zjcj;A];
        simptable=array2table(zcj)
        SimpTable.Properties.VariableNames(1:size(zcj,2))=variables;
        
    else
        Run = false;
        fprintf('Current BFS is feasible and optimal.\n');
        fprintf('Optimal Value of Z = %.2f\n', cost(Bv) * A(:,end));
    end
end  




