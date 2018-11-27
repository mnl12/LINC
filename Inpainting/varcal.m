ju=1;
refju=6;
s=8;
im=imread('lena.png');
perc=.5;
im=im2double(im);
im=im*255;
mask=rand(size(im,1));
mask(mask<perc)=0;
mask(~(mask==0))=1;
imn=im.*mask;

k=0;
for i=1:ju:size(imn,1)-s+1,
    for j=1:ju:size(imn,2)-s+1,
        k=k+1;       
    end;
end;
Y=zeros(s*s,k);
varm=zeros(k,1);
Ma=zeros(s*s,k);
k=0;
for i=1:ju:size(imn,1)-s+1,
    for j=1:ju:size(imn,2)-s+1,
        k=k+1;
        ims(1:s,1:s)=imn(i:i+s-1,j:j+s-1);
        mav=reshape(mask(i:i+s-1, j:j+s-1),s*s,1);
        Y(:,k)=reshape(ims,s*s,1);
        Ma(:,k)=mav;
    end;
end;

for i=1:size(Y,2)
    y=Y(:,i);
    e=(y-mean(y)).*Ma(:,i);
    napi=sum(Ma(:,i)'*Ma(:,i));
    vary=sqrt(e'*e/(napi));
    varm(i)=vary;
end
evar=mean(varm)
    
 