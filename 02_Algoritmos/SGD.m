function [t,s,bestpos,bestfun,errores_cell,recordxi] = SGD(w,s,p)
secuence=0;
[LB,UB,~,gteo,str] = infofund(w,p);
if p==2
    [f1,grad] = fundAnonymous2D(w);
    fun     = @(x) f1(x(1),x(2));
    gr      = @(x) grad(x(1),x(2));
else
    [f1,grad] = fundAnonymous10D(w);
    fun     = @(x) f1(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
    gr      = @(x) grad(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
end
exito   = 0;
alpha   = 0.1;                          % Step Size
tol     = 1e-6;                         % Tolerancy
gnorm   = Inf;                          % Gradient norm
max_iter= 1000;                         % Maximum number of iterations
perturb = Inf;                          % perturbation
xmin    = min(LB);                      % Posicion Minima
xmax    = max(UB);                      % Posicion Maxima
xi      = rand(1,p)*(xmax-xmin)+xmin;   % Vector de Posicion Inicial
t       = 1;

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

while (gnorm>=tol || perturb>=tol || mse(t)>=tol) && (~(a==true) && t<=max_iter)
    if secuence==1
        image_sequence(x,y,z,str,'SGD ',t,xi)
    end
    r       = randi(p,1);           % Indice de alguna coordenada
    grad    = gr(xi);
    g       = zeros(p,1);
    g(r)    = grad(r);              % Gradient
    gnorm   = norm(g);              % Gradient Norm
    xinew   = xi-alpha*g';          % New value of xi
    xinew   = limite(xinew,p,LB,UB);
    y       = fun(xi);
    t       = t+1;                  %Evaluacion siguiente
    [MSE, RMSE, MAE, MSPE, MAPE, RMSLE]=errores(y,gteo);
    mse(t)  = MSE;
    rmse(t) = RMSE;
    mae(t)  = MAE;
    mspe(t) = MSPE;
    mape(t) = MAPE;
    rmsle(t)= RMSLE;
    perturb = norm(xinew-xi);       % Perturbation
    xi      = xinew;                % Reassigned values
    bestfun = fun(xi);
    bestpos = xi;                   % Best position
    recordxi=[recordxi;bestpos];
    if mse(t)<tol && mean(y)-bestfun<tol && (gnorm<tol || perturb<tol)
        s=s+1;          % Incremento en la tasa de exito
        exito=1;
        break
    end % end if
end % End While
if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end % End Main Function