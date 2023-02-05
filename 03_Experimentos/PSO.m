function [bestpos,t] = PSO(d,N,SOI_values,SNOI_values,p)
%% ----------------------------INFO ALGORITMO------------------------------
n       = 40;
max_iter= 1000;                 % Maximum number of iterations
alpha	= 0.3;                  % Constante de Aceleracion
betapso = 0.5;                  % Constante de Aceleracion
theta   = 0.95;                 % Inercia
LB      = -2*pi;
UB      = 2*pi;
xi      = rand(n,p)*(UB-LB)+LB; % Vector de pesos
vi      = zeros(n,p);           % Velocidad inicial
%% ----------------------------Algoritmo-----------------------------------
[bestfun,bestpos,~,xi] = objetive_function(xi,N,p,d,SOI_values,SNOI_values);
posmin  = bestpos;
t=1;

while t<=max_iter
    vi=theta*vi+alpha*rand(n,1).*(bestpos-xi)+betapso*rand(n,1).*(posmin-xi);
    xi=xi+vi;
    xi=limite(xi,p,LB,UB);
    [zmin,posmin,y,xi] = objetive_function(xi,N,p,d,SOI_values,SNOI_values);
    if zmin<=bestfun
        bestfun=zmin;
        bestpos=posmin;
        disp(t)
    end
    t=t+1;
end % end del while
end % end de la funcion principal