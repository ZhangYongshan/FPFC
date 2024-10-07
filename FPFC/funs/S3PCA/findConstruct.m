function [X_temp] = findConstruct(X,index,k)
    if index==0
        index=X;
    end
    if k>=size(X,1)
        k=size(X,1)-1;
    end
    [n,m] = size(X);
    X_temp = zeros(n,m);
    
%     distX = EuDist2(index);  
%     [~,idx2] = mink(distX,k+1,2);
%     [~,idx] = sort(distX,2);
%     idx2 = idx(:,1:k+1);
%     计算每行之间的欧式距离
    [~,idx2] = pdist2(index, index, 'euclidean','Smallest',k+1);
    idx2 = idx2';
    
    for i=1:n
        temp_x = X(idx2(i,:),:);
        X_temp(i,:) = mean(temp_x);
%         dd = EuDist2(X(i,:),temp_x);
%         if (sum(dd==0)==k-1)
%             X_temp(i,:) = X(i,:);
%         else
%             temp_w = exp(-dd.^2/(2*mean(dd))^2);
%             temp_w = temp_w/sum(temp_w);
%             X_temp(i,:) = temp_w*temp_x;
%         end
    end
end