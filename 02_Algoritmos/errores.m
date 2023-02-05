function [MSE, RMSE, MAE, MSPE, MAPE, RMSLE] = errores(y,gteo)
% * (MSE) – Error cuadrático medio
MSE = sum((y-gteo).^2)/length(y);
% * (RMSE) -Error medio cuadrático
RMSE= sqrt(MSE);
% * (MAE) -Error absoluto medio
MAE = sum(abs(y-gteo))/length(y);
% * (MSPE) – Error de porcentaje cuadrático medio
MSPE=sum(((y-gteo)./y).^2)/length(y);
% * (MAPE) – Error porcentual absoluto medio
MAPE=sum(abs(y-gteo)./abs(y))/length(y);
% * (RMSLE) – Error logarítmico cuadrático medio
RMSLE=sum((log(y+1)-log(gteo+1)).^2)/length(y);
end