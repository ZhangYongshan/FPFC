function [dataNew] = S3_PCA(data,k,labels)
% 
[nRow,nCol,dim] = size(data);
Results_segment= seg_im_class(data,labels);

Num = size(Results_segment.Y,2);
A = zeros(nRow*nCol,dim);

for i=1:Num
    tmpY = findConstruct(Results_segment.Y{1,i},Results_segment.cor{1,i},k);
    A(Results_segment.index{1,i},:) = tmpY;
end

dataNew = reshape(A,[nRow,nCol,dim]);
