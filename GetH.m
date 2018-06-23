function [H] = GetH(tempH,ActivationFunction,P,InputWeight,BiasofHiddenNeurons)
    switch lower(ActivationFunction)
            case {'sig','sigmoid'}
                %%%%%%%% Sigmoid 
                H = 1 ./ (1 + exp(-tempH));
            case {'sin','sine'}
                %%%%%%%% Sine
                H = sin(tempH); 
            case {'hardlim'}
                %%%%%%%% Hard Limit
                H = double(hardlim(tempH));
            case {'tribas'}
                %%%%%%%% Triangular basis function
                H = tribas(tempH);
            case {'radbas'}
                %%%%%%%% Radial basis function
                H = radbas(tempH);
                %%%%%%%% More activation functions can be added here   
            case{'rbf'}
                H= RBFun(P',InputWeight,BiasofHiddenNeurons');
                H = H';
    end 