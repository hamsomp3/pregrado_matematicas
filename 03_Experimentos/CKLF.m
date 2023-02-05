function [bestpos,t] = CKLF(d,N,SOI_values,SNOI_values,p)
%% ----------------------------INFO ALGORITMO------------------------------
n       = 40;       % Cantidad de particulas
max_iter= 1000;     % Maximum number of iterations
LB      = -2*pi;    % Upper Bound para beta
UB      = 2*pi;     % Lower Bound para beta
pa      = 0.25;     % Probabilidad de rechazo de nidos
alpha	= 0.30;     % Factor de escalamiento
L       = 3/2;
sigma	= (gamma(1+L)*sin(pi*L/2)/(gamma((1+L)/2)*L*2^((L-1)/2)))^(1/L);
xi      = rand(n,p)*(UB-LB)+LB;
[~,bestpos,xi] = best_nest(xi,xi,N,p,d,SOI_values,SNOI_values);
t       = 1;                            % Tiempo inicial
while t<=max_iter
%% -----------------------------LEVY FLIGHTS-----------------------------
    xi2         = xi+alpha.*Levy(n,p,sigma,L).*(bestpos-xi).*rand(n,p);
    xi2         = limite(xi2,p,LB,UB);
    [~,~,xi]	= best_nest(xi,xi2,N,p,d,SOI_values,SNOI_values);
%% ------------------------------EMPTY NEST------------------------------
    Z       = randperm(n);           % Mutacion
    xi2     = xi+(rand(n,p)).*heaviside(pa-rand(n,1)).*(bestpos-xi(Z,:));%actual
    xi2     = limite(xi2,p,LB,UB);
    [~,bestpos,xi] = best_nest(xi,xi2,N,p,d,SOI_values,SNOI_values);
    t       = t+1;
    disp(t)
end
w=pesos(bestpos,N,p);
w   = w/sum(w);    % Para considerar
end

function [bestfun,bestpos,xi1] = best_nest(xi1,xi2,N,p,d,SOI,SNOI)
    [~,~,fit1,xi1] = objetive_function(xi1,N,p,d,SOI,SNOI);
    [~,~,fit2,xi2] = objetive_function(xi2,N,p,d,SOI,SNOI);
    
    I1=fit2<=fit1;
    xi1(I1,:)=xi2(I1,:);
    [bestfun,bestpos,~,xi1] = objetive_function(xi1,N,p,d,SOI,SNOI);
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