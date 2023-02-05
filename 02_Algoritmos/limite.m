function [x]=limite(x,p,LB,UB)
for j=1:p
    LI = x(:,j) < LB(j);    % Lower Index
    x(LI,j)=LB(j);
    UI = x(:,j) > UB(j); 	% Upper Index
    x(UI,j)=UB(j);
end
end
