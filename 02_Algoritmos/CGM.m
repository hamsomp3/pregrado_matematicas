function [t,s,bestpos,bestfun,errores_cell,recordxi] = CGM(w,s,p)

secuence=0;
[LB,UB,~,gteo,str] = infofund(w,p);

if p==2
    [f1,grad,hes] = fundAnonymous2D(w);
    fun     = @(x) f1(x(1),x(2));
    gr      = @(x) grad(x(1),x(2));
    he      = @(x) hes(x(1),x(2));
else
    [f1,grad,hes] = fundAnonymous10D(w);
    fun     = @(x) f1(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
    gr      = @(x) grad(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
    he      = @(x) hes(x(1),x(2),x(3),x(4),x(5),x(6),x(7),x(8),x(9),x(10));
end
exito   = 0;
sel_beta    = 3;                            % Seleccionador de beta, ej: sel_beta=1 es Hestenes-Stiefel.
tol         = 1e-6;                         % Tolerancy
gnorm       = Inf;                          % Gradient norm
max_iter    = 10000;                        % Maximum number of iterations
perturb     = Inf;                          % Accuracy o precision
xmin        = min(LB);                      % Posicion Minima
xmax        = max(UB);                      % Posicion Maxima
xi          = rand(1,p)*(xmax-xmin)+xmin;   % x1 posicion inicial
d_ant       = 0;
beta_i      = 1;
t           = 1;

mse(t)      = Inf;
mse(t)      = Inf;
rmse(t)     = Inf;
mae(t)      = Inf;
mspe(t)     = Inf;
mape(t)     = Inf;
rmsle(t)    = Inf;
recordxi    = [xi];
try
    % https://www.mathworks.com/help/matlab/ref/try.html
    a=(mae(t-1)==mae(t));
catch
    a=false;
end
while (gnorm>=tol || perturb>=tol || mse(t)>=tol) && (~(a==true) && t<=max_iter)
    if secuence==1
        image_sequence(x,y,z,str,'CGM ',t,xi)
    end
    d_new=-gr(xi)+beta_i*d_ant;

    if w==5
        lambda_i=(gr(xi)'*gr(xi))/(d_new'*hes()*d_new); %
    else
        lambda_i=(gr(xi)'*gr(xi))/(d_new'*he(xi)*d_new); %
    end
    xinew   = xi+lambda_i*d_new';
    xinew   = limite(xinew,p,LB,UB);
    
    if t==1
        d_ant   = d_new;
        beta_i    = betak(gr,xi,xinew,d_ant,d_new,sel_beta);
    else
        beta_i    = betak(gr,xi,xinew,d_ant,d_new,sel_beta);
        d_ant   = d_new;
    end
    y       = fun(xinew);
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
        s=s+1;
        exito=1;
        break
    end % end if
end
if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end  % End Main Function


function [beta_i] = betak(gr,x1,x2,d1,d2,sel)
switch sel
    case 1
        %         Hestenes-Stiefel
        beta_i = (gr(x2)'*(gr(x2)-gr(x1)))/(d1'*(gr(x2)-gr(x1)));
    case 2
        %         Fletcher-Reeves (FR)
        beta_i = norm(gr(x2))^2/norm(gr(x1))^2;
    case 3
        %         Polak-Ribiere-Polyak (PRP)
        beta_i = (gr(x2)'*(gr(x2)-gr(x1)))/norm(gr(x1))^2;
    case 4
        %         Conjugate Descent (CD)
        beta_i = -norm(gr(x2))^2/(d1'*gr(x2));
    case 5
        %         Dai-Yuan (DY)
        beta_i = (norm(gr(x2))^2)/(d2'*(gr(x2)-gr(x1)));
    case 6
        %         WYL (Wei-Yao-Liu)
        beta_i = (d2'*(gr(x2)-(norm(gr(x2))/norm(gr(x1)))*gr(x1)))/(norm(gr(x1))^2);
    otherwise
        disp('No es un numero valido')
end
end
