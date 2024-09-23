function [xc, yc] = Perfil_Carga()
xc=-30+1.25:2.5:50-1.25;
yc2=[2.5*randi([0 16],size(xc))];
yc=yc2;
for i = 1:length(xc)
    if (xc(i)<2.5)
        yc(i)=0;
    end
    if (xc(i)<-10)&&(xc(i)>-25)
        if (rem(i,2)==0)
            yc(i)=2.5;
        end
    end
    if (xc(i)>2.5)&&(xc(i)<47.5)
        yc(i)=yc2(i)-20;
    end
    if (xc(i)>=47.5)
        yc(i)=0;
    end
end
end