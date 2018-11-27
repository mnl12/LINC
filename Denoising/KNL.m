function [Y,pos]=KNL(Y1,Y1n,s,pos1,mc,mcov1)
dis=zeros(1,size(Y1,2));
las=.6;
for i=1:size(Y1,2)
    dis(i)=((Y1(:,i)-Y1n(:,i))'*(Y1(:,i)-Y1n(:,i))+las*sigma^2*(Y1(:,i)-ym)'*(inv(mcov1))*(Y1(:,i)-ym)+las*sigma^2*log(dets))*.000005;
end
       [dis indx2]=sort(dis);
        Y1=Y1(:,indx2);
        pos1=pos1(:,indx2);
        Y=Y1(:,1:mc);
        pos=pos1(:,1:mc);
        
