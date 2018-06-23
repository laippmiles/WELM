function[TrainTimeaverage,TestAccuracy,TestGmean,RnAverage] = WELM(name,NumberofHiddenNeurons, ActivationFunction,C,Wtype,n)
    %C越大越偏向少数类
    % Usage: elm(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction)
    % OR:    [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm(TrainingData_File, TestingData_File, Elm_Type, NumberofHiddenNeurons, ActivationFunction)
    %
    % Input:
    % TrainingData_File     - Filename of training data set
    % TestingData_File      - Filename of testing data set
    % Elm_Type              - 0 for regression; 1 for (both binary and multi-classes) classification
    % NumberofHiddenNeurons - Number of hidden neurons assigned to the ELM
    % ActivationFunction    - Type of activation function:
    %                           'sig' for Sigmoidal function
    %                           'sin' for Sine function
    %                           'hardlim' for Hardlim function
    %                           'tribas' for Triangular basis function
    %                           'radbas' for Radial basis function (for additive type of SLFNs instead of RBF type of SLFNs)
    %C                      -正类常数 
    %
    % Output: 
    % TrainingTime          - Time (seconds) spent on training ELM
    % TestingTime           - Time (seconds) spent on predicting ALL testing data
    % TrainingAccuracy      - Training accuracy: 
    %                           RMSE for regression or correct classification rate for classification
    % TestingAccuracy       - Testing accuracy: 
    %                           RMSE for regression or correct classification rate for classification
    %
    % MULTI-CLASSE CLASSIFICATION: NUMBER OF OUTPUT NEURONS WILL BE AUTOMATICALLY SET EQUAL TO NUMBER OF CLASSES
    % FOR EXAMPLE, if there are 7 classes in all, there will have 7 output
    % neurons; neuron 5 has the highest output means input belongs to 5-th class
    %
    % Sample1 regression: [TrainingTime, TestingTime, TrainingAccuracy, TestingAccuracy] = elm('sinc_train', 'sinc_test', 0, 20, 'sig')
    % Sample2 classification: elm('diabetes_train', 'diabetes_test', 1, 20, 'sig')
    %
        %%%%    Authors:    MR QIN-YU ZHU AND DR GUANG-BIN HUANG
        %%%%    NANYANG TECHNOLOGICAL UNIVERSITY, SINGAPORE
        %%%%    EMAIL:      EGBHUANG@NTU.EDU.SG; GBHUANG@IEEE.ORG
        %%%%    WEBSITE:    http://www.ntu.edu.sg/eee/icis/cv/egbhuang.htm
        %%%%    DATE:       APRIL 2004
    %%%%%%%%%%% Macro definition
    %[~] = csvspilt_class(name,10);
    [TrainingAccuracy,TestingAccuracy,TrainingTimeaverage,TestingTimeaverage,TrainingGmean,TestingGmean] = init(n);
    TestingFM = zeros(n,1);
    RnAverage_train = [];
    RnAverage_test = [];
    for i=1:n
        TrainingData_File =[name,'-','train',num2str(i), '.csv'];
        TestingData_File = [name,'-','test',num2str(i), '.csv'];
        %train_data = load(TrainingData_File);
        Testdata = load(TestingData_File);
        [TVT, TVP, NumberofTestingData,~,number_classte] = Data(Testdata); 
        %%%%%处理数据%%%%%%%%%%    
        train_data = load(TrainingData_File);
        [T, P,NumberofTrainingData,NumberofInputNeurons, number_classtr,class_t] = Data(train_data);
        %[W] = GetWMatrix(T');
        if strcmp(Wtype,'W1')
            [W,~] = initDAndW_1(T,NumberofTrainingData,number_classtr,class_t);
        elseif strcmp(Wtype,'W2')
            [W,~] = initDAndW_2(T,NumberofTrainingData,number_classtr,class_t);
        end
        %%%%%%%%%%% Calculate weights & biases
        start_time_train=cputime;

        %%%%%%%%%%% Random generate input weights InputWeight (w_i) and biases BiasofHiddenNeurons (b_i) of hidden neurons
        InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
        %InputWeight元素范围为[-1,1]
        BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);
        %BiasofHiddenNeurons元素范围为[0,1]
        tempH=InputWeight*P;                                           %   Release input of training data 
        ind=ones(1,NumberofTrainingData);
        BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
        tempH=tempH+BiasMatrix;
        %%%%%%%%%%% Calculate hidden neuron output matrix H
        [H] = GetH(tempH,ActivationFunction,P,InputWeight,BiasofHiddenNeurons);
        clear tempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H
        %%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
        %OutputWeight=pinv(H') * T';                        
        % implementation without regularization factor //refer to 2006 Neurocomputing paper
        %OutputWeight=inv(eye(size(H,1))/C+H * H') * H * T';   % faster method 1 //refer to 2012 IEEE TSMC-B paper
        %OutputWeight= inv(eye(size(H'* W * H))/C+  H'* W * H) * H * W * T';   % faster method 1 //refer to 2013 IEEE TSMC-B paper
        %implementation; one can set regularizaiton factor C properly in classification applications 
        OutputWeight=pinv(eye(size(H * W*H'))/C+H * W*H')*H * W*T';   % faster method 2 //refer to 2012 IEEE TSMC-B paper
        %implementation; one can set regularizaiton factor C properly in classification applications

        %If you use faster methods or kernel method, PLEASE CITE in your paper properly: 

        %Guang-Bin Huang, Hongming Zhou, Xiaojian Ding, and Rui Zhang, "Extreme Learning Machine for Regression and Multi-Class Classification," submitted to IEEE Transactions on Pattern Analysis and Machine Intelligence, October 2010. 

        end_time_train=cputime;
        TrainingTimeaverage(i) = end_time_train-start_time_train;        %   Calculate CPU time (seconds) spent for training ELM

        %%%%%%%%%%% Calculate the training accuracy
        Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
        clear H;

        %%%%%%%%%%% Calculate the output of testing input
        start_time_test=cputime;
        tempH_test=InputWeight*TVP;
        %clear TVP;             %   Release input of testing data             
        ind=ones(1,NumberofTestingData);
        BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
        tempH_test=tempH_test + BiasMatrix;
        [H_test] = GetH(tempH_test,ActivationFunction,TVP,InputWeight,BiasofHiddenNeurons);    

        TY=(H_test' * OutputWeight)';                       %   TY: the actual output of the testing data
        end_time_test=cputime;
        TestingTimeaverage(i)=end_time_test-start_time_test; 
        [TrainingAccuracy(i)] = Accuracy(T', Y',NumberofTrainingData);
        [TestingAccuracy(i) ] = Accuracy(TVT', TY',NumberofTestingData);
        [TrainingGmean(i),~] = Gmean(T', Y',NumberofTrainingData,number_classtr,RnAverage_train);
        [TestingGmean(i),RnAverage_test] = Gmean(TVT', TY',NumberofTestingData,number_classte,RnAverage_test);
        %StrTraining =[num2str(i),'0%'];
        %disp(StrTraining);
    end
    [TrainTimeaverage,TestAccuracy,TestGmean] = Dispresult(TrainingAccuracy,TestingAccuracy,TrainingTimeaverage,TestingTimeaverage,TrainingGmean,TestingGmean,n);
    RnAverage = zeros(number_classte,1);
    for i = 1:n
        RnAverage = RnAverage + RnAverage_test(:,i);
    end
    RnAverage = RnAverage / n ;
    for i = 1:number_classte
        disp(['R',num2str(i),'= ',num2str(RnAverage(i))]);
    end
    %movecsv(name,n)
end