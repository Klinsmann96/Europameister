%%Computational Economics%%
%%%%%%Winter 2015/16%%%%%%%

%%%%%%%Problem Set 2%%%%%%%

clc
close all
clear all

%%
%%Problem 3%%
%%
%%Problem 3 (1)

data = xlsread('MRW92QJE-data.xls');
data = data(:,[1 3:end]);

missing = isnan(data);
missing_sum = sum(missing,2);

I=size(missing_sum);

data_new=[];
for i=1:I(1,1)
if missing_sum(i,1) == 0
data_new=[data_new; data(i,:)];
end
end

%%
%%Problem 3 (2)

NonOil=[];
Intermediate=[];
OECD=[];
I=size(data_new);
for i=1:I(1,1)
if data_new(i,2)== 1
NonOil=[NonOil; data_new(i,:)];
end
if data_new(i,3)== 1
Intermediate=[Intermediate; data_new(i,:)];
end
if data_new(i,4)== 1
OECD=[OECD; data_new(i,:)];
end
end

%%
%%Problem 3 (3)

% add: g+delta=0.05
I=size(NonOil);
for i=1:I
NonOil(i,8)=NonOil(i,8)+5;
end;
I=size(Intermediate);
for i=1:I
Intermediate(i,8)=Intermediate(i,8)+5;
end;
I=size(OECD);
for i=1:I
OECD(i,8)=OECD(i,8)+5;
end;

%Log Subsamples
NonOil(:,[5 6 8 9 10])=log(NonOil(:,[5 6 8 9 10]));
Intermediate(:,[5 6 8 9 10])=log(Intermediate(:,[5 6 8 9 10]));
OECD(:,[5 6 8 9 10])=log(OECD(:,[5 6 8 9 10]));

cons_NonOil = ones(size(NonOil,1),1); 
cons_Intermediate = ones(size(Intermediate,1),1);
cons_OECD = ones(size(OECD,1),1);

X_NonOil = [cons_NonOil NonOil(:,[5,9,8,10])]; 
X_Intermediate = [cons_Intermediate Intermediate(:,[5,9,8,10])];
X_OECD = [cons_OECD OECD(:,[5,9,8,10])];

y_NonOil = NonOil(:,6)-NonOil(:,5);
y_Intermediate = Intermediate(:,6)- Intermediate(:,5);
y_OECD = OECD(:,6)-OECD(:,5);

%Regress
beta_NonOil=X_NonOil\y_NonOil; 
beta_Intermediate=X_Intermediate\y_Intermediate;
beta_OECD=X_OECD\y_OECD;

% Standard Errors
uhead_NonOil=y_NonOil-X_NonOil*beta_NonOil;
uhead_Intermediate=y_Intermediate-X_Intermediate*beta_Intermediate;
uhead_OECD=y_OECD-X_OECD*beta_OECD;

sigma2_NonOil=1/(size(NonOil,1)-4)*(uhead_NonOil'*uhead_NonOil);
sigma2_Intermediate=1/(size(Intermediate,1)-4)*(uhead_Intermediate'*uhead_Intermediate);
sigma2_OECD=1/(size(OECD,1)-4)*(uhead_OECD'*uhead_OECD);

SE_NonOil=sigma2_NonOil*inv(X_NonOil'*X_NonOil);
SE_Intermediate=sigma2_Intermediate*inv(X_Intermediate'*X_Intermediate);
SE_OECD=sigma2_OECD*inv(X_OECD'*X_OECD);

SE_NonOil=sqrt(diag(SE_NonOil));
SE_Intermediate=sqrt(diag(SE_Intermediate));
SE_OECD=sqrt(diag(SE_OECD));
