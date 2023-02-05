function [y,x,fitness,xi] = ObjetiveFunction(fun,xi)
%Funcion Objetivo OF
%-------------------------------DESCRIPCION--------------------------------
% Es la funcion objetivo que se considera para el problema de optimizacion
%----------------------------------INPUT-----------------------------------
%   - fun       Population                  function Handle
%   - xi        Population                  (Vector n x p)
%---------------------------------OUTPUT-----------------------------------
%	- y         Best Function               (Valor)
%	- x         Best Position               (Vector 1 x p)
%	- fitness   All evaluated values        (Vector n x 1)
%	- xi        Sorted Population           (Vector n x p)
%--------------------------------------------------------------------------
[fitness,I1]    = sort(fun(xi));
xi              = xi(I1,:);     % Sorted population
x               = xi(1,:);      % Best position
y               = fitness(1);	% Best function
end