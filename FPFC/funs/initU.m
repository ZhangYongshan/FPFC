function U  = initU(cluster_n, data_n)
rng(10); 
U = rand(cluster_n, data_n);
col_sum = sum(U);
U = U./col_sum(ones(cluster_n, 1), :);
end

