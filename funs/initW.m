function W = initW(X,A,Z,r)
view_num = get_viewnum;
W = cell(1,view_num);
for v = 1:view_num
    W{v} = initW_detail(X{v},A{v},Z,r{v});
end
end

function newW = initW_detail(X,A,Z,r)
St = X*X';
H2 = X*Z*A';
H3 = H2+H2';
Q = St - H3 + A*diag(sum(Z))*A';
Q = (Q+Q')/2;
H = St\Q;
W = eig1(H,r,0,0);
newW = W*diag(1./sqrt(diag(W'*W)));
end