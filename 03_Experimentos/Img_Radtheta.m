function Img_Radtheta(w,N,d,sref,Algoritmo,SNOI_values)
interf=SNOI_values(:,2)';
cant=1800;
rad=pi/180;
THETA=linspace(0,pi,cant);
k=2*pi;
Psix = (((1:N(1))-1).*(k*d(1)*sin(THETA).*cos(sref(3)*rad))')';
Psiy = (((1:N(2))-1).*(k*d(2)*sin(THETA).*sin(sref(3)*rad))')';
corte = strcat('\theta=',num2str(sref(3)));
for i=1:N(1)
    sumaPsi(N(1)*(i-1)+1:i*N(1),:)=Psix(i,:)+Psiy;
end
sumaPsi=exp(1i*sumaPsi); %64x1800 complex double;
%-----------------------------Corte en phizero-----------------------------
AF          = w'*sumaPsi; %Forma nueva
% AFn         = cant*abs(AF)/sum(abs(AF)); %Normalizado respecto a la Isotropica
AFn         = abs(AF)/max(abs(AF));
AFdBtheta	= 10.*log10((AFn).^2);
[hp,thmax]  = hpbw(AFn,THETA);
%-----------------------------------PLOT-----------------------------------
figure(4)
hold on
if hp==Inf
    plot(THETA*180/pi, AFdBtheta, 'linewidth', 2,'DisplayName',corte);
    xline(interf, 'g--', 'linewidth', 2,'DisplayName','Inter')
    xline(sref(2), 'r--', 'linewidth', 2,'DisplayName','Deseada')
    title(['Diagrama de Radicion \theta_{0}=',num2str(sref(2)),' \phi_{0}=',num2str(sref(3)),' HPBW=Infty']);
    legend
else
    plot(THETA*180/pi, AFdBtheta,'DisplayName',corte, 'linewidth', 2);
    plot(THETA(thmax)*180/pi,AFdBtheta(thmax), 'r*', 'linewidth', 2,'DisplayName','HPBW');
    xline(interf, 'g--', 'linewidth', 2,'DisplayName','Inter')
    xline(sref(2), 'r--', 'linewidth', 2,'DisplayName','Deseada')
    title(['Diagrama de Radicion \theta_{0}=',num2str(sref(2)),' \phi_{0}=',num2str(sref(3)),' HPBW=',num2str(hp)]);
%     legend('\phi=0','HPBW','Inter','Deseada')
    legend
end
grid on
xlabel(['\theta',' (grados)'])
ylabel('Factor de Arreglo(dB)')
axis([0 180 min(AFdBtheta) max(AFdBtheta)]);
s = strcat(Algoritmo,'_04');
print(s,'-depsc')
hold off
end