function [ f2 ] = left1( dta1,cont )
f2=0;
if (cont==0)
    if (dta1>70)
        f2=1;
    end
end

if (cont==1)
    if (dta1<70)
        f2=2;
    end
end

if (cont==2)
    if (dta1>70)
        f2=3;
    end
end


end
