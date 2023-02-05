function [t,s,bestpos,bestfun,errores_cell,recordxi] = NMS(w,s,p)
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

radius  = 1;                            % Radio del Poliedro
tol     = 1e-6;                         % Tolerancy
max_iter= 1000;                         % Maximum number of iterations
perturb = Inf;                          % Accuracy o precision sirve para unimodal
xmin    = min(LB);                      % Posicion Minima
xmax    = max(UB);                      % Posicion Maxima
rho     = 1;
chi     = 2;
psi     = 0.5;
sigma   = 0.5;
xi      = rand(1,p)*(xmax-xmin)+xmin;   % Vector de Posicion Inicial
xf      =zeros(p+1,p);                  % Poblacion Inicial
xf(1,:) = xi;
xf(2:p+1,:) = ones(p,1)*xi+radius*(randi([0 1],p,p)*2-1).*eye(p);
xinew   = xf;
t       = 1;

mse(t)  = Inf;
mse(t)  = Inf;
rmse(t) = Inf;
mae(t)  = Inf;
mspe(t) = Inf;
mape(t) = Inf;
rmsle(t)= Inf;
recordxi=[xi];
y       = fun(xf);
[y,Ind] = sort(y);                       % Ordenamiento Ascendente de y
xf      = xf(Ind,:);                    % Ordenamiento Ascendente de y

try
    % https://www.mathworks.com/help/matlab/ref/try.html
    a=(mae(t-1)==mae(t));
catch
    a=false;
end

while (perturb>=tol || mse(t)>=tol) && (~(a==true) && t<=max_iter)
% while (perturb>=tol || e>=tol) && (t<=max_iter)
    if secuence==1
        image_sequence(x,y,z,str,'NMS ',t,xf)
    end
    xi=mean(xf(1:p,:));
    xh=xf(p+1,:);
    yh=fun(xh);
    xr=(1+rho)*xi-rho*xh;
    yr=fun(xr);
    if yr<y(1)
        xe=(1+rho*chi)*xi-rho*chi*xh;
        ye=fun(xe);
        if ye<yr
            xf(p+1,:)=xe;       % Replace the worst position
            y=fun(xf);          % Expandir
        else
            xf(p+1,:)=xr;       % Replace the worst position
            y=fun(xf);          % Reflejar
        end
    else
        if yr<y(p)
            xf(p+1,:)=xr;       % Replace the worst position
            y=fun(xf);          % Reflejar
        else
            if yr<yh
                xoc=(1+rho*psi)*xi-rho*psi*xf(p+1,:);
                yoc=fun(xoc);
                if yoc<yr
                    xf(p+1,:)=xoc;% Replace the worst position
                    y=fun(xf);  % Contraer hacia afuera
                else
                    xf(2:p+1,:) =xf(1,:)+sigma*(xf(2:p+1,:)-ones(p,1)*xf(1,:));
                    y=fun(xf);  % Shrink
                end
            else
                xic=(1-psi)*xi+psi*xf(p+1,:);
                yic=fun(xic);
                if yic < yh
                    xf(p+1,:)=xic;           % Replace the worst position
                    y=fun(xf);  % Contraer hacia adentro
                else
                    xf(2:p+1,:) =xf(1,:)+sigma*(xf(2:p+1,:)-ones(p,1)*xf(1,:));
                    y=fun(xf);  % Shrink
                end
            end
        end
    end
    xf   = limite(xf,p,LB,UB);
    [y,Ind] = sort(y);          % Ordenamiento Ascendente
    xf      = xf(Ind,:);        % Posiciones (Anterior)
    t       = t+1;              % Cantidad de iteraciones
    perturb = norm(xinew-xf);   % Perturbacion de las posiciones
    xinew   = xf;               % Posiciones (Actual)
    bestpos=xf(1,:);
    bestfun=y(1);
    [MSE, RMSE, MAE, MSPE, MAPE, RMSLE]=errores(y,gteo);
    mse(t)  = MSE;
    rmse(t) = RMSE;
    mae(t)  = MAE;
    mspe(t) = MSPE;
    mape(t) = MAPE;
    rmsle(t)= RMSLE;
    recordxi=[recordxi;bestpos];

    if (mse(t)<tol && mean(y)-bestfun<tol) && perturb<tol
        s=s+1;          % Incremento en la tasa de exito
        exito=1;
        break
    end % end if

end % End del While

if exito ==1
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse',rmse',mae',rmsle',mspe',mape',};
else
    errores_cell={'MSE','RMSE','MAE','RMSLE','MSPE','MAPE';mse'*nan,rmse'*nan,mae'*nan,rmsle'*nan,mspe'*nan,mape'*nan};
end
close all
end %End de la funcion
