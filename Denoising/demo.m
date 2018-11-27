%This code is provided for non-comercial use, corrosponding to the following paper
%"Image Restoration Using Gaussian Mixture Models With Spatially Constrained Patch Clustering" 
%Milad Niknejad, Hossein Rabbani, Massoud Babaie-Zadeh, IEEE Transactions on Image Processing, Vol 24 ,  No. 11, PP. 3624 - 3636 Nov. 2015

%The values of some constant parameters has changed in this version of our code to have an overall better performance.

clc;
clear;
ju=1;
refju=6; %jump size for reference patches
mxco=.00005;
N=30; %size of clustering window
im=imread('images/house.png');
sigma=20; %noise standard deviation
im=im2double(im);
im=im*255;
imn=im+sigma*randn(size(im));
figure(1);
imshow(imn,[]);
s=10;
mnc=40;%number of cluster dimention
nmiter=20; %number of iterations of EM-like
%agrregation weights coeficients
if sigma<40
    agcoe=.00006;
else
    agcoe=.000001;
end

iterres=zeros(20,1);
imn1=imn;
sigma1=sigma;
for iter=1:nmiter
if mod(iter,3)==0
    refju=5;
elseif mod(iter,3)==1
    refju=6;
else
    refju=5;
end
[imfi]=main(ju,refju,N,imn1,s,mnc,iter,sigma,imn,agcoe);

imn1=imfi;
itpsnr=10*log10(255*255/mean(mean((im-imfi).^2)));
iterres(iter,1)=itpsnr;
end


figure(2);
imshow(imfi,[]);
ISNR=10*log10((mean(mean((im-imn).^2))/mean(mean((imfi-im).^2))))
PSNR1=10*log10(255*255/mean(mean((im-imn).^2)))
PSNR2=10*log10(255*255/mean(mean((im-imfi).^2)))
ssim=ssim_index(im,imfi)