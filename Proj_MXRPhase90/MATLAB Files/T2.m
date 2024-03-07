clear all
close all
A = readmatrix('measure_10.csv');
lambda = 1/58; %from measurement
vds = A(:,3); 
vgs = A(:,1);
idss = zeros(500,1);
vp = zeros(500,1);
for a = 1:length(vgs)
    if vgs(a) <= -2
        idss(a) = - 8.6*10^(-20)*(vgs(a))+0.001;
        vp(a) = -0.61*(vgs(a)).^2 - 2.3*vgs(a) - 4.5; 
    else
        idss(a) = - 0.0023*(vgs(a)).^2 - 0.0015*(vgs(a)) + 0.0049;
        vp(a) = 0.58*(vgs(a)).^3 + 1.3*(vgs(a)).^2 + 0.9*vgs(a) - 2.5;
    end
end

input = [vgs, vds];
y = zeros(500,1);
for i = 1:length(idss)
    for j = 1:length(vp)
        %JFET equations with condition
        for k = 1:size(input)
            if vgs(k) <= vp(j)
                y(k)=0;
         %Ohmic region
            elseif vds(k) < (vgs(k) - vp(j)) && vds(k) >= 0
                y(k) = 2*(idss(i)/vp(j)^2)*((vgs(k)- vp(j) - vds(k)/2 )*vds(k)*(1+(lambda*vds(k))));
         %Saturation region 
            else
                y(k)= idss(i)*((1-(vgs(k)/vp(j)))^2)*(1+(lambda*vds(k)));
            end
        end
    end
end

