function [mu] = updateMu(W,X,A,Z)

view_num = get_viewnum;
mu= ones(1,view_num)/view_num;
hv_sum = 0;
hv = zeros(1,view_num);
for v = 1:view_num
    H2 = X{v}*Z*A{v}';
    H3 = H2+H2';
    Q =  X{v}*X{v}' - H3 + A{v}*diag(sum(Z))*A{v}';
    hv(v) = trace(W{v}'*Q*W{v});
    hv_sum = hv_sum+sqrt(hv(v));
end

for v = 1:view_num
    mu(v) = sqrt(hv(v))/hv_sum;
end
end

