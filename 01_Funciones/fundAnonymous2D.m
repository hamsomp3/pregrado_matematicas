function [y,gr,he] = fundAnonymous2D(w)
%--------------------------------------------------------------------------
% INFORMACION fundAnonymous2D(w)
% Realiza un switch-case de todas las funciones
%----------------------------------INPUT-----------------------------------
% w         Tipo de funcion         (Valor)
%----------------------------------OUTPUT----------------------------------
% y         Valor de la Funcion     (Vector)
%-----------------------------Tipos de Funciones---------------------------
% - Brown
% - Pathological
% - Streched V Sine Wave
% - Wavy:
%--------------------------------------------------------------------------
syms x1 x2
switch w
    case 1
        y           = @(x1,x2) (x1.^2).^((x2.^2)+1)+(x2.^2).^((x1.^2)+1);
        f(x1,x2)    = (x1^2)^((x2^2)+1)+(x2^2)^((x1^2)+1);
    case 2
        y           = @(x1,x2) 0.5 + ((sin(sqrt(100*x1.^2+x2.^2)).^2)-0.5)./(1+0.001*(x1.^2-2*x1.*x2+x2.^2).^2);
        f(x1,x2)    = 05 + ((sin(sqrt(100*x1^2+x2^2))^2)-05)/(1+0001*(x1^2-2*x1*x2+x2^2)^2);
    case 3
        y           = @(x1,x2) power((x2.^2 + x1.^2),0.25).*((sin(50*(x2.^2 + x1.^2).^0.1).^2)+0.1);
        f(x1,x2)    = power((x2^2 + x1^2),025)*((sin(50*(x2^2 + x1^2)^01)^2)+01);
    case 4
        y           = @(x1,x2) 1-(1/2)*(cos(10*x1).*exp(-(x1.^2)/2)+cos(10*x2).*exp(-(x2.^2)/2));
        f(x1,x2)    = 1-(1/2)*(cos(10*x1)*exp(-(x1^2)/2)+cos(10*x2)*exp(-(x2^2)/2));
    case 5
        y           = @(x1,x2) x1.^2 + x1.*x2 + 3*x2.^2;
        f(x1,x2)    = x1^2 + x1*x2 + 3*x2^2;
    case 6
        y           = @(x1,x2) 5*(x1.^4)+4*(x1.^2).*x2-x1.*(x2.^3)+4*(x2.^4)-x1;
        f(x1,x2)    = 5*(x1^4)+4*(x1^2)*x2-x1*(x2^3)+4*(x2^4)-x1;
    otherwise
        disp('No es un numero valido')
end % End del Switch
% symbolicgradient=gradient(y,[x1,x2]);
% gr=matlabFunction(symbolicgradient);
% symbolichessian=hessian(y,[x1,x2]);
% he=matlabFunction(symbolichessian);


symbolicgradient=gradient(f,[x1,x2]);
gr=matlabFunction(symbolicgradient);
symbolichessian=hessian(f,[x1,x2]);
he=matlabFunction(symbolichessian);

end