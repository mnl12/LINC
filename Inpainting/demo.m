%This code is provided for non-comercial use, corrosponding to the following paper
%"Image Restoration Using Gaussian Mixture Models With Spatially Constrained Patch Clustering" 
%Milad Niknejad, Hossein Rabbani, Massoud Babaie-Zadeh, IEEE Transactions on Image Processing,  Vol 24 ,  No. 11, PP. 3624 - 3636 Nov. 2015

%The values of some constant parameters has changed in this version of our code to have an overall better performance.

clc;
clear;
ju=1;
refju=6;
sigma=100;
N=26; %size of clustering window
im=imread('images/house.png');
%im=rgb2gray(im);
perc=.6; %percentage of missing pixels
im=im2double(im);
im=im*255;
mask=rand(size(im,1),size(im,2));
mask(mask<perc)=0;
mask(~(mask==0))=1;
imn=im.*mask;
figure(1);
imshow(imn,[]);
s=8;
mnc=25;%number of cluster dimention
iterres=zeros(20,1);
imn1=imn;
sigmam=125;
sigmaju=20;
sigmam=sigmam+sigmaju;
toiter=floor((sigmam-10)/sigmaju);

for iter=1:18
   if (iter<toiter || iter==toiter)
        sigma=sigmam-iter*sigmaju;
    else
        sigma=10/(3^(iter-toiter));
    end
    
if mod(iter,3)==0
    refju=5;
elseif mod(iter,3)==1
    refju=6;
else
    refju=5;
end
[imfi]=main(ju,refju,N,imn1,s,mnc,iter,sigma,imn,mask);
Tblm=400000;

%imfi=mat2gray(imfi)*255;
imfi=imn+(1-mask).*imfi;
imn1=imfi;
itpsnr=10*log10(255*255/mean(mean((im-imfi).^2)));
iterres(iter,1)=itpsnr;

end


figure(2);
imshow(imfi,[]);
ISNR=10*log10((mean(mean((im-imn).^2))/mean(mean((imfi-im).^2))))
PSNR1=10*log10(255*255/mean(mean((im-imn).^2)))
PSNR2=10*log10(255*255/mean(mean((im-imfi).^2)))