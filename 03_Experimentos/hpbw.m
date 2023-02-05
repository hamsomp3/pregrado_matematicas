function[hp,thmax]=hpbw(AF, X)
if max(AF)<0.5
    hp=Inf;
    thmax=ones(1,2);
else
    epsilon=1e-7;
    Y=(abs(AF)./max(abs(AF))).^2-0.5;
    yrange=max(Y)-min(Y);
    epsilon2=yrange*epsilon;
    n=length(AF);
    m=0;
    X(n+1)=X(n);
    Y(n+1)=Y(n);
    R=ones(1,2);
    thmax=ones(1,2);
    for k=2:n
        if Y(k-1)*Y(k)<=0
            m=m+1;
            R(m)=(X(k-1)+X(k))/2;
            thmax(m)=k;
        end
        s=(Y(k)-Y(k-1))*(Y(k+1)-Y(k));
        if (abs(Y(k))<epsilon2) && (s<=0)
            m=m+1;
            R(m)=X(k);
            thmax(m)=k;
        end
    end
    c=1;
    f=length(R);
    dist=zeros(1,f*f);
    
    for i=1:f
        for j=1:f
            dist(c)=abs(R(i)-R(j));
            c=c+1;
        end
    end
    dist(dist==0)=[];
    hp=min(dist)*180/pi;
end

end