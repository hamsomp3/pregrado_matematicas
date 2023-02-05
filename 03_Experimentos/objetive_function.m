function [bestfun,bestpos,B,xi,gr] = objetive_function(xi,N,p,d,SOI,SNOI)

%% ------------------------- Vector de pesos W-----------------------------
k       = 2*pi;             % Numero de Onda valor fijo
x       = 0:N(1)-1;         % Vector 0 a 7
y       = 0:N(2)-1;         % Vector 0 a 7
[X,Y]   = meshgrid(x,y);    % 8  8
X       = reshape(X,1,[]);  % Reshape como vector fila
Y       = reshape(Y,1,[]);  % Reshape como vector fila
w       = exp(1i*xi);
%% -------------------------------- SOI------------------------------------
Amp1    = SOI(1,1);
theta1  = SOI(1,2)*pi/180;
phi1    = SOI(1,3)*pi/180;
PSI1    = k*d(1,1)*sin(theta1)*cos(phi1)*X + k*d(1,2)*sin(theta1)*sin(phi1)*Y;
PSI1    = reshape(PSI1,1,[]);   % Reshape como vector fila
a_0     = Amp1*exp(1i*PSI1)';
AFSOI   = w*a_0;
%% --------------------------------SNOI------------------------------------
AFSNOI=0;
for i=1:size(SNOI,1)
    Amp2    = SNOI(i,1);
    theta2  = SNOI(i,2)*pi/180;
    phi2    = SNOI(i,3)*pi/180;
    PSI2    = -k*d(1,1)*sin(theta2)*cos(phi2)*X - k*d(1,2)*sin(theta2)*sin(phi2)*Y;
    PSI2    = reshape(PSI2,1,[]);    % Reshape como vector fila
    AFSNOI  = AFSNOI+ w*Amp2*exp(1i*PSI2)';
end
%% --------------------------Cost Function (CF)----------------------------
%  CF=-(abs(AFSOI-AFSNOI).^2).^(1/2);
%CF=abs(AFSOI-AFSNOI);
CF=(abs(-(AFSOI-AFSNOI)).^2).^(1/2);
gr=-abs(AFSOI);
% CF=norm(AFSOI);
[B,I]=sort(CF);
xi=xi(I,:);
bestpos=xi(1,:);
bestfun=B(1);



end