% ********** HW1 #5 **********%
clear all;
close all;

%%% parameters %%%
q= 0.3; % probability
p_y0= 1-q;
p_t1= q;
sigma= 0.25; % gaussian 
miu0= 0; 
miu1= 1;

%%% 5(a)
disp('solving ML...');
count= 0;
for i = -4999:5000
    count= count +1;
    x_= i*0.002;
    x(count)= x_;
    if normpdf(x_, miu0, sigma) > normpdf(x_, miu1, sigma)
        y_hat(count)= 0;
    else
        y_hat(count)= 1;
    end
end
figure();
plot(x, y_hat);
xlabel('x');
ylabel('$\hat{y}$', 'interpreter', 'latex');
ylim([-0.1,1.1]);
title('ML');

%%% 5(b)
norm0= normpdf(x, miu0, sigma);
norm1= normpdf(x, miu1, sigma) ;
figure();
plot(x, norm0,'r', x, norm1,'b', 'linewidth', 2);
title('normal distribution');
legend('y0','y1');

%%% 5(c)
cdf0= cdf('Normal', x, miu0, sigma);
cdf1= cdf('Normal', x, miu1, sigma);
figure();
plot(x, cdf0,'r', x, cdf1,'b', 'linewidth', 2);
title('cdf of normal distribution');
legend('y0','y1');

%%% 5(d)
p_md= 0;
p_fa= 0;
for j= 1:10000
    if y_hat(j)== 1
        p_md= p_md + norm0(j)*0.002;
    else
        p_fa= p_fa + norm1(j)*0.002;
    end
end
fprintf('probability of misdetection: %f.\n', p_md);
fprintf('probability of false alert:  %f.\n', p_fa);

