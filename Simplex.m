% Max Z=-x1+3x2-2x3
% 3x1-x2+2x3<=7
% -2x1+4x2<=12
% -4x1+3x2+8x4<=10
% no_of_variables
clc
c=[-1 3 -2];
info=[3 -1 2 ; -2 4 0 ; -4 3 8];
b=[7;12;10];
% c=[4 3];
% info=[1 1 ; 2 1];
% b=[8;10];

s=eye(size(info,1));
A=[info s b];

cost=zeros(1,size(A,2));
cost(1:size(c,2))=c;

bv=size(c,2)+1:size(A,2)-1;

zjcj=cost(bv)*A-cost;
zcj=[zjcj;A];

RUN=true;
while RUN
    if any(zjcj(1,1:end-1)<0)
        fprintf("Solution is Not Optimal")
    else
        fprintf("Solution is Optimal")
        RUN=false;
    end
    % Find entering Variable
    zc=zjcj(1,1:end-1);
    [enter_col_val,pvt_col]=min(zc);

    % Find Leaving Variable
    sol=A(:,end);
    column=A(:,pvt_col);

    % Finding Ratio
    for i=1:size(column,1)
        if column(i)>0
            ratio(i)=sol(i)/column(i);
        else
            ratio=inf;
        end
    end

    % Finding Pivot Element
    [pvt_value,pvt_row]=min(ratio);
    bv(pvt_row)=pvt_col;
    
    % Update table value
    pvt_key=A(pvt_row,pvt_col);
    
    A(pvt_row,:)=A(pvt_row,:)./pvt_key;
    for i=1:size(A,1)
        if i~=pvt_row
            A(i,:)=A(i,:)-A(i,pvt_col).*A(pvt_row,:);
        end
        zjcj=zjcj-zjcj(pvt_col).*A(pvt_row,:);
    end
    
    zcj=[zjcj;A]

    BFS=zeros(1,size(A,2));
    BFS(bv)=A(:,end);
    BFS(end)=sum(BFS.*cost)
end

