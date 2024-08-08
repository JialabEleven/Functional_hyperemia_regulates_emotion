clear all;
clc;
filename = 'experiment.tif'; %path of picture
savepath = 'deal_data/';
imgData1 = imread(filename);
img1=imgData1(:,:,1);
img2=imgData1(:,:,2);
img3=imgData1(:,:,3);
img_deal=rgb2gray(imgData1);

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
blurSig = 6;
heatFieldBlur = imgaussfilt(img_deal3,blurSig);
figure(); 
imshow(heatFieldBlur,'border','tight');
axis off; 
colormap jet; 
saveas(gcf,[savepath,'experiment_revise.tif']);
% colorbar 
% set(gca,'CLim',[0,1]);%固定colorbar以用于比较