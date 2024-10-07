clear; close all; clc;
addpath(genpath('funs'));
addpath("data\")
dataType = 'Trento'; dk = 28; set_viewnum(2);
iter = 15;
%%
data3D = cell(1,get_viewnum);
projDim = cell(1,get_viewnum);
switch dataType
    case 'Trento'
        load('trento_data.mat'); % 166*600
        data3D{1} = HSI_data; % d=63
        projDim{1} = 25;
        data3D{2} = LiDAR_data; % d=1
        projDim{2} = 1;
        gt2D = ground;
        num_Pixel = 185;
        options = [1.5;200;1e-5;1];
        clear  HSI_data LiDAR_data ground;

end

gt = double(gt2D(:));
ind = find(gt);
c = length(unique(gt(ind)));

[X,spLabel] = preData(data3D,dk, num_Pixel);
[y_pred] = main(X, spLabel(:), num_Pixel, c, projDim,iter,options);
results = evaluate_results_clustering(gt(ind),y_pred(ind));
results4 = round(results',4);
