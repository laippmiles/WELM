function[label] = get_label(Data, NumberofData)
    %%%%%%%%%%%% Preprocessing the data of classification
    sorted_target=sort(Data,2);
   %{
    --------------------------------------------------------------%
    %cat �����ά����
    %C = cat(dim,A,B)
    %C = cat(dim,A1,A2,A3,A4,...)
    %dimΪ1ʱ������������ƴ��
    %dimΪ2ʱ������������ƴ��
    %[A,B]��dim=3ʱ����Թ�����ά���飨���Ӧ����ʱ�ò��ţ�
    %--------------------------------------------------------------%
    %sort��A,dim��mode�����Ծ����Ԫ�ؽ�������
    %dim=1����������dim=2����������
    %modeȱʡΪ������Ҫ��������'descend'
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

       