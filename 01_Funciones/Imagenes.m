function Imagenes(str,LB,UB,f1)
% function Imagenes(X,Y,Z,bp,w,n,lim,mi,stdi,mse,SR,algoritmo)
%-------------------------Figura 1-------------------------------------
figure(1)
fcontour(f1,[LB(1) UB(1) LB(2) UB(2)]);
grid on
hold on
colorbar
title(['Funcion: ',str,', contorno']);
xlabel('x');
ylabel('y');
name1=strcat('01_',str,'contorno');
print(name1,'-depsc')
hold off
%-------------------------Figura 2-------------------------------------
figure(2)
fsurf(f1,[LB(1) UB(1) LB(2) UB(2)]);
grid on
hold on
colorbar
title(['Funcion: ',str,', Superficie']);
xlabel('x');
ylabel('y');
name1=strcat('02_',str,'Superficie');
print(name1,'-depsc')
hold off
%-------------------------Figura 3-------------------------------------
figure(3)
x1=min(LB):0.0001:max(UB);
x2=x1;
y=f1(x1,x2);
plot(x1,y, 'LineWidth', 2);
hold on
title(['Funcion: ',str,', corte y=x']);
grid on
axis([min(LB) max(UB) min(y) max(y)])
xlabel('x');
ylabel('y');
name1=strcat('03_',str,'corte2D');
print(name1,'-depsc')
hold off
%-------------------------Figura 4-------------------------------------
figure(4)
xt = @(t)t;
yt = @(t)t;
zt= @(t) f1(t,t);
fplot3(xt,yt,zt,[min(LB) max(UB)],'MeshDensity',30,'LineWidth',1);
hold on
title(['Funcion: ',str,', corte y=x 3D']);
grid on
view(-38,30)
name1=strcat('04_',str,'corte3D');
print(name1,'-depsc')
hold off
end %End Function