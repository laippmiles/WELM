function [T, P,NumberofData,NumberofInputNeurons, number_class,class_t] = Data(train_data)
%%%%%%%%%%% Load dataset
T=train_data(:,1)';
P=train_data(:,2:size(train_data,2))';
%   Release raw training data array

NumberofData=size(P,2);
NumberofInputNeurons=size(P,1);
table = tabulate(T);
table(table(:,2)==0,:) = [];
[number_class,~] = size(table);
class_t = table(:,2);
NumberofOutputNeurons = number_class;
%%%%%%%%%% Processing the targets of training
[label] = get_label(T, NumberofData);
temp_T=zeros(NumberofOutputNeurons, NumberofData);
for i = 1:NumberofData
    for j = 1:NumberofOutputNeurons
        if label(1,j) == T(1,i)
            break; 
        end
    end
    temp_T(j,i)=1;
end
T=temp_T*2-1;
end                                                 %   end if of Elm_Type