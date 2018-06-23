function[TrTime,TeAcc,TeGmean] = Dispresult(TrainingAccuracy,TestingAccuracy,TrainingTimeaverage,TestingTimeaverage,TrainingGmean,TestingGmean,n)
sum1 = 0;sum2 = 0;sum3 = 0;sum4 = 0;sumn = 0;sum6 = 0;
for i=1:n

    sum1 = sum1 + TrainingAccuracy(i);
    sum2 = sum2 + TestingAccuracy(i);
    sum3 = sum3 + TrainingTimeaverage(i);
    sum4 = sum4 + TestingTimeaverage(i);
    sumn = sumn + TrainingGmean(i);
    sum6 = sum6 + TestingGmean(i);
end
TrTime = sum3/n;
TeAcc = sum2/n;
TeGmean = sum6/n;
StrTrainingTime =['***************TrainingTime = ',num2str(sum3/n),'***********************'];
disp(StrTrainingTime);
StrTrainingTime =['***************TestingTime = ',num2str(sum4/n),'***********************'];
disp(StrTrainingTime);
StrTrainingAccuracy =['***************TrainingAccuracy = ',num2str(sum1/n),'***********************'];
disp(StrTrainingAccuracy);
StrTestingAccuracy =['***************TestingAccuracy = ',num2str(sum2/n),'***********************'];
disp(StrTestingAccuracy);
StrTrainingGmean =['***************TrainingGmean = ',num2str(sumn/n),'***********************'];
disp(StrTrainingGmean);
StrTestingGmean =['***************TestingGmean = ',num2str(sum6/n),'***********************'];
disp(StrTestingGmean);