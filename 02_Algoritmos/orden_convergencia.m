function [p,M] = orden_convergencia(error,str_al,str_err,w)
error=error(2:end);
aux=0:length(error)-1;
%-------------------- CALCULO p y K--------------------------------------
disp('Error normal')
[p,M] = PYK(error)
activar_graficas=1;

if activar_graficas==1
    figure(16)
    hold on
    [LT1]=trenddecomp(error);
    disp('Error tendencia normal')
    [p,M] = PYK(LT1)
    plot(aux,error,aux,LT1,'LineWidth',2)
    legend(str_err,'Trend')
    title(['Funcion ',num2str(w) ', Algoritmo: ',str_al, ', $$p=$$',num2str(round(p,2))],'interpreter','latex');
    xlabel('Iteraciones');
    ylabel(str_err);
    grid on
    axis([0 length(error)-1 0 max(error)])
    nombre = strcat('Interpolacion_polinomio_',str_al,'_',str_err,'_fun_',num2str(w),'_a');
    print(nombre,'-dpng')
    hold off
    
    

    figure(17)
    hold on
    logmse=10*log10(error);
    [LT2]=trenddecomp(logmse);
    disp('Error tendencia log')
    [p,M] = PYK(LT2)
    %-----------------------------------------------------------------------
    plot(aux,logmse,aux,LT2,'r--','LineWidth',2)
    legend({str_err,'Trend',},'Location','southwest')
    title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ' escala Log, $$p=$$',num2str(round(p,2))],'interpreter','latex');
    xlabel('Iteraciones');
    ylabel([str_err,' (dBs)']);
    grid on
    axis([0 length(error)-1 min([min(logmse),min(LT2)]) max([max(logmse),max(LT2)])])
    nombre = strcat('Interpolacion_polinomio_',str_al,'_',str_err,'_fun_',num2str(w),'_b');
    print(nombre,'-dpng')
    hold off 
    close all



%     figure(17)
%     hold on
%     logmse=10*log10(LT1);
%     [LT2]=trenddecomp(logmse);
%     disp('Error tendencia log')
%     [p,M] = PYK(LT2)
%     %-----------------------------------------------------------------------
%     plot(aux,logmse,aux,LT2,'-','LineWidth',2)
%     legend({str_err,'Trend',},'Location','southwest')
%     title(['Funcion: ',num2str(w) ', Algoritmo: ',str_al, ' escala Log, $$p=$$',num2str(round(p,2))],'interpreter','latex');
%     xlabel('Iteraciones');
%     ylabel([str_err,' (dBs)']);
%     grid on
%     axis([0 length(LT1)-1 min([min(LT1),min(LT2)]) max([max(LT1),max(LT2)])])
%     nombre = strcat('Interpolacion_polinomio_',str_al,'_',str_err,'_fun_',num2str(w),'_b');
%     print(nombre,'-dpng')
%     hold off 
%     close all














end