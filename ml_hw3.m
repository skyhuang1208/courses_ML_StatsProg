%% ********** HW3.2 ********** %

clear all;
close all;

dpoints= [0.0; 0.1; 0.29; 0.3; 0.4; 
          0.5; 0.6; 0.7; 0.8; 0.9; 1.0; 
          1.1; 1.2; 1.21; 1.4; 1.5];
[tmed, cmed]= kmedoids(dpoints ,3);
[tmn, cmn]= kmeans(dpoints ,3);
gmed1=[]; gmed2=[]; gmed3=[];
gmn1= []; gmn2= []; gmn3= [];
for i= 1:size(tmed)
    switch (tmed(i))
        case 1
            gmed1(end+1)= dpoints(i);
        case 2
            gmed2(end+1)= dpoints(i);
        case 3
            gmed3(end+1)= dpoints(i);
        otherwise
            disp('error: unknown type', tmed(i));
            exit();
    end
    
    switch (tmn(i))
        case 1
            gmn1(end+1)= dpoints(i);
        case 2
            gmn2(end+1)= dpoints(i);
        case 3
            gmn3(end+1)= dpoints(i);
        otherwise
            disp('error: unknown type', tmed(i));
            exit();
    end
end
figure();
p1= plot(gmed1, '.', 'Color', 'red', 'MarkerSize', 20); hold on;
plot(gmed2, '.', 'Color', 'green', 'MarkerSize', 20); hold on;
plot(gmed3, '.', 'Color', 'blue', 'MarkerSize', 20); hold on;
p2= plot(gmn1,  'X', 'Color', 'red', 'MarkerSize', 10); hold on;
plot(gmn2,  'X', 'Color', 'green', 'MarkerSize', 10); hold on;
plot(gmn3,  'X', 'Color', 'blue', 'MarkerSize', 10);
legend([p1, p2], 'k-medoids', 'k-means');

%% ********** HW3.5 & 3.6 ********** %

clear all;
close all;

% *** 5(a) *** %
data1 = xlsread('simple2.xlsx'); % simple1 for 3.5; simple2 for 3.6
figure();
plot(data1(:,1), data1(:,2), '.', 'MarkerSize', 20);

% *** 5(b) *** %
[clter, centr] = kmeans(data1,3);
gmed1= [];
gmed2= [];
group3= [];
for i= 1:size(clter)
    switch (clter(i))
        case 1
            gmed1(end+1,:)= data1(i,:);
        case 2
            gmed2(end+1,:)= data1(i,:);
        case 3
            group3(end+1,:)= data1(i,:);
        otherwise
            disp('error: unknown type', clter(i));
            exit();
    end
end
figure();
plot(centr(1,1), centr(1,2), '*', 'Color', 'black', 'MarkerSize', 10); hold on;
plot(gmed1(:,1), gmed1(:,2), '.', 'Color', 'red', 'MarkerSize', 10); hold on;
plot(centr(2,1), centr(2,2), '*', 'Color', 'black', 'MarkerSize', 10); hold on;
plot(gmed2(:,1), gmed2(:,2), '.', 'Color', 'green', 'MarkerSize', 10); hold on;
plot(centr(3,1), centr(3,2), '*', 'Color', 'black', 'MarkerSize', 10); hold on;
plot(group3(:,1), group3(:,2), '.', 'Color', 'blue', 'MarkerSize', 10); hold on;

% *** 5(c) *** %
em= cluster(fitgmdist(data1,3), data1);
emg1= [];
emg2= [];
emg3= [];
for i= 1:size(em)
    switch (em(i))
        case 1
            emg1(end+1,:)= data1(i,:);
        case 2
            emg2(end+1,:)= data1(i,:);
        case 3
            emg3(end+1,:)= data1(i,:);
    end
end
figure();
plot(emg1(:,1), emg1(:,2), '.', 'Color', 'red', 'MarkerSize', 10); hold on;
plot(emg2(:,1), emg2(:,2), '.', 'Color', 'green', 'MarkerSize', 10); hold on;
plot(emg3(:,1), emg3(:,2), '.', 'Color', 'blue', 'MarkerSize', 10); hold on;

%% ********** HW3.7 ********** %

clear all;
close all;

% *** 7(a) *** %
[data,label]= xlsread('./Data_Cortex_Nuclear_editted.xls');
%m= mean(data, 'omitnan');
dclass= zeros(1,size(data,1));
m= nanmean(data);
for i= 1:size(data,1)
    for j= 1:size(data,2)
        if isnan(data(i,j)); data(i,j)= m(j); end
        
    end
end

% *** 7(b)(c) *** %
s= std(data);
data_nor= zeros(size(data));
for j= 1:size(data,2)
    data_nor(:,j)= (data(:,j)-m(j))/s(j);
end
[coeff, score, latent, tsquared, explained] = pca(data_nor);
disp(explained(1)+explained(2));
PoV= cumsum(explained);

figure();
plot(PoV, '--.', 'MarkerSize', 20);
ylim([0 100]);

sing1= []; sing2= []; sing3= []; sing4= []; % score in groups
sing5= []; sing6= []; sing7= []; sing8= [];
for i= 1:size(data,1)
    switch char(label(i,82))
        case 'c-CS-s'; sing1(end+1,:)= [i score(i,1) score(i,2)];
        case 'c-CS-m'; sing2(end+1,:)= [i score(i,1) score(i,2)];
        case 'c-SC-s'; sing3(end+1,:)= [i score(i,1) score(i,2)];
        case 'c-SC-m'; sing4(end+1,:)= [i score(i,1) score(i,2)];
        case 't-CS-s'; sing5(end+1,:)= [i score(i,1) score(i,2)];
        case 't-CS-m'; sing6(end+1,:)= [i score(i,1) score(i,2)];
        case 't-SC-s'; sing7(end+1,:)= [i score(i,1) score(i,2)];
        case 't-SC-m'; sing8(end+1,:)= [i score(i,1) score(i,2)];
        otherwise
                fprintf('error 7.a: cannot find class, %f', label(i,82));
                exit();
    end
end
figure();
plot(sing1(:,2), sing1(:,3), '.', 'MarkerSize', 20, 'color', 'r'); hold on;
plot(sing2(:,2), sing2(:,3), '.', 'MarkerSize', 20, 'color', 'm'); hold on;
plot(sing3(:,2), sing3(:,3), '.', 'MarkerSize', 20, 'color', 'y'); hold on;
plot(sing4(:,2), sing4(:,3), '.', 'MarkerSize', 20, 'color', 'g'); hold on;
plot(sing5(:,2), sing5(:,3), '.', 'MarkerSize', 20, 'color', 'c'); hold on;
plot(sing6(:,2), sing6(:,3), '.', 'MarkerSize', 20, 'color', 'b'); hold on;
plot(sing7(:,2), sing7(:,3), '.', 'MarkerSize', 20, 'color', 'k'); hold on;
plot(sing8(:,2), sing8(:,3), '.', 'MarkerSize', 20, 'color', [0.5 0.5 0.5]); hold on;
legend('c-CS-s', 'c-CS-m', 'c-SC-s', 'c-SC-m', 't-CS-s', 't-CS-m', 't-SC-s', 't-SC-m');

% *** 7(d) *** %
mc(1,:) = mean(data_nor(sing1(:,1),:));
mc(2,:) = mean(data_nor(sing2(:,1),:));
mc(3,:) = mean(data_nor(sing3(:,1),:));
mc(4,:) = mean(data_nor(sing4(:,1),:));
mc(5,:) = mean(data_nor(sing5(:,1),:));
mc(6,:) = mean(data_nor(sing6(:,1),:));
mc(7,:) = mean(data_nor(sing7(:,1),:));
mc(8,:) = mean(data_nor(sing8(:,1),:));
sc(1)= size(sing1,1);
sc(2)= size(sing2,1);
sc(3)= size(sing3,1);
sc(4)= size(sing4,1);
sc(5)= size(sing5,1);
sc(6)= size(sing6,1);
sc(7)= size(sing7,1);
sc(8)= size(sing8,1);
mtotal= mean(data_nor);

sb= zeros(size(data,2));
for i= 1:8
    sb= sb + sc(i) * (mc(i,:)-mtotal).' * (mc(i,:)-mtotal);
end

sw= zeros(size(data,2));
for i= 1:sc(1)
    sw= sw + (data_nor(sing1(i,1),:)-mc(1,:)).' * (data_nor(sing1(i,1),:)-mc(1,:));
end
for i= 1:sc(2)
    sw= sw + (data_nor(sing2(i,1),:)-mc(2,:)).' * (data_nor(sing2(i,1),:)-mc(2,:));
end
for i= 1:sc(3)
    sw= sw + (data_nor(sing3(i,1),:)-mc(3,:)).' * (data_nor(sing3(i,1),:)-mc(3,:));
end
for i= 1:sc(4)
    sw= sw + (data_nor(sing4(i,1),:)-mc(4,:)).' * (data_nor(sing4(i,1),:)-mc(4,:));
end
for i= 1:sc(5)
    sw= sw + (data_nor(sing5(i,1),:)-mc(5,:)).' * (data_nor(sing5(i,1),:)-mc(5,:));
end
for i= 1:sc(6)
    sw= sw + (data_nor(sing6(i,1),:)-mc(6,:)).' * (data_nor(sing6(i,1),:)-mc(6,:));
end
for i= 1:sc(7)
    sw= sw + (data_nor(sing7(i,1),:)-mc(7,:)).' * (data_nor(sing7(i,1),:)-mc(7,:));
end
for i= 1:sc(8)
    sw= sw + (data_nor(sing8(i,1),:)-mc(8,:)).' * (data_nor(sing8(i,1),:)-mc(8,:));
end

% *** 7(e) *** %
vLDA = inv(sw+1e-6/77*trace(sw))*sb;
[EigVector, EigValue] = eig(vLDA);
EigValue = sum(real(EigValue));

EValue_sorted= sort(EigValue);
max1= EValue_sorted(77);
max2= EValue_sorted(76);
imax1= find(EigValue == max1); 
imax2= find(EigValue == max2);
imax= [imax1 imax2];

lda= data_nor*EigVector(:,imax);
figure();
plot(lda(sing1(:,1),1), lda(sing1(:,1),2), '.', 'MarkerSize', 20, 'color', 'r'); hold on;
plot(lda(sing2(:,1),1), lda(sing2(:,1),2), '.', 'MarkerSize', 20, 'color', 'm'); hold on;
plot(lda(sing3(:,1),1), lda(sing3(:,1),2), '.', 'MarkerSize', 20, 'color', 'y'); hold on;
plot(lda(sing4(:,1),1), lda(sing4(:,1),2), '.', 'MarkerSize', 20, 'color', 'g'); hold on;
plot(lda(sing5(:,1),1), lda(sing5(:,1),2), '.', 'MarkerSize', 20, 'color', 'c'); hold on;
plot(lda(sing6(:,1),1), lda(sing6(:,1),2), '.', 'MarkerSize', 20, 'color', 'b'); hold on;
plot(lda(sing7(:,1),1), lda(sing7(:,1),2), '.', 'MarkerSize', 20, 'color', 'k'); hold on;
plot(lda(sing8(:,1),1), lda(sing8(:,1),2), '.', 'MarkerSize', 20, 'color', [0.5 0.5 0.5]); hold on;
legend('c-CS-s', 'c-CS-m', 'c-SC-s', 'c-SC-m', 't-CS-s', 't-CS-m', 't-SC-s', 't-SC-m');

% *** 7(f) *** %
figure();
plot(vLDA(1,:), '.', 'MarkerSize', 20, 'Color', 'r'); hold on;
plot(vLDA(2,:), '.', 'MarkerSize', 20, 'Color', 'b');
legend('LDA Vector 1', 'LDA Vector 2');
%% ********** HW3.8 ********** %

clear all;
close all;

% *** 8(a) *** %
idata= imread('birds.jpg');
figure();
imshow(idata);

% *** 8(b) *** %
msize= size(idata);
vecRGB= reshape(idata, msize(1)*msize(2), msize(3));
vecRGB= double(vecRGB);

% *** 8(c)(d) *** %
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