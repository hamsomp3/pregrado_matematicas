% prueba



% Fit a polynomial p of degree 1 to the (x,y) data:
x = 1:50;
y = -0.3*x + 2*randn(1,50);
p = polyfit(x,y,1);

% Evaluate the fitted polynomial p and plot:
f = polyval(p,x);
plot(x,y,'o',x,f,'-')
legend('data','linear fit')

