function w=pesos(xi,N,p)
    k       = 2*pi;             % Numero de Onda valor fijo
    x       = 0:N(1)-1;         % Vector 0 a 7
    y1       = 0:N(2)-1;        % Vector 0 a 7
    [X,Y]   = meshgrid(x,y1);   % 8  8
    X       = reshape(X,1,[]);  % Reshape como vector fila
    Y       = reshape(Y,1,[]);  % Reshape como vector fila
%     w       = exp(1i*X.*xi(1,1:p)+Y.*xi(1,p+1:end)); %vector 1x64 o  n x 64
    w       = exp(1i*xi); %vector 1x64 o  n x 64
end