function Results = seg_im_class(Y,Ln)
[M,N,B]=size(Y);
Y_reshape=reshape(Y,M*N,B);
Gt=reshape(Ln,[1,M*N]);
Class=unique(Gt);
Num=size(Class,2);
for i=1:Num
    Results.index{1,i}=find(Gt==Class(i));
    [m,n] = find(Ln==Class(i));
    Results.cor{1,i} = [m,n];
    Results.Y{1,i} =Y_reshape(Gt==Class(i),:);
end
