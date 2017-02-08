%% ********** HW4.1 ********** %

clear all;
close all;

% *** 1(a) *** %
idata= imread('birds.jpg');
figure();
imshow(idata);

% *** 1(b) *** %
msize= size(idata);
vecRGB= reshape(idata, msize(1)*msize(2), msize(3));
vecRGB= double(vecRGB);

% *** 1(c)(d) *** %
[tmed, cmed] = kmeans(vecRGB,5); % 3 or 5 clusters
gvec= [];
for i= 1:size(tmed)
    switch(tmed(i))
        case 1
            gvec(end+1,:)= cmed(1,:);
        case 2
            gvec(end+1,:)= cmed(2,:);
        case 3
            gvec(end+1,:)= cmed(3,:);
        case 4
            gvec(end+1,:)= cmed(4,:);
        case 5
            gvec(end+1,:)= cmed(5,:);
        otherwise
            disp('error: unknown type', tmed(i));
            exit();
    end
end
image_transed= reshape(gvec,msize(1),msize(2),msize(3));
image_transed= uint8(image_transed);
figure();
imshow(image_transed);

%% ********** HW4.2 ********** %

clear all;
close all;

% *** 2(a) *** %
x = linspace(0,10,100);
r = [];
for i= 1:size(x(:))
    r(end+1)= (1-exp(-0.7*x(i)))*exp(-0.3*x(i));
end
figure();
plot(x, r);

% *** 2(b) *** %
u1= rand(1, 300);
x1= 10*u1.^2; % training data
u2= rand(1, 300);
x2= 10*u2.^2; % testing data
r1= [];
r2= [];
for i= 1:size(x1(:))
    r1(end+1)= (1-exp(-0.7*x1(i)))*exp(-0.3*x1(i));
    r2(end+1)= (1-exp(-0.7*x2(i)))*exp(-0.3*x2(i));
end
figure;
plot(x1, r1, '.');

% *** 2(c)(d) *** %
figure;
plot(x2, r2, '.', 'MarkerSize', 20); hold on;
h_store= [];
rss= [];
p= [];
for h= [0.1 0.3 0.6 1.0 1.3 1.6 2.0] 
    h_store(end+1)= h;
    rss(end+1)= 0;
    f= [];
    for i= 1:300
        sumk= 0;
        sumrk= 0;
        for j= 1:300
            k= exp(-(x2(i)-x1(j))^2/h/h/2);
            sumk = sumk + k;
            sumrk= sumrk+ r1(j)*k;
        end
        f(end+1)= sumrk/sumk;
        rss(end)= rss(end) + (f(i)-r2(i))^2;
    end
    plot(x2, f, '.', 'MarkerSize', 10); hold on;
end
legend('ri', 'h= 0.1', 'h= 0.3', 'h= 0.6', 'h= 1.0', 'h= 1.3', 'h= 1.6', 'h= 2.0');

figure;
plot (h_store, rss, '-o');
xlabel('h value');
ylabel('RSS');

% *** 2(e) *** %
figure;
plot(x2, r2, '.', 'MarkerSize', 20); hold on;
for kin= 1:7
    f= [];
    for i= 1:300
        sumk= 0;
        sumrk= 0;
        [id, d]= knnsearch(x1(:), x2(i), 'k', 7);
        disp(d)
        for j= 1:300
            k= exp(-(x2(i)-x1(j))^2/d(kin)/d(kin)/2);
            sumk = sumk + k;
            sumrk= sumrk+ r1(j)*k;
        end
        f(end+1)= sumrk/sumk;
        rss(end)= rss(end) + (f(i)-r2(i))^2;
    end
    plot(x2, f, '.', 'MarkerSize', 10); hold on;
end
legend('ri', 'k= 1', 'k= 2', 'k= 3', 'k= 4', 'k= 5', 'k= 6', 'k= 7');
 