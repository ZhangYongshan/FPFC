function [y_pred] = main(X, spLabel, m, cluster_n, r,iter_num,options)
%%
% X is the data matrix with dimensions d*n, where d is the number of features and n is the number of samples.
% m is the number of anchors used in the clustering algorithm.
% cluster_n is the number of clusters to be identified in the dataset.
% r is the dimensionality to which the data will be projected.
%  iter_num is the number of iterations the algorithm will run.
% options are the parameters for fuzzy clustering.
%%

%% init
view_num = get_viewnum;
k = 5;

alpha = ones(1,view_num)/view_num;
mu = ones(1,view_num)/view_num;
default_options = [1.5;	% exponent for the partition matrix U
    1000;	% max. number of iteration
    1e-5;	% min. amount of improvement
    0];	% info display during iteration
if nargin == 5
    options = default_options;
end
expo = options(1);		% Exponent for U
max_iter = options(2);		% Max. iteration
min_impro = options(3);		% Min. improvement
display = options(4);		% Display info or not
% init A,Z
A = initA(X, spLabel,m);
Z = updateZ(X, A, k);
W = initW(X,A,Z,r);
U = initU(cluster_n,m); % c*m
%%

for iter1 = 1:iter_num  
    Z = updateZ(X, A, k,W,mu);   
    mu = updateMu(W,X,A,Z);
    obj_fcn = zeros(max_iter, 1);
    for i = 1:max_iter
        [U,obj_fcn(i),S] = fcm_mine(U,W,A,alpha,cluster_n, expo);
        if display 
            fprintf('out_iter=%d,fcm_iter=%d,obj.fcn = %f\n',iter1, i, obj_fcn(i));
        end
        if i > 1
            if abs(obj_fcn(i) - obj_fcn(i-1)) < min_impro, break; end
        end
    end
    if find(isnan(U))
        break;
    end
    W = updateW(X,A,Z,U',S,mu,alpha,r,expo);
    alpha = updateAlpha(U',W,A,S,expo);
    A = updateA(X,Z,S,U',alpha,mu,expo); 
end

F = Z*U';
[~, y_pred] = max(F,[],2);
end
