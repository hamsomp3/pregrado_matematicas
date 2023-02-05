function [x_k,s,Rxxs,Rxxu,Rxxn] = SOI_SNOI_NOISE(N,d,k_length,SOI,SNOI,Noise)
%% ----------------------------------INFO----------------------------------
k               = 2*pi;                 % Numero de Onda valor fijo
x               = 0:N(1)-1;             % Vector 0 a 7
y               = 0:N(2)-1;             % Vector 0 a 7
[X,Y]           = meshgrid(x,y);        % 8 x 8
%% ----------------------------------SOI-----------------------------------
T       = 1E-3;
t       = (1:k_length)*T/k_length;
s       = cos(2*pi*t/T);
Amp1    = SOI(1,1);
theta1  = SOI(1,2)*pi/180;
phi1    = SOI(1,3)*pi/180;
PSI1    = k*d(1,1)*sin(theta1)*cos(phi1)*X + k*d(1,2)*sin(theta1)*sin(phi1)*Y;
PSI1    = reshape(PSI1,1,[]);   % Reshape como vector fila
a_0     = Amp1*exp(1i*PSI1)';
sd      = a_0*s;                % Señal deseada

Rxxs    = 1/k_length*(sd*sd');
%% --------------------------------SNOI------------------------------------
I       = rand(size(SNOI,1),k_length);
A       = zeros(N(1)*N(2),size(SNOI,1));
for i=1:size(SNOI,1)
    Amp2    = SNOI(i,1);
    theta2  = SNOI(i,2)*pi/180;
    phi2    = SNOI(i,3)*pi/180;
    PSI2    = -k*d(1,1)*sin(theta2)*cos(phi2)*X - k*d(1,2)*sin(theta2)*sin(phi2)*Y;
    PSI2    = reshape(PSI2,1,[]);    % Reshape como vector fila
    A(:,i)  = Amp2*exp(1i*PSI2)';
end
u       = A*I;
Rxxu    = 1/k_length*(u*u');
%% --------------------------------NOISE-----------------------------------
media       = Noise(1,1);
varianza    = Noise(1,1);
Ruido_Real  = media+sqrt(varianza/2)*rand(N(1)*N(2),k_length);
Ruido_Img   = media+sqrt(varianza/2)*rand(N(1)*N(2),k_length);
Ruido       = complex(Ruido_Real,Ruido_Img);
Rxxn        = 1/k_length*(Ruido*Ruido');
x_k         = sd+u+Ruido;
end