clc;
clear;
sigmam=80;
sigmaju=20;
sigmam=sigmam+sigmaju;
toiter=floor((sigmam-10)/sigmaju);
for iter=1:14
    if (iter<toiter || iter==toiter)
        sigma=sigmam-iter*sigmaju
    else
        sigma=10/(3^(iter-toiter))
    end
end