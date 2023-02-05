clearvars
clc
close all
%% --------------------------INFO ANTENA-----------------------------------
N           = [8 8];                    % Tamaño Antena
p           = N(1)*N(2);                % Dimension Antena
d           = [0.5 0.5];                % va en main
SOI_values  = [1 40 90];                % va en main theta phi
SNOI_values = [0.5 20 70; 1 60 110];    % Amp Theta Phi Interferentes
str_err         = ["CGM","SGD","NMS","PSO","BA","CKLF"];
num             = 6;
switch num
    case 1
        disp('Conjugate Gradient Method (CGM)')
        [bestpos,t]=CGM(d,N,SOI_values,SNOI_values,p);
    case 2
        disp('Stocastich Gradient Descent (SGD)')
        [bestpos,t]=SGD(d,N,SOI_values,SNOI_values,p);
    case 3
        disp('Nelder Mead Search (NMS)')
        [bestpos,t]=NMS(d,N,SOI_values,SNOI_values,p);
    case 4
        disp('Particle Swarm Optimization (PSO)')
        [bestpos,t]=PSO(d,N,SOI_values,SNOI_values,p);
    case 5
        disp('Bat Algorithm (BA)')
        [bestpos,t]=BA(d,N,SOI_values,SNOI_values,p);
    case 6
        disp('Cuckoo Search by Levy Flights (CKLF')
        [bestpos,t]=CKLF(d,N,SOI_values,SNOI_values,p);
    otherwise
        disp('No es un numero valido')
end



k       = 2*pi;             % Numero de Onda valor fijo
x       = 0:N(1)-1;         % Vector 0 a 7
y1       = 0:N(2)-1;        % Vector 0 a 7
[X,Y]   = meshgrid(x,y1);   % 8  8
X       = reshape(X,1,[]);  % Reshape como vector fila
Y       = reshape(Y,1,[]);  % Reshape como vector fila
w       = exp(1i*X.*bestpos+Y.*bestpos); %vector 1x64 o  n x 64


nombre    = convertStringsToChars(str_err(num));
%--------------------------Coordenadas Esféricas---------------------------
% Img_Esfericas(w,char)
%-------------------------Coordenadas Cilíndricas--------------------------
% Img_Cilindricas(w,char)
% %------------------------Patron de Radiación en Phi------------------------
Img_Radphi(w',N,d,SOI_values,nombre,SNOI_values)
% %-----------------------Patron de Radiación en Theta-----------------------
Img_Radtheta(w',N,d,SOI_values,nombre,SNOI_values)
% %------------------Patron de Radiación en Theta Polares--------------------
% Img_Radthetapol(w',SOI_values,char)
% %--------------------------Distribucion Magnitud---------------------------
% Img_Distmagnitud(Wbestpos,0,char)
% %----------------------------Distribucion Fase-----------------------------
% Img_Distfase(beta1,0,char)
% %-------------------------------Directividad-----------------------------
% Img_Directividad(w,char)