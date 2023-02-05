function [t,s,bestpos,bestfun,errores_cell,recordxi]=PSO(w,s,p)
%-------------------------------------------------------------------------
% INFORMACION Algoritmo PSO
% Algoritmo implementado por Jan Polanco Velasco 2022 v1.0
%----------------------------------INPUT-----------------------------------
% n         Cantidad de Particulas  (Valor)
% w         Numero de funcion       (Valor)
% s         Contador Suma           (Valor)
%----------------------------------OUTPUT----------------------------------
% t         Total iteraciones       (Valor)
% s         Contador Suma           (numero)
% bestpos   Mejor posicion          (Vector)
% bestfun   Mejor Fitness           (Valor)
% mse       Error medio cuadratico  (Valor)
%--------------------------------------------------------------------------
secuence=0;
[LB,UB,~,gteo,str] = infofund(w,p);
if p==2
    [f1,~] = fundAnonymous2D(w);
    fun     = @(x) f1(x(:,1),x(:,2));
else
    [f1,~] = fundAnonymous10D(w);
    fun     = @(x) f1(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7),x(:,8),x(:,9),x(:,10));
end
exito   = 0;
n       = 40;           % Cantidad de particulas
alpha	= 0.3;          % Constante de Aceleracion
beta    = 0.5;          % Constante de Aceleracion
theta   = 0.95;         % Inercia
tol     = 1e-6;         % Accuracy o precision para error
max_iter= 1000;         % Maximum number of iterations
xmin    = min(LB);	    % Posicion Minima
xmax    = max(UB);	    % Posicion Maxima
vi      = zeros(n,p);   % Velocidad inicial
xi      = (rand(n,p))*(xmax-xmin)+xmin;    % Posicion Inicial
[bestfun,bestpos] = ObjetiveFunction(fun,xi);
posmin=bestpos;
t=1;
mse(t)  = Inf;
mse(t)  = Inf;
rmse(t) = Inf;
mae(t)  = Inf;
mspe(t) = Inf;
mape(t) = Inf;
rmsle(t)= Inf;
recordxi=[xi];
try
    % https://www.mathworks.com/help/matlab/ref/try.html
    a=(mae(t-1)==mae(t));
catch
    a=false;
end

while mae(t)>=tol && (~(a==true) && t<=max_iter)
    if secuence==1
        image_sequence(x,y,z,str,'PSO ',t,xi)
    end
    vi=theta*vi+alpha*rand(n,1).*(bestpos-xi)+beta*rand(n,1).*(posmin-xi);
    xi=xi+vi;
    xi=limite(xi,p,LB,UB);

    [zmin,posmin,y] = ObjetiveFunction(fun,xi);
    if zmin<=bestfun
        bestfun=zmin;
        bestpos=posmin;
    end
    t=t+1;
    [MSE, RMSE, MAE, MSPE, MAPE, RMSLE]=errores(y,gteo);
    mse(t)  = MSE;
    rmse(t) = RMSE;
    mae(t)  = MAE;
    mspe(t) = MSPE;
    mape(t) = MAPE;
    rmsle(t)= RMSLE;
    recordxi=[recordxi;bestpos];
%     pedro=[mae(t)<tol, mean(y)-bestfun<tol] % pendiente para borrar
    if mse(t)<tol && mean(y)-bestfun<tol
        s=s+1;
        exito=1;
        break
    end
%     disp('hola')
end

if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end %end function