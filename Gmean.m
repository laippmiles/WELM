function[gmean,RnAverage_train] =  Gmean(T, Y,NumberofTestingData,number_class,RnAverage_train)
    TP=zeros(1,number_class);
    expectedClass = zeros(1,number_class);
    for i = 1 : NumberofTestingData
        %i
        %NumberofTestingData
        %size(Y)
        [~, label_index_expected]=max(T(i,:)); %样本从属第几类
        %此处label_index_expected=1时，标记为0，以此类推
        if size(Y,2) == 1
            [label_index_actual,~]=max(Y(i,:));
        else
            [~,label_index_actual]=max(Y(i,:));
        end
        
        if label_index_actual > number_class
            label_index_actual = label_index_actual - number_class;
        end
        
        for j = 1:number_class
            if label_index_expected == j && label_index_actual ==j
                TP(j) = TP(j) + 1;
            end

            if label_index_expected == j
                expectedClass(j) = expectedClass(j) +1;
            end
        end
        %if label_index_actual~=label_index_expected
        %    MissClassificationRate_Training=MissClassificationRate_Training+1;
        %end
    end
    %TrainingAccuracy=1-MissClassificationRate_Training/size(T,2)  ;
    R = 1;
    Rn = zeros(number_class,1);
    for j = 1:number_class
        %expectedClass(j)
        Rn(j) = TP(j)./expectedClass(j);
        %expectedClass(j)
        R = R * Rn(j);
        disp(['R',num2str(j),'train = ',num2str(Rn(j))]);
    end
    RnAverage_train = [RnAverage_train Rn];
    gmean = nthroot(R,number_class); 
    % nthroot(m,n):求m^(1/n)