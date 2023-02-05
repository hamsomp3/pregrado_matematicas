function Img_Radthetapol(w,N,d,sref,Algoritmo)
cant=1800;
k=2*pi;scale=-10;
THETA=linspace(0,2*pi,cant);
Psix = (((1:N(1))-1).*(k*d(1)*sin(THETA).*cos(0))')';
Psiy = (((1:N(2))-1).*(k*d(2)*sin(THETA).*sin(0))')';
for i=1:N(1)
    sumaPsi(N(1)*(i-1)+1:i*N(1),:)=Psix(i,:)+Psiy;
end
sumaPsi=exp(1i*sumaPsi); %64x1800 complex double;
%-----------------------------Corte en phi=0------------------------------
AF          = w'*sumaPsi; %Forma nueva
AFn         = cant*abs(AF)/sum(abs(AF)); %Normalizado respecto a la Isotropica
AFdBtheta	= 10.*log10((AFn).^2);
dB1         = polardB(AFdBtheta,scale);
%-----------------------------------PLOT-----------------------------------
figure(9)
polarplot(THETA,dB1,'linewidth',2)
title('Normalizado respecto al maximo')
ax = gca;
ax.ThetaZeroLocation = 'right';
ax.ThetaDir = 'counterclockwise';
s = strcat(Algoritmo,'_09');
print(s,'-depsc')
hold off
end