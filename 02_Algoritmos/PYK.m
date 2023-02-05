function [p_order,M_order] = PYK(error)
p=zeros(length(error),1);
M=zeros(length(error),1);
for i=1:length(error)
    if i==1 || i==length(error) || error(i)==error(i-1)
        p(i)=nan;
        M(i)=nan;
    else
        p(i)=(log(error(i+1)/error(i)))/(log(error(i)/error(i-1)));
        M(i)=error(i+1)/error(i)^p(i);
    end
end

for i=1:length(error)
    if p(i)==0
        p(i)=nan;
    end
end


p_order=mean(p,'omitnan');
M_order=mean(M,'omitnan');

end