function [S] = updateS(A,U)
view_num = get_viewnum;
S = cell(1,view_num);
for v = 1:view_num
    S{v} = A{v}*U/diag(sum(U));
end
end

