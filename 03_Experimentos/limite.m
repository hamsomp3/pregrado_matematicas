function [x]=limite(x,p,LB,UB)
for j=1:p
    LI = x(:,j) < LB;    % Lower Index
    x(LI,j)=LB;
    UI = x(:,j) > UB; 	% Upper Index
    x(UI,j)=UB;
end
end
