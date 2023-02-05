function [p_final,M_final] = errores_10D(errores_tol)
cant    = 4;
p       = zeros(cant,1);
K       = zeros(cant,1);
for i=1:cant
    error           = cell2mat(errores_tol(2,i));       % Variable del error
    error(error<1e-6)=nan;
    [m,~]       = size(cell2mat(errores_tol(2,i))); %Tamaño de la matriz de error
    str_err     = ["MSE","RMSE","MAE","RMSLE","MSPE","MAPE"];
    char        = convertStringsToChars(str_err(i));

    if m==1
        error_mean      = error';
        error_mean      = error_mean(~isnan(error_mean))';  % Se eliminan valores NaN (Not a Number)
        aux             = 0:length(error_mean)-1;           % Vector auxiliar
        logerror=10*log10(error_mean);
        [LT1]=trenddecomp(error_mean);                      % Tendencia Normal
        [LT2]=trenddecomp(logerror);                        % Tendencia Logaritmica
        [p_order,M_order] = PYK(LT1);
        %------------------PLOT en escala Log------------------------------
        %----------------------PLOT normal---------------------------------
    else
        error_mean      = mean(error,'omitnan');
        if isnan(mean(error_mean,'omitnan'))
            p_order     = nan;
            M_order     = nan;
        else
            error_mean      = error_mean';                      % Vector transpuesto
            error_mean      = error_mean(~isnan(error_mean))';  % Se eliminan valores NaN (Not a Number)
            aux             = 0:length(error_mean)-1;           % Vector auxiliar
            error_std       = std(error,'omitnan');
            error_std       = error_std';                        % Vector transpuesto
            error_std       = error_std(~isnan(error_std))';  % Se eliminan valores NaN (Not a Number)
            logerror        = 10*log10(error_mean);
            logerror        = logerror';
            logerror        = logerror(~isinf(logerror));
            aux1             = 0:length(logerror)-1;           % Vector auxiliar
            [LT1]           = trenddecomp(error_mean);
            [LT2]           = trenddecomp(logerror);
            [p_order,M_order] = PYK(LT1);
            LB      = error_mean-error_std;        % Lower Bound
            UB      = error_mean+error_std;        % Upper Bound
            %------------------PLOT en escala Log------------------------------
            %----------------------PLOT normal---------------------------------
        end% If mean del error
    end %end del if m==1

    p(i)       = p_order;
    K(i)       = M_order;

end % end del for
selector    = 2;
p_final     = p(selector);
M_final     = K(selector);
end