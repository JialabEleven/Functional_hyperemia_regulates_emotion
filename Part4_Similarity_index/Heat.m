clear all;
clc;


filename = '015.tiff'; %path of picture
imgData0 = imread(filename);
imgData1=imgData0(171:938,431:1454,1:3);
%imgData1=imgData0(225:870,735:1155,1:3); %007
img_deal=rgb2gray(imgData1);
% img_deal(img_deal<150)=0;

 figure(),imshow(img_deal);
 img_deal1=255-img_deal;
 figure(),imshow(img_deal1);
 img_deal2=im2double(img_deal1);
 img_deal3=mapminmax(img_deal2,0,1);


% colormap("autumn")
% colorbar;
% figure(),imshow(img_deal1)
% colormap("autumn")
% colorbar;

% load('mousePos-timeStep6.mat');
blurSig1 = 6;
heatFieldBlur = imgaussfilt(img_deal3,blurSig1);
%figure(); imagesc(heatFieldBlur); 
axis off 
blurSig2 = 12;
heatFieldBlur1 = imgaussfilt(heatFieldBlur,blurSig2);
figure(); imagesc(heatFieldBlur1); 
% load('colorbar_data.mat', 'savedColorbar');
% caxis(savedColorbar.Limits);
% colormap(savedColorbar.Colormap);
% colorbar 


axis off 
colormap jet
colorbar 
set(gca,'CLim',[0,0.25]);%固定colorbar以用于比较