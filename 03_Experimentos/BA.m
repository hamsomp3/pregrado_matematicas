function [bestpos,t] = BA(d,N,SOI_values,SNOI_values,p)
%% ----------------------------INFO ALGORITMO------------------------------
n       = 40;           % Cantidad de particulas
max_iter= 1000;         % Maximum number of iterations
alpha   = 0.6;         % Parametro alpha
gamma   = 0.5;         % Parametro gamma
alpha1	= 0.3;          % Constante de Aceleracion
theta   = 0.95;         % Inercia
Amin    = 1;            % Volumen minimo
Amax    = 2;            % Volumen maximo
fmin    = 0;            % Frecuencia minima
fmax    = 2;            % Frecuncia maxima
LB      = -2*pi;        % Upper Bound para beta
UB      = 2*pi;         % Lower Bound para beta
%% ----------------------------Algoritmo-----------------------------------
xi1      = rand(n,p)*(UB-LB)+LB;
vi      = zeros(n,p); % Velocidad inicial
t       = 1;            % Tiempo inicial
A       = (Amax-Amin).*rand(n,1)+Amin;	% Volumen inicial(Loudness)
r0      = 0.1.*rand(n,1);% Tasa de emision de pulsos inicial cercana a cero
r       = r0*(1-exp(-gamma*t));% Aumenta cota r_0;
[bestfun,bestpos,~,xi1] = objetive_function(xi1,N,p,d,SOI_values,SNOI_values);

while t<=max_iter

    fi=fmin+(fmax-fmin).*rand(n,1);
    vi=theta*vi+alpha1*rand(n,1).*(bestpos-xi1).*fi;
    xi2=xi1+vi;
    xi2=limite(xi2,p,LB,UB);
    [~,~,fitness2,xi2] = objetive_function(xi2,N,p,d,SOI_values,SNOI_values); % no es necesario

    aleator1=rand(n,p)*2-1;
    I1=rand(n,1) < r;
    xi1(I1,:)=bestpos+0.01*aleator1(I1,:)*mean(A);
    xi1=limite(xi1,p,LB,UB);
    [~,~,fit1,xi1] = objetive_function(xi1,N,p,d,SOI_values,SNOI_values);
    
    I2=rand(n,1) > A;
    I3=fit1 < bestfun;
    I4=and(I2,I3);
    
    r(I4)    = r0(I4)*(1-exp(-gamma*t));	% Aumenta cota r_0
    A(I4)    = alpha*A(I4); 

    xi1(floor(n/2)+1:end,:)=xi2(1:floor(n/2),:);
    [bestfun,bestpos,fitness1,xi1] = objetive_function(xi1,N,p,d,SOI_values,SNOI_values);
    t=t+1;
    disp(t)
end


w=pesos(bestpos,N,p);
end % end de la funcion principal