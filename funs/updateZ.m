function [Z] = updateZ(X, anchor, k,W,mu)
%% construct anchor graph Z
% Input:
%       X: data matrix, d by n 
%       anchor: anchor matrix, d by m k: Number of neighbors
% Output:
%       Z: n by m
%%
view_num = get_viewnum;
if nargin < 4
    [~, num] = size(X{1});
    [~,numAnchor] = size(anchor{1});
    distX = zeros(num,numAnchor);
    for v = 1: view_num
        temp = (pdist2((X{v})',anchor{v}')).^2;
        distX = distX+temp;
    end 
else
    [~, num] = size(W{1}'*X{1});
    [~,numAnchor] = size(W{1}'*anchor{1});
    distX = zeros(num,numAnchor);
    for v = 1: view_num
        temp = (pdist2((W{v}'*X{v})',( W{v}'*anchor{v})')).^2*(1/mu(v));
        distX = distX+temp;
    end
    
end

% old version
% for i = 1:num
%     id = idx(i,1:k+1);
%      di = distX(i,id);
%      Z(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
% end

% the optimized code
Z = zeros(num, numAnchor);
[~, idx] = sort(distX, 2);
id = idx(1:num,1:k+1);
indices = sub2ind(size(distX),repmat((1:num)',[1,k+1]),id);
di = distX(indices);
Z(indices) = (di(:,k+1)-di)./(k.*di(:,k+1)-sum(di(:,1:k),2)+eps);
end




