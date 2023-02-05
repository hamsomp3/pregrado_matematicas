function [LB,UB,solteo,gteo,str] = infofund(w,p)
%-------------------------------------------------------------------------
% INFORMACION infofund(w,p)
% Realiza un switch case de todas las funciones test 
%----------------------------------INPUT-----------------------------------
% w         Valor del Switch        (Valor)
% w         Dimensiones             (Valor)
%----------------------------------OUTPUT----------------------------------
% LB        = Lower Bound
% UB        = Upper Bound
% solteo	= Solucion teorica
% gteo      = Valor de la funcion en solteo
% str       = Nombre de la funcion;
%-----------------------------Tipos de Funciones---------------------------
% - Brown
% - Pathological
% - Streched V Sine Wave
% - Wavy:
%--------------------------------------------------------------------------
switch w
    case 1
        str     = 'Brown';      % Nombre
%         LB      = -0.5*ones(1,p);	% Lower Bound es entre -5 y 5
%         UB      = 0.5*ones(1,p);	% Uper Bound

        LB      = -1*ones(1,p);	% Lower Bound es entre -5 y 5
        UB      = 1*ones(1,p);	% Uper Bound
        solteo	= zeros(1,p);	% Solucion teorica
        gteo	= 0;            % Funcion evaluada en solteo
    case 2
        str     = 'Pathological';% Nombre
        LB      = -100*ones(1,p);	% Lower Bound
        UB      = 100*ones(1,p);	% Uper Bound
        solteo	= zeros(1,p);  	% Solucion teorica
        gteo	= 0;            % Funcion evaluada en solteo
    case 3
        str     = 'Streched V Sine Wave';% Nombre
        LB      = -10*ones(1,p);        % Lower Bound
        UB      = 10*ones(1,p);         % Uper Bound
        solteo	= zeros(1,p);           % Solucion teorica
        gteo = 0;                       % Funcion evaluada en solteo
    case 4
        str     = 'Wavy';	% Nombre
        LB      = -pi*ones(1,p);      % Lower Bound
        UB      = pi*ones(1,p);       % Uper Bound
        solteo  = zeros(1,p);         % Solucion teorica
        gteo	= 0;                  % Funcion evaluada en solteo
    case 5
        str     = 'Prueba';	% Nombre
        LB      = -5*ones(1,p);      % Lower Bound
        UB      = 5*ones(1,p);       % Uper Bound
        solteo  = zeros(1,p);        % Solucion teorica
        gteo	= 0;                 % Funcion evaluada en solteo   
    case 6
        str     = 'Prueba2';	    % Nombre
        LB      = -1*ones(1,p);     % Lower Bound
        UB      = 1*ones(1,p);      % Uper Bound
        solteo  = [0.492293815827443, -0.364315352301847];% Solucion teorica
        gteo	= -0.457521622634071;% Funcion evaluada en solteo          
    otherwise
        disp('No es un numero valido')
end
end