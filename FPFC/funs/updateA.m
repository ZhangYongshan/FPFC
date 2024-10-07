function [A] = updateA(X,Z,S,U,alpha,mu,expo)
view_num = get_viewnum;
A = cell(1,view_num);
U = U.^expo;
for v = 1:view_num
    A1 = mu(v)*S{v}*U'+alpha(v)*X{v}*Z;
    A2 = alpha(v)*diag(sum(Z))+mu(v)*diag(sum(U,2));
    A2 = (A2 + A2') /2; 
    A{v} = A1/A2;
end
end

