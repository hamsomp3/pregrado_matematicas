function [w] = LMS(X,d,N)
k_length    = length(d);
e           = ones(1,k_length);
w           = zeros(1,N(1)*N(2));
beta        = 1;                                     % Valor de beta
alpha       = 0.0001;
for k=1:k_length
    mu=beta/(alpha+norm(X(:,k))^2);
    e(k)=d(k)-w*X(:,k);
    w=w+mu*X(:,k)'*e(k);            %actualizacion pesos
end
end