function [t,s,bestpos,bestfun,errores_cell,recordxi]=CKLF(w,s,p)
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
n       = 40;                           % Cantidad de particulas
max_iter= 1000;                         % Maximum number of iterations
pa      = 0.25;                         % Probabilidad de rechazo de nidos
alpha	= 0.45;                         % Factor de escalamiento
L       = 3/2;
sigma	= (gamma(1+L)*sin(pi*L/2)/(gamma((1+L)/2)*L*2^((L-1)/2)))^(1/L);
tol     = 1e-6;                         % Accuracy o precision
xmin    = min(LB);                      % Posicion Minima
xmax    = max(UB);                      % Posicion Maxima
xi      = (rand(n,p))*(xmax-xmin)+xmin;	% Poblacion Inicial Cucos
[bestfun,bestpos,xi] = bestnest(xi,xi,fun);
t       = 1;                            % Tiempo inicial

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
    if secuence==1 && w~=7
        image_sequence(x,y,z,str,'CKLF ',n,t,xi)
    end
    %-----------------------------LEVY FLIGHTS-----------------------------
    xi2         = xi+alpha.*Levy(n,p,sigma,L).*(bestpos-xi).*rand(n,p);
    xi2         = limite(xi2,p,LB,UB);
    [~,~,xi]	= bestnest(xi,xi2,fun);
    %------------------------------EMPTY NEST------------------------------
    Z       = randperm(n);           % Mutacion
    xi2     = xi+(rand(n,p)).*heaviside(pa-rand(n,1)).*(bestpos-xi(Z,:));%actual
    xi2     = limite(xi2,p,LB,UB);
    [bestfun,bestpos,xi,y] = bestnest(xi,xi2,fun);
    t       = t+1;                  % Numero de evaluaciones

    [MSE, RMSE, MAE, MSPE, MAPE, RMSLE]=errores(y,gteo);
    mse(t)  = MSE;
    rmse(t) = RMSE;
    mae(t)  = MAE;
    mspe(t) = MSPE;
    mape(t) = MAPE;
    rmsle(t)= RMSLE;
    recordxi=[recordxi;bestpos];
    if mean(y)-bestfun<tol || mse(t)<tol
        s=s+1;
        exito=1;
        break
    end
end %End del While

if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end

function y = Levy(n,p,sigma,L)
%Funcion vuelo de Levy
%-------------------------------DESCRIPCION--------------------------------
% Funcion que calcula el vector de Levy
%----------------------------------INPUT-----------------------------------
%   - n         Cantidad de poblacion       (Valor)
%   - p         Dimensiones                 (Valor)
%   - sigma     Algoritmo de Mantegna       (Valor)
%   - L
%---------------------------------OUTPUT-----------------------------------
%	- y         Vector de Levy              (Valor)
%--------------------------------------------------------------------------
u=rand(n,p)*sigma;
v=rand(n,p);
y=u./abs(v).^(1/L);
end

function [bestfun,bestpos,xi,y] = bestnest(xi,xi2,fun)
%Funcion mejores nidos
%-------------------------------DESCRIPCION--------------------------------
% Funcion que calcula los mejores nidos
%----------------------------------INPUT-----------------------------------
%   - xi1       Posiciones de xi1       (Matriz n x p)
%   - xi2       Posiciones de xi2       (Matriz n x p)
%   - fun       Function Handle         Object
%---------------------------------OUTPUT-----------------------------------
%	- y         Vector de Nidos             (Valor)
%--------------------------------------------------------------------------
[~,~,f1,~] = ObjetiveFunction(fun,xi);
[~,~,f2,~] = ObjetiveFunction(fun,xi2);

I1=f2<=f1;
xi(I1,:)=xi2(I1,:);
[bestfun,bestpos,y,xi] = ObjetiveFunction(fun,xi); %pendiente
end