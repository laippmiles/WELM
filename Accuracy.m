function [TestingAccuracy] = Accuracy(TVT, TY,NumberofTestingData)
%-------------------------------------------------accuracy-----------------------------------------------------------------%
%{
if Elm_Type == REGRESSION
    TrainingAccuracy = sqrt(mse(T - Y));               %   Calculate training accuracy (RMSE) for regression case
    TestingAccuracy=sqrt(mse(TVT - TY));            %   Calculate testing accuracy (RMSE) for regression case
end
%}
%%%%%%%%%% Calculate training & testing classification accuracy
    MissClassificationRate_Testing=0;
    for i = 1 : NumberofTestingData
        [~, label_index_expected]=max(TVT(i,:));
        if size(TY,2) == 1
            [label_index_actual,~]=max(TY(i,:));
        else
            [~,label_index_actual]=max(TY(i,:));
        end
        if label_index_actual~=label_index_expected
            MissClassificationRate_Testing=MissClassificationRate_Testing+1;
        end
    end
    TestingAccuracy = 1-MissClassificationRate_Testing/size(TVT,1);  
end