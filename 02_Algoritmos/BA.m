function [t,s,bestpos,bestfun,errores_cell,recordxi]=BA(w,s,p)
secuence= 0;
[LB,UB,~,gteo,str] = infofund(w,p);
if p==2
    [f1,~] = fundAnonymous2D(w);
    fun     = @(x) f1(x(:,1),x(:,2));
else
    [f1,~] = fundAnonymous10D(w);
    fun     = @(x) f1(x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7),x(:,8),x(:,9),x(:,10));
end
exito   = 0;
n       = 40;               % Cantidad de particulas
alpha   = 0.90;             % Parametro alpha
gamma   = 0.90;             % Parametro gamma
alpha1	= 0.1;              % Constante de Aceleracion
theta   = 0.95;             % Inercia
Amin    = 1;                % Volumen minimo
Amax    = 2;                % Volumen maximo
fmin    = 0;                % Frecuencia minima
fmax    = 2;                % Frecuncia maxima
vi      = zeros(n,p);       % Velocidad Inicial
xmin    = min(LB);          % Posicion Minima
xmax    = max(UB);          % Posicion Maxima
t       = 1;                % Tiempo inicial
tol     = 1e-6;             % Accuracy o precision para error
max_iter= 1000;         % Maximum number of iterations
%---------------------Poblacion inicial---------------------
A       = (Amax-Amin).*rand(n,1)+Amin;	% Volumen inicial(Loudness)
r0      = 0.1.*rand(n,1);               % Tasa de emision de pulsos inicial cercana a cero
r       = r0*(1-exp(-gamma*t));         % Aumenta cota r_0;
xi1     = (xmax-xmin).*(rand(n,p))+xmin;% Posicion Anterior
[bestfun,bestpos] = ObjetiveFunction(fun,xi1);

mse(t)  = Inf;
mse(t)  = Inf;
rmse(t) = Inf;
mae(t)  = Inf;
mspe(t) = Inf;
mape(t) = Inf;
rmsle(t)= Inf;
recordxi=[xi1];
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
    fi=fmin+(fmax-fmin).*rand(n,1);
    vi=theta*vi+alpha1*rand(n,1).*(bestpos-xi1).*fi;
    xi2=xi1+vi;
    xi2=limite(xi2,p,LB,UB);
    
    aleator1=rand(n,p)*2-1;
    I1=rand(n,1) < r;
    xi1(I1,:)=bestpos+0.01*aleator1(I1,:)*mean(A);
    xi1=limite(xi1,p,LB,UB);
    [~,~,fit1] = ObjetiveFunction(fun,xi1); % no es necesario
    
    I2=rand(n,1) > A;
    I3=fit1 < bestfun;
    I4=and(I2,I3);
    
    r(I4)    = r0(I4)*(1-exp(-gamma*t));	% Aumenta cota r_0
    A(I4)    = alpha*A(I4);                 % Disminuye
    
    [~,~,~,xi2] = ObjetiveFunction(fun,xi2);
    [~,~,~,xi1] = ObjetiveFunction(fun,xi1);
    xi1(floor(n/2)+1:end,:)=xi2(1:floor(n/2),:);
    [bestfun,bestpos,y,xi1] = ObjetiveFunction(fun,xi1);
    t       = t+1;                  % Numero de evaluaciones
    [MSE, RMSE, MAE, MSPE, MAPE, RMSLE]=errores(y,gteo);
    mse(t)  = MSE;
    rmse(t) = RMSE;
    mae(t)  = MAE;
    mspe(t) = MSPE;
    mape(t) = MAPE;
    rmsle(t)= RMSLE;
    recordxi=[recordxi;bestpos];
    if mae(t)<tol && mean(y)-bestfun<tol
        s=s+1;
        exito=1;
        break
    end
end %End del while
if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end