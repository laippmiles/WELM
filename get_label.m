function[label] = get_label(Data, NumberofData)
    %%%%%%%%%%%% Preprocessing the data of classification
    sorted_target=sort(Data,2);
   %{
    --------------------------------------------------------------%
    %cat 构造多维数组
    %C = cat(dim,A,B)
    %C = cat(dim,A1,A2,A3,A4,...)
    %dim为1时，将矩阵上下拼接
    %dim为2时，将矩阵左右拼接
    %[A,B]，dim=3时则可以构造三维数组（这个应该暂时用不着）
    %--------------------------------------------------------------%
    %sort（A,dim，mode）：对矩阵的元素进行排序
    %dim=1，按列排序；dim=2，按行排序
    %mode缺省为升序，需要降序是填'descend'
    %--------------------------------------------------------------
    %}
    label=zeros(1,1);                               %   Find and save in 'label' class label from training and testing data sets
    label(1,1)=sorted_target(1,1);
    j=1;
    for i = 2:(NumberofData)
        if sorted_target(1,i) ~= label(1,j)
            j=j+1;
            label(1,j) = sorted_target(1,i);
        end
    end
    number_class=j;

       