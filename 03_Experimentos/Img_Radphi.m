function Img_Radphi(w,N,d,sref,Algoritmo,SNOI_values)
interf=SNOI_values(:,3)';
cant=1800;
rad=pi/180;
PHI=linspace(0,2*pi,cant);
k=2*pi;
Psix = (((1:N(1))-1).*(k*d(1)*sin(sref(2)*rad).*cos(PHI))')';
Psiy = (((1:N(2))-1).*(k*d(2)*sin(sref(2)*rad).*sin(PHI))')';
corte = strcat('\phi=',num2str(sref(2)));
for i=1:N(1)
    sumaPsi(N(1)*(i-1)+1:i*N(1),:)=Psix(i,:)+Psiy;
end
sumaPsi=exp(1i*sumaPsi); %64x1800 complex double;
%-----------------------------Corte en phizero-----------------------------
AF          = w'*sumaPsi;
% AFn         = cant*abs(AF)/sum(abs(AF));
AFn         = abs(AF)/max(abs(AF));
AFdBph	    = 10.*log10((AFn).^2);
[hp,thmax]  = hpbw(AFn,PHI);
%-----------------------------------PLOT-----------------------------------
figure(3)
hold on
if hp==Inf
    plot(PHI*180/pi, AFdBph, 'linewidth', 2,'DisplayName',corte);
    xline(interf, 'g--', 'linewidth', 2,'DisplayName','Inter')
    xline(sref(3), 'r--', 'linewidth', 2,'DisplayName','Deseada')
    title(['Diagrama de Radicion \theta_{0}=',num2str(sref(2)),' \phi_{0}=',num2str(sref(3)),' HPBW=Infty']);
    legend
    
else
    plot(PHI*180/pi, AFdBph, 'DisplayName',corte,'linewidth', 2);
    plot(PHI(thmax)*180/pi,AFdBph(thmax), 'r*', 'linewidth', 2,'DisplayName','HPBW');
    xline(interf, 'g--', 'linewidth', 2,'DisplayName','Inter')
    xline(sref(3), 'r--', 'linewidth', 2,'DisplayName','Deseada')
    title(['Diagrama de Radicion \theta_{0}=',num2str(sref(2)),' \phi_{0}=',num2str(sref(3)),' HPBW=',num2str(hp)]);
    legend
end
grid on
xlabel(['\phi',' (grados)'])
ylabel('Factor de Arreglo(dB)')
axis([0 360 min(AFdBph) max(AFdBph)]);
s = strcat(Algoritmo,'_03');
print(s,'-depsc')
hold off

SNOI_values(1,3)
SNOI_values(2,3)
oper1=find(PHI*180/pi>SNOI_values(1,3));
oper2=find(PHI*180/pi>SNOI_values(2,3));
oper3=find(PHI*180/pi>sref(3));
Index1=AFdBph(oper1(1));
Index2=AFdBph(oper2(1));
beam=AFdBph(oper3(1));
Nulo=[Index1 Index2];

tabla1                      = [Nulo(1),Nulo(2),beam];
DB                          = array2table(tabla1);
DB.Properties.VariableNames = {'1er Nulo $dB$','2do Nulo $dB$','Maximo $dB$'};
DB.Properties.RowNames      = {Algoritmo};
writetable(DB, strcat(Algoritmo, '_', 'Rad_phi', '.csv'), 'Delimiter', ',', 'WriteRowNames', true)



% tabla1                      = [tiempo,mi,stdi,SR];
% DB                          = array2table(tabla1);
% DB.Properties.VariableNames = {'Tiempo' '$\mu$' '$\pm \sigma$' 'SR'};
% DB.Properties.RowNames      = {'$fun_1$' '$fun_2$' '$fun_3$' '$fun_4$'};
% writetable(DB, strcat(tipo, '_', num2str(dimensi), 'Da', '.csv'), 'Delimiter', ',', 'WriteRowNames', true)




end