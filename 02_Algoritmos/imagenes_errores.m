function [p_final,M_final] = imagenes_errores(errores_tol,str_al,w,SR)
cant    = 4;
p       = zeros(cant,1);
K       = zeros(cant,1);
for i=1:cant
    error           = cell2mat(errores_tol(2,i));       % Variable del error
    error(error<1e-6)=nan;
    [m,~]       = size(cell2mat(errores_tol(2,i)));     %Tamaño de la matriz de error
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
        figure(i+3)
        hold on
        plot(aux,logerror,aux,LT2,'-','LineWidth',2)
        legend({char,'Trend',},'Location','northeast')
        title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ' escala Log, $$p=$$',num2str(round(p_order,2))],'interpreter','latex');
        xlabel('Iteraciones');
        ylabel([char,' (dBs)']);
        grid on
        axis([0 length(error_mean)-1 min([min(logerror),min(LT2)]) max([max(logerror),max(LT2)])])
        nombre = strcat('Error_fun_',num2str(w),str_al,'_',char,'_b1');
        print(nombre,'-dpng')
        hold off
        %----------------------PLOT normal---------------------------------
        figure(i+9)
        hold on
        plot(aux,error_mean,aux,LT1,'-','LineWidth',2)
        legend({char,'Trend',},'Location','northeast')
        title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ', $$p=$$',num2str(round(p_order,2))],'interpreter','latex');
        xlabel('Iteraciones');
        ylabel([char,' (dBs)']);
        grid on
        axis([0 length(error_mean)-1 0 max([max(error_mean),max(LT1)])])
        nombre = strcat('Error_fun_',num2str(w),str_al,'_',char,'_a');
        print(nombre,'-dpng')
        hold off
    else
        error_mean      = mean(error,'omitnan');
        if isnan(mean(error_mean,'omitnan'))
            p_order     = nan;
            M_order     = nan;
%             break
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
            figure(i+3)
            hold on
            plot(aux1,logerror,aux1,LT2,'r--','LineWidth',2);
            legend({char,'Trend',},'Location','northeast')
            title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ' escala Log, $$p=$$',num2str(round(p_order,2)), ', $$SR =$$',num2str(SR(w)),'$$\%$$'],'interpreter','latex');
            xlabel('Iteraciones');
            ylabel([char,' (dBs)']);
            grid on
            if min([min(logerror),min(LT2)])==max([max(logerror),max(LT2)])
                axis([0 length(error_mean)-1 min([min(logerror),min(LT2)])-1 max([max(logerror),max(LT2)])+1])
            else
                axis([0 length(error_mean)-1 min([min(logerror),min(LT2)]) max([max(logerror),max(LT2)])])
            end
            nombre = strcat('Error_fun_',num2str(w),str_al,'_',char,'_b');
            print(nombre,'-depsc')
            print(nombre,'-dpng')
            hold off
            %----------------------PLOT normal---------------------------------
            figure(i+9)
            hold on
            patch([aux fliplr(aux)], [LB fliplr(UB)], [0.3010 0.7450 0.9330]);
            plot(aux,error_mean,aux,LT1,'r--','LineWidth',2);
            legend({char,'Trend',},'Location','northeast')
            title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ' escala Log, $$p=$$',num2str(round(p_order,2)), ', $$SR =$$',num2str(SR(w)),'$$\%$$'],'interpreter','latex');
            xlabel('Iteraciones');
            ylabel(char);
            grid on

            if min([min(error_mean),min(LT1)])==max([max(error_mean),max(LT1)])
                axis([0 length(error_mean)-1 min([min(error_mean),min(LT1)])-1 max([max(error_mean),max(LT1)])+1])
            else
                axis([0 length(error_mean)-1 min([min(error_mean),min(LT1)]) max([max(error_mean),max(LT1)])])
            end

            nombre = strcat('Error_fun_',num2str(w),str_al,'_',char,'_a');
            print(nombre,'-depsc')
            print(nombre,'-dpng')
            hold off
        end% If mean del error
    end %end del if m==1

    p(i)       = p_order;
    K(i)       = M_order;

end % end del for
selector    = 2;
p_final     = p(selector);
M_final     = K(selector);
end