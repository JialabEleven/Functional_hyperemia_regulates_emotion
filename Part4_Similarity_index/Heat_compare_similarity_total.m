clear all;
clc;
image1 = '002.tiff'; %path of picture
image2 = '003.tiff'; %path of picture
image3 = '004.tiff'; %path of picture
image4 = '005.tiff'; %path of picture
image5 = '006.tiff'; %path of picture
image6 = '007.tiff'; %path of picture
image7 = '008.tiff'; %path of picture
image8 = '009.tiff'; %path of picture
image9 = '010.tiff'; %path of picture
image10 = '011.tiff'; %path of picture
image11 = '012.tiff'; %path of picture
image12 = '013.tiff'; %path of picture
image13 = '014.tiff'; %path of picture
image14 = '015.tiff'; %path of picture
image15 = '016.tiff'; %path of picture
image16 = '017.tiff'; %path of picture
image17 = '018.tiff'; %path of picture
image18 = '019.tiff'; %path of picture
imgData1 = imread(image1);
img_deal(:,:,1)=rgb2gray(imgData1(:,:,1:3));
imgData2 = imread(image2);
img_deal(:,:,2)=rgb2gray(imgData2(:,:,1:3));
imgData3 = imread(image3);
img_deal(:,:,3)=rgb2gray(imgData3(:,:,1:3));
imgData4 = imread(image4);
img_deal(:,:,4)=rgb2gray(imgData4(:,:,1:3));
imgData5 = imread(image5);
img_deal(:,:,5)=rgb2gray(imgData5(:,:,1:3));
imgData6 = imread(image6);
img_deal(:,:,6)=rgb2gray(imgData6(:,:,1:3));
imgData7 = imread(image7);
img_deal(:,:,7)=rgb2gray(imgData7(:,:,1:3));
imgData8 = imread(image8);
img_deal(:,:,8)=rgb2gray(imgData8(:,:,1:3));
imgData9 = imread(image9);
img_deal(:,:,9)=rgb2gray(imgData9(:,:,1:3));
imgData10 = imread(image10);
img_deal(:,:,10)=rgb2gray(imgData10(:,:,1:3));
imgData11 = imread(image11);
img_deal(:,:,11)=rgb2gray(imgData11(:,:,1:3));
imgData12 = imread(image12);
img_deal(:,:,12)=rgb2gray(imgData12(:,:,1:3));
imgData13 = imread(image13);
img_deal(:,:,13)=rgb2gray(imgData13(:,:,1:3));
imgData14 = imread(image14);
img_deal(:,:,14)=rgb2gray(imgData14(:,:,1:3));
imgData15 = imread(image15);
img_deal(:,:,15)=rgb2gray(imgData15(:,:,1:3));
imgData16 = imread(image16);
img_deal(:,:,16)=rgb2gray(imgData16(:,:,1:3));
imgData17 = imread(image17);
img_deal(:,:,17)=rgb2gray(imgData17(:,:,1:3));
imgData18 = imread(image18);
img_deal(:,:,18)=rgb2gray(imgData18(:,:,1:3));

blurSig1 = 6;
blurSig2 = 12;
for i=1:18
    revise_img(:,:,i)=255-img_deal(:,:,i);
    revise_img1(:,:,i)=im2double(revise_img(:,:,i));
    revise_img2(:,:,i)=mapminmax(revise_img1(:,:,i),0,1);
    revise_img_final(:,:,i)=revise_img2(225:870,735:1155,i);
    heatFieldBlur0(:,:,i) = imgaussfilt(revise_img_final(:,:,i),blurSig1);
    heatFieldBlur1(:,:,i) = imgaussfilt(heatFieldBlur0(:,:,i),blurSig2);
end

for m=1:18
    for n=1:18
        ssim_index(m,n)=ssim(heatFieldBlur1(:,:,m),heatFieldBlur1(:,:,n));
        correlation_index(m,n)=corr2(heatFieldBlur1(:,:,m),heatFieldBlur1(:,:,n));
    end
end
