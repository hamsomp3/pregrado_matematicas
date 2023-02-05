function [bestpos,t] = CGM(d,N,SOI_values,SNOI_values,p)
%% ----------------------------INFO ALGORITMO------------------------------
sel_beta    = 3;                            % Seleccionador de beta, ej: sel_beta=1 es Hestenes-Stiefel.
gnorm       = Inf;                          % Gradient norm
max_iter    = 10000;                        % Maximum number of iterations
perturb     = Inf;                          % Accuracy o precision
LB          = -2*pi;
UB          = 2*pi;
xi          = rand(1,p)*(UB-LB)+LB;   % x1 posicion inicial
d_ant       = 0;
beta_i      = 1;
t           = 1;

while t<=max_iter
    [~,~,~,~,gr] = objetive_function(xi,N,p,d,SOI_values,SNOI_values);
    d_new=-gr+beta_i*d_ant;
    lambda_i=(gr'*gr)/(d_new'*d_new); %
    xinew   = xi+lambda_i*d_new';
    xinew   = limite(xinew,p,LB,UB);
    if t==1
        d_ant   = d_new;
        beta_i    = betak(gr,xi,xinew,d_ant,d_new,sel_beta);
    else
        beta_i    = betak(gr,xi,xinew,d_ant,d_new,sel_beta);
        d_ant   = d_new;
    end
    xi      = xinew;                % Reassigned values
    t=t+1;
end % end del while
[~,bestpos,~,~] = objetive_function(xi,N,p,d,SOI_values,SNOI_values);
end

function [beta_i] = betak(gr,x1,x2,d1,d2,sel)
switch sel
    case 1
        %         Hestenes-Stiefel
        beta_i = (gr(x2)'*(gr(x2)-gr(x1)))/(d1'*(gr(x2)-gr(x1)));
    case 2
        %         Fletcher-Reeves (FR)
        beta_i = norm(gr(x2))^2/norm(gr(x1))^2;
    case 3
        %         Conjugate Descent (CD)
        beta_i = -norm(gr)^2/(d1'*gr);
    case 4
        %         Dai-Yuan (DY)
        beta_i = (norm(gr(x2))^2)/(d2'*(gr(x2)-gr(x1)));
    case 5
        %         WYL (Wei-Yao-Liu)
        beta_i = (d2'*(gr(x2)-(norm(gr(x2))/norm(gr(x1)))*gr(x1)))/(norm(gr(x1))^2);
    otherwise
        disp('No es un numero valido')
end
end