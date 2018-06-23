function[W,D] = initDAndW_2(T,NumberofTrainingData,number_class,class_t)
D = zeros(NumberofTrainingData,1);
sum = 0;
for j = 1:number_class
    sum = sum + class_t(j);
end
AVG = sum / number_class;
for i = 1 : NumberofTrainingData
    [~,ti]=max(T(:,i)); %样本从属第几类
    %此处label_index_expected=1时，标记为0，以此类推
    for j = 1:number_class
        if ti == j 
            if class_t(j)>AVG
                D(i) = 0.618/(class_t(j));
            else
                 D(i) = 1/(class_t(j));
            end
        end
    end
end

W = diag(D);