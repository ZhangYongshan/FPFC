function [U_new,obj_fcn,S] = fcm_mine(U,W,A,alpha,cluster_n, expo)
%%
% Input:
%       U is the fuzzy membership matrix with size C*M
%       expo is the exponent used to determine the degree of fuzziness in the membership matrix.
%         
%%
view_num = get_viewnum;
mf = U.^expo;
dist = 0;
S = cell(1,view_num);
dist_temp = cell(1,view_num);
for v = 1:view_num
    % calculates the distance between each column.
   S{v} = mf*A{v}'./(sum(mf,2)*ones(1,size(A{v}',2)));% new center
   S{v} = S{v}'; 
   dist_temp{v} = (pdist2((W{v}'*S{v})',(W{v}'*A{v})')).^2;
   dist = dist + (dist_temp{v})/alpha(v);
end

obj_fcn = sum(sum((dist).*mf)); 
tmp = dist.^(-1/(expo-1));         
U_new = tmp./(ones(cluster_n, 1)*sum(tmp));
end

