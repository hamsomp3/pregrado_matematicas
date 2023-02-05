function [y] = fund(w,xx,p)
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
switch w
    case 1
        sum1    = 0;
        for i=1:p-1
            sum1 = sum1 + (xx(:,i).^2).^((xx(:,i+1).^2)+1)+(xx(:,i+1).^2).^((xx(:,i).^2)+1);
        end
        y	= sum1;
    case 2
        sum1    = 0;
        for i=1:p-1
            sum1 = sum1 + 0.5 +((sin(sqrt(100*(xx(:,i).^2)+(xx(:,i+1).^2))).^2)-0.5)./(1+0.001*((xx(:,i).^2)-2*xx(:,i).*xx(:,i+1)+(xx(:,i+1).^2)).^2);
        end
        y   = sum1;
    case 3
        sum1=0;
        for i=1:p-1
            sum1=sum1+power((xx(:,i+1).^2 + xx(:,i).^2),0.25).*((sin(50*(xx(:,i+1).^2 + xx(:,i).^2).^0.1).^2)+0.1);
        end
        y	= sum1;
    case 4
        sum1=0;
        for i=1:p
            sum1=sum1+1-(1/p)*cos(10*xx(:,i)).*exp(-((xx(:,i)).^2)/2);
        end
        y	= sum1;
        
    otherwise
        disp('No es un numero valido')
end
end