function imagenes(bp,w,lim,mi,stdi,SR,algoritmo,rxi)
[LB,UB,solteo,~,str] = infofund(w,2);
[f1,~] = fundAnonymous2D(w);
%-------------------------Figura 1-------------------------------------
figure(1)
fcontour(f1,[LB(1) UB(1) LB(2) UB(2)]);hold on
title(['Funcion ',str,', Algoritmo ',algoritmo]);
subtitle(['Contorno',', runs=',num2str(lim),', \mu_{iter}=',num2str(mi(w)),', \sigma = \pm',num2str(stdi(w)) ', SR =',num2str(SR(w)),'%']);
xlabel('x');
ylabel('y');
plot(bp(:,1),bp(:,2),'.r')
grid on
s1 = strcat(algoritmo,'_0',num2str(w),'_01');
print(s1,'-depsc')
hold off
%-------------------------Figura 2-------------------------------------
figure(2)
fsurf(f1,[LB(1) UB(1) LB(2) UB(2)],'ShowContours','on');hold on;
camlight
plot(bp(:,1),bp(:,2),'.r')
colorbar;
subtitle(['Runs=',num2str(lim),', \mu_{iter}=',num2str(mi(w)),', \sigma = \pm',num2str(stdi(w)), ', SR =',num2str(SR(w)),'%']);
title(['Funcion ',str,', Algoritmo ',algoritmo]);
s2 = strcat(algoritmo,'_0',num2str(w),'_02');
print(s2,'-depsc')
hold off
%-------------------------Figura 3-------------------------------------
if lim==1
    figure(3)
    fcontour(f1,[LB(1) UB(1) LB(2) UB(2)])
    hold on
    plot(rxi(:,1),rxi(:,2),'ko-')
    plot(solteo(1),solteo(2),'b^')
    title(['Funcion ',str,', Algoritmo ',algoritmo]);
    subtitle(['Contorno+Trayectoria',', runs=',num2str(lim),', \mu_{iter}=',num2str(mi(w)),', \sigma = \pm',num2str(stdi(w)) ', SR =',num2str(SR(w)),'%']);
    xlabel('x');
    ylabel('y');
    s3 = strcat(algoritmo,'_0',num2str(w),'_03');
    print(s3,'-depsc')
    hold off
end
end