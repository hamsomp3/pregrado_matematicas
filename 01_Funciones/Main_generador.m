clearvars
clc
%generador de imagenes
for i=4:4
    [LB,UB,~,~,str] = infofund(i,2);
    [f1,~] = fundAnonymous2D(i);
    Imagenes(str,LB,UB,f1)
end
