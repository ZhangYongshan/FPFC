function W = updateW(X,A,Z,U,S,mu,alpha,r,expo)
U = U.^expo;
view_num = get_viewnum;
W = cell(1,view_num);
for v = 1:view_num
    W{v} = updateW_detail(X{v}, A{v},Z, U,S{v},mu(v),alpha(v),r{v});
end
end

function newW = updateW_detail(X,A,Z,U,S,mu,alpha,r)
St = X*X';
H2 = X*Z*A';
H3 = H2+H2';
P = St - H3 + A*diag(sum(Z))*A';
temp1 = P;
P = (P + P')/2;
P = P/mu;
temp1 = temp1/mu;

Q1 = A*U*S';
Q2 = Q1+Q1';
Q = A*diag(sum(U,2))*A' - Q2 + S*diag(sum(U))*S';

Q = (Q + Q')/2;
Q = Q/alpha;

T = P + Q;
T = (T+T')/2;
H = St\T;

W = eig1(H,r,0,0);
W = real(W);
newW = W*diag(1./sqrt(diag(W'*W)));
end