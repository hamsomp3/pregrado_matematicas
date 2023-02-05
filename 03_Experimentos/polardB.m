function [dB] = polardB(dB,scale)
r=max(scale,min(dB));
for i=1:length(dB)
    if dB(i)<r
        dB(i)=r;
    end
end
dB=dB-r;
end

