function [bestpos,t] = NMS(d,N,SOI_values,SNOI_values,p)
%% ----------------------------INFO ALGORITMO------------------------------
radius  = 1;                            % Radio del Poliedro
max_iter= 1000;                         % Maximum number of iterations
LB      = -2*pi;
UB      = 2*pi;
rho     = 1;
chi     = 2;
psi     = 0.5;
sigma   = 0.5;
xi      = rand(1,p)*(UB-LB)+LB; % Vector de pesos
xf      = zeros(p+1,p);                  % Poblacion Inicial
xf(1,:) = xi;
xf(2:p+1,:) = ones(p,1)*xi+radius*(randi([0 1],p,p)*2-1).*eye(p);
xinew   = xf;
t       = 1;
[~,~,y,xf]= objetive_function(xf,N,p,d,SOI_values,SNOI_values);

while t<=max_iter
    xi=mean(xf(1:p,:));
    xh=xf(p+1,:);
    [~,~,yh,~]=objetive_function(xh,N,p,d,SOI_values,SNOI_values);
    xr=(1+rho)*xi-rho*xh;
    [~,~,yr,~]=objetive_function(xr,N,p,d,SOI_values,SNOI_values);
    if yr<y(1)
        xe=(1+rho*chi)*xi-rho*chi*xh;
        [~,~,ye,~]=objetive_function(xe,N,p,d,SOI_values,SNOI_values);
        if ye<yr
            xf(p+1,:)=xe;       % Replace the worst position
            [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);          % Expandir
        else
            xf(p+1,:)=xr;       % Replace the worst position
            [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);          % Reflejar
        end
    else
        if yr<y(p)
            xf(p+1,:)=xr;       % Replace the worst position
            [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);          % Reflejar
        else
            if yr<yh
                xoc=(1+rho*psi)*xi-rho*psi*xf(p+1,:);
                [~,~,yoc,~]=objetive_function(xoc,N,p,d,SOI_values,SNOI_values);
                if yoc<yr
                    xf(p+1,:)=xoc;% Replace the worst position
                    [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);  % Contraer hacia afuera
                else
                    xf(2:p+1,:) =xf(1,:)+sigma*(xf(2:p+1,:)-ones(p,1)*xf(1,:));
                    [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);  % Shrink
                end
            else
                xic=(1-psi)*xi+psi*xf(p+1,:);
                [~,~,yic,~]=objetive_function(xic,N,p,d,SOI_values,SNOI_values);
                if yic < yh
                    xf(p+1,:)=xic;           % Replace the worst position
                    [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);  % Contraer hacia adentro
                else
                    xf(2:p+1,:) =xf(1,:)+sigma*(xf(2:p+1,:)-ones(p,1)*xf(1,:));
                    [~,~,y,~]=objetive_function(xf,N,p,d,SOI_values,SNOI_values);  % Shrink
                end
            end
        end
    end
    xf   = limite(xf,p,LB,UB);
    xinew   = xf;               % Posiciones (Actual)
    bestpos=xf(1,:);
    t=t+1;
end


end