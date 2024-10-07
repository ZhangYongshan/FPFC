function [alpha] = updateAlpha(U,W,A,S,expo)
U = U.^expo;
view_num = get_viewnum;
alpha= ones(1,view_num)/view_num;
hv_sum = 0;
hv = zeros(1,view_num);
for v = 1:view_num
    Q1 = A{v}*U*S{v}';
    Q2 = Q1+Q1';
    Q = A{v}*diag(sum(U,2))*A{v}' - Q2 + S{v}*diag(sum(U))*S{v}';
    hv(v) = trace(W{v}'*Q*W{v});
    hv_sum = hv_sum+sqrt(hv(v));
end

for v = 1:view_num
    alpha(v) = sqrt(hv(v))/hv_sum;
end
end

