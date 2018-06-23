function[TrainingAccuracy,TestingAccuracy,TrainingTimeaverage,TestingTimeaverage,TrainingGmean,TestingGmean] =  init(n)
TrainingAccuracy = zeros(1,n);
TestingAccuracy = zeros(1,n);
TrainingTimeaverage = zeros(1,n);
TestingTimeaverage = zeros(1,n);
TrainingGmean = zeros(1,n);
TestingGmean = zeros(1,n);