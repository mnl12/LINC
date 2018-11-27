function [Yd we]=lowrcovsimp2(Y,Ya,sigmaa,ma,iter)
  Yd=zeros(size(Y));
  nip=2;
    ep=.1;
    sumy=0;
    summa=zeros(size(Y,1),1);
    dimy=size(Y,2);
    if iter<nip
    for i=1:dimy
        y=Ya(:,i);
        sumy=sumy+y;
        summa=summa+ma(:,i);
    end
    summa(summa<.01)=1;
    ym=sumy./summa;
    else
        ym=mean(Y,2);

    end
    

        Sc=zeros(size(Y,1),size(Y,1));
        maswe=zeros(size(Y,1),size(Y,1));
    for i=1:dimy
        
        if iter<nip
            y=Ya(:,i);
            y=(y-ma(:,i).*ym);
        else
            y=Y(:,i);
            y=(y-ym);
        end

        covy=(y)*(y)';
        mamat=ma(:,i)*ma(:,i)';
        Sc=covy+Sc;
        maswe=maswe+mamat;
    end
    maswe(maswe<0.01)=1;
  if iter<nip
        covY=Sc./maswe;
  else
      covY=Sc./dimy;
  end
  if iter>1
   covco=sqrt(mean(diag(covY)));
   sigmaa=sigmaa+0.3*covco;
  end
    covY=covY+ep*eye(size(covY));
    [U S]=eig(covY);
    Si=zeros(size(S));

    
    m=size(S,1);
    for j=1:m
        Si(j,j)=1/S(j,j);
    end

    invcovY=inv(covY);
    we=ones(size(Y,2),1);
    dets=1;
    for k=1:m
        dets=dets*S(k,k);
    end
    for i=1:size(Y,2)
        vob=ma(:,i);
        yob=Ya(:,i);
        yob(vob==0)=[];
    H=diag(ma(:,i));    
    H(vob==0,:)=[];
    wwi=inv(H'*H+sigmaa^2*invcovY);
    Yd(:,i)=wwi*(H'*yob+sigmaa^2*invcovY*ym);

       l=((Yd(:,i)-ym)'*(U*Si*U')*(Yd(:,i)-ym)+log(dets))*.01;
       we(i,1)=2*exp(-l);
      
            
    end
    we=real(we);
      

