function [bestpos,t] = SGD(d,N,SOI_values,SNOI_values,p)
alpha   = 0.1;  % Step Size or Learning Rate
t       =1;     % time or iterations
max_iter= 1000; % maximum number of iterations
LB      = -2*pi;
UB      = 2*pi;
xi      = rand(1,p)*(UB-LB)+LB; % Vector de pesos

while t<=max_iter
    r       = randi(p,1);           % Indice de alguna coordenada
    [~,grad,~,~] = objetive_function(xi,N,p,d,SOI_values,SNOI_values);
    g       = zeros(p,1);           %pendiente
    g(r)    = grad(r);              % Gradient
    xinew   = xi-alpha*g';          % New value of xi
    xinew   = limite(xinew,p,LB,UB);
    xinew   = xinew/sum(xinew);    % Para considerar
    t       = t+1;  
    t=t+1;
    perturb = norm(xinew-xi);       % Perturbation
    xi      = xinew;                % Reassigned values
    bestpos = xi;  
end
end