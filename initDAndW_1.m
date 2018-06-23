function[W,D] = initDAndW_1(T,NumberofTrainingData,number_class,class_t)
D = zeros(NumberofTrainingData,1);
for i = 1 : NumberofTrainingData
    [~,ti]=max(T(:,i)); %样本从属第几类
    %此处label_index_expected=1时，标记为0，以此类推
    for j = 1:number_class
        if ti == j 
            D(i) = 1/(class_t(j));
        end
    end
end
table = tabulate(D);
%table
W = diag(D);