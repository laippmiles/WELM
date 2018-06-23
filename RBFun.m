function H = RBFun(P,IW,Bias)

%%%%%%%% RBF network using Gaussian kernel
ind=ones(size(P,1),1);
size(Bias)
for i=1:size(IW,1)
    Weight=IW(i,:);         
    WeightMatrix=Weight(ind,:);
    V(:,i)=-sum((P-WeightMatrix).^2,2);    %RBF����  
    %������X�����е�˳�����
end
BiasMatrix=Bias(ind,:);
V=V.*BiasMatrix;
H=exp(V);