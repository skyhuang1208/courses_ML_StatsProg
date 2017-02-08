clear all;
close all;

% ********** HW2.1 ********** %

% *** 1(a) *** %
data1= load('Doctor1data.txt');
data2= load('Doctor2data.txt');
%disp(data(:,1));

% *** 1(b) *** %
figure;
hist3(data1, [10 10], 'FaceAlpha', .65);
xlabel('weight (pounds)');
ylabel('height (inches)');

% *** 1(c) *** %
avg1w= mean(data1(:,1)); cov1w= cov(data1(:,1));
avg1h= mean(data1(:,2)); cov1h= cov(data1(:,2));
disp('Doctor 1.');
fprintf('weight: %f +/- %f (pounds).\n', avg1w, cov1w);
fprintf('height: %f +/- %f (inches).\n', avg1h, cov1h);

nx= 50; % define the mesh N
x= avg1w-cov1w:2*cov1w/nx:avg1w+cov1w; % in 1 sigma range
y= avg1h-cov1h:2*cov1h/nx:avg1h+cov1h;
[gx, gy]= meshgrid(x, y);

normp= mvnpdf([gx(:) gy(:)], [avg1w avg1h], [cov1w cov1h]);
normp= reshape(normp, length(y), length(x));
figure;
surf(x, y, normp);
xlabel('weight (pounds)');
ylabel('height (inches)');
zlabel('probability density');

%%% combine 1(b) and 1(c)
% 1(c) has to multiplied by N of data points (1000) to compare with 1(b)
% 1(b) is an integral in the range (lx/10, ly/10), can't be compared
% directly, but here I make a rough comparison by multiplying normp by 8
figure;
hist3(data1, [10 10]);
hold on;
surf(x, y, normp*1000*8);
xlabel('weight (pounds)');
ylabel('height (inches)');

% *** 1(d) *** %
% histogram
figure;
hist3(data2, [50 50], 'FaceAlpha', .65); % using Nbin= 50
xlabel('weight (pounds)');
ylabel('height (inches)');

% cal mean and cov
avg2w= mean(data2(:,1)); cov2w= cov(data2(:,1));
avg2h= mean(data2(:,2)); cov2h= cov(data2(:,2));
disp('Doctor 2.');
fprintf('weight: %f +/- %f (pounds).\n', avg2w, cov2w);
fprintf('height: %f +/- %f (inches).\n', avg2h, cov2h);

% plot gaussian
nx2= 100; % define the mesh N
x2= avg2w-cov2w:2*cov2w/nx2:avg2w+cov2w; % in 1 sigma range
y2= avg2h-cov2h:2*cov2h/nx2:avg2h+cov2h;
[gx2, gy2]= meshgrid(x2, y2);

normp2= mvnpdf([gx2(:) gy2(:)], [avg2w avg2h], [cov2w cov2h]);
normp2= reshape(normp2, length(y2), length(x2));
figure;
surf(x2, y2, normp2);
xlabel('weight (pounds)');
ylabel('height (inches)');
zlabel('probability density');

% compare them
figure;
hist3(data2, [50 50]);
hold on;
surf(x2, y2, normp2*100000);
xlabel('weight (pounds)');
ylabel('height (inches)');
axis([-100 200 -40 80]);

% ********** HW2.2 ********** %

% *** 2(a) *** %
hdata= textread('housePrM.txt', '', 'headerlines', 1); % house data
figure;
plot(hdata(:,3), hdata(:,2), '.', 'MarkerSize', 25);

% *** 2(b) *** %
% !!! ps. fit func here cant use in versions of matlab !!!
% !!! here I used 2014b and it works fine !!!
fit_h= fit(hdata(:,3), hdata(:,2), 'poly1');
disp(fit_h);
hold on;
plot(fit_h);
xlabel('size(ft^2)');
ylabel('price');

fprintf('Predicted price for a 20-ft house: %f\n', fit_h(20));

% *** 2(d) *** %
ccoef= corrcoef(hdata(:,3), hdata(:,2));
fprintf('Corr coeff: %f\n', ccoef(1, 2));

% ********** HW2.3 ********** %

% *** 3(a) *** %
edis0= makedist('Exponential', 1);
edis1= makedist('Exponential', 10);
r0= random(edis0, [1, 1000]);
r1= random(edis1, [1, 1000]);
rdata= [r0 r1];
figure;
hist(rdata, 20);
N_err0= 0;
N_err1= 0;
for i=1:500
    if(r0(i)>2.558)
        N_err0= N_err0 +1;
    end
    if(r1(i)<2.558)
        N_err1= N_err1 +1;
    end
end
fprintf('mis-detection: %f\n', N_err1/(500-N_err0+N_err1));
fprintf('False alert: %f\n', N_err0/(500-N_err1+N_err0));
fprintf('Total error rate: %f\n', (N_err1+N_err0)/1000);