clearvars
close all
format LongEng
clc
rng(555,'philox')
tipo    = 'BA';            % Stocastic Gradient Descent
cant	= 4;                % Cantidad de funciones test
dimensi = 10;                % Cantidad de dimensioness
lim     = 100;              % Cant. veces que se repite el algoritmo aprox 100
longvect= 1000;
mi      = zeros(cant,1);    % Inicio Mean iterations
iter    = zeros(1,lim);     % Inicio iteraciones
stdi	= zeros(cant,1);    % Inicio St Deviation iteration
tiempo	= zeros(cant,1);    % Inicio time
mbf     = zeros(cant,1);    % Inicio Mean Best Function
stdbf   = zeros(cant,1);    % Inicio St Deviation Best Function
SR      = zeros(cant,1);    % Inicio Success Rate (%)
maxi    = zeros(cant,1);	% Minimo de iteraciones
mini    = zeros(cant,1);	% Maximo de iteraciones

MSE_w    = zeros(lim,1);
RMSE_w   = zeros(lim,1);
MAE_w    = zeros(lim,1);
MSPE_w   = zeros(lim,1);
MAPE_w   = zeros(lim,1);
RMSLE_w  = zeros(lim,1);

MSEi    = zeros(cant,1);
RMSEi   = zeros(cant,1);
MAEi    = zeros(cant,1);
MSPEi   = zeros(cant,1);
MAPEi   = zeros(cant,1);
RMSLEi  = zeros(cant,1);
p_order = zeros(cant,1);
k_order = zeros(cant,1);

for w=1:4
    p           = dimensi;
    bp          = zeros(lim,p);	% Best Pos
    bf          = zeros(lim,1);	% Best Fun
    matrix_MSE  = zeros(lim,longvect);
    matrix_RMSE = zeros(lim,longvect);
    matrix_MAE  = zeros(lim,longvect);
    matrix_MSPE = zeros(lim,longvect);
    matrix_MAPE = zeros(lim,longvect);
    matrix_RMSLE= zeros(lim,longvect);
    suma    = 0;            % Acumulador
    tic
    cont    = 0;
    for i=1:lim
        [t,suma,bestpos,bestfun,errores_celda,rxi]=BA(w,suma,p);
        bp(i,:) = bestpos;
        bf(i)   = bestfun;
        iter(i) = t-1;

        temp=cell2mat(errores_celda(2,1))';
        MSE_w(i)=temp(end);
        temp=cell2mat(errores_celda(2,2))';
        RMSE_w(i)=temp(end);
        temp=cell2mat(errores_celda(2,3))';
        MAE_w(i)=temp(end);
        temp=cell2mat(errores_celda(2,4))';
        RMSLE_w(i)=temp(end);
        temp=cell2mat(errores_celda(2,5))';
        MSPE_w(i)=temp(end);
        temp=cell2mat(errores_celda(2,6))';
        MAPE_w(i)=temp(end);
        
        matrix_MSE(i,1:t)   = cell2mat(errores_celda(2,1))';
        matrix_RMSE(i,1:t)  = cell2mat(errores_celda(2,2))';
        matrix_MAE(i,1:t)   = cell2mat(errores_celda(2,3))';
        matrix_MSPE(i,1:t)  = cell2mat(errores_celda(2,4))';
        matrix_MAPE(i,1:t)  = cell2mat(errores_celda(2,5))';
        matrix_RMSLE(i,1:t) = cell2mat(errores_celda(2,6))';
        cont    = cont+1;
    end
    tiempo(w)	= round(toc,4);                  % Fin Tiempo
    SR(w)       = 100*(suma)/lim;	    % Success Rate (%)
    mi(w)       = round(mean(iter));    % Mean Iterations
    stdi(w)     = round(std(iter));	    % Standard Deviation Iteration
    mbf(w)      = round(mean(bf));	    % Mean Bestfunction
    stdbf(w)    = round(std(bf));       % Standard Deviation Bestfunction
    maxi(w)     = round(max(iter));	    % Min Iteration
    mini(w)     = round(min(iter));	    % Max Iteration

    MSEi(w)     = round(mean(MSE_w,'omitnan')*1e6,4);
    RMSEi(w)    = round(mean(RMSE_w,'omitnan')*1e6,4);
    MAEi(w)     = round(mean(MAE_w,'omitnan')*1e6,4);
    MSPEi(w)    = round(mean(MSPE_w,'omitnan')*1e6,4);
    MAPEi(w)    = round(mean(MAPE_w,'omitnan')*1e6,4);
    RMSLEi(w)   = round(mean(RMSLE_w,'omitnan')*1e6,4);

    matrix_MSE(:,1)     = [];
    matrix_RMSE(:,1)    = [];
    matrix_MAE(:,1)     = [];
    matrix_MSPE(:,1)    = [];
    matrix_MAPE(:,1)    = [];
    matrix_RMSLE(:,1)   = [];

    errores_totales={'MSE', 'RMSE', 'MAE', 'MSPE', 'MAPE', 'RMSLE'; matrix_MSE, matrix_RMSE, matrix_MAE, matrix_MSPE, matrix_MAPE, matrix_RMSLE};
    %-----------------------------------------------------------------
    if dimensi==2
        imagenes(bp,w,lim,mi,stdi,SR,tipo,rxi)
        [p_or,M_or]=imagenes_errores(errores_totales,tipo,w,SR);
    else
        [p_or,M_or]=errores_10D(errores_totales);
    end
    p_order(w) = p_or;
    k_order(w) = M_or;
end
tabla1                      = [tiempo,mi,stdi,SR];
DB                          = array2table(tabla1);
DB.Properties.VariableNames = {'Tiempo' '$\mu$' '$\pm \sigma$' 'SR'};
DB.Properties.RowNames      = {'$fun_1$' '$fun_2$' '$fun_3$' '$fun_4$'};
writetable(DB, strcat(tipo, '_', num2str(dimensi), 'Da', '.csv'), 'Delimiter', ',', 'WriteRowNames', true)

tabla2                      = [MSEi,RMSEi,MAEi,MSPEi,MAPEi,RMSLEi,p_order,k_order];
DB                          = array2table(tabla2);
DB.Properties.VariableNames = {'MSE (1 \times 10^{-6})' 'RMSE (1 \times 10^{-6})' 'MAE (1 \times 10^{-6})' 'MSPE (1 \times 10^{-6})' 'MAPE (1 \times 10^{-6})' 'RMSLE (1 \times 10^{-6})' 'p order' 'k order'};
DB.Properties.RowNames      = {'$fun_1$' '$fun_2$' '$fun_3$' '$fun_4$'};
writetable(DB, strcat(tipo, '_', num2str(dimensi), 'Db', '.csv'), 'Delimiter', ',', 'WriteRowNames', true)