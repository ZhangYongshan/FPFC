function [X,labels] = preData(data3D,k,num_Pixel)
%% HSI data preprocessing
% Input:
%       data3D: 3D cube, HSI data.
%       num_Pixel: the number of superpixel.
% Output:
%       X: new data, 2D matrix. each column is a pixel 
%%
view_num = get_viewnum;
newData = cell(1,view_num);

data = data3D{1};
for v  = 2: view_num 
    data = cat(3, data, data3D{v});
end

[nRow,nCol,dim] = size(data);
X = reshape(data,nRow*nCol,dim); 
[X,~] = mapminmax(X); 
p = 1;

start_pca = tic;
coeff = pca(X);

fprintf("pca,time:%f\n",toc(start_pca)); 
Y_pca = X*coeff(:,1:p);


img = im2uint8(mat2gray(reshape(Y_pca, nRow, nCol, p))); 

% ERS super-pixel segmentation.
labels = mex_ers(double(img),num_Pixel);
labels = labels + 1; 


X = cell(1,view_num);
fprintf('denoising,');
for i = 1: view_num
    tic;
    [~,~,dim] = size(data3D{i});
    newData{i} = S3_PCA(data3D{i},k,labels); 
    time1 = toc;
    fprintf('time = %f\n',time1);
    X{i} = reshape(newData{i},nRow*nCol,dim);
    X{i} = X{i}';
end

end




