function [y] = fund2D(w,xx,p)
%--------------------------------------------------------------------------
% INFORMACION fund(w,xx,p)
% Realiza un switch-case de todas las funciones
%----------------------------------INPUT-----------------------------------
% w         Tipo de funcion         (Valor)
% xx        Matriz de Posiciones    (Matriz)
% p         Dimensiones             (Valor)
%----------------------------------OUTPUT----------------------------------
% y         Valor de la Funcion     (Vector)
%-----------------------------Tipos de Funciones---------------------------
% - Brown
% - Pathological
% - Streched V Sine Wave
% - Wavy:
%--------------------------------------------------------------------------
L=size(xx,2)/2;
paso=1;
x1=xx(:,paso:L*1);	% Primera Coordenada
x2=xx(:,paso+L:L*2);% Segunda Coordenada
switch w
    case 1
        y = (x1.^2).^((x2.^2)+1)+(x2.^2).^((x1.^2)+1);
    case 2
        y = 0.5 + ((sin(sqrt(100*x1.^2+x2.^2)).^2)-0.5)./(1+0.001*(x1.^2-2*x1.*x2+x2.^2).^2);
    case 3
        y = power((x2.^2 + x1.^2),0.25).*((sin(50*(x2.^2 + x1.^2).^0.1).^2)+0.1);
    case 4
        y = 1-(1/p)*(cos(10*x1).*exp(-(x1.^2)/2)+cos(10*x2).*exp(-(x2.^2)/2));
    otherwise
        disp('No es un numero valido')
end
end