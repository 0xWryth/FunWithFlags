function distance = ColorDistance(c1, c2)
    %COLORDISTANCE Summary of this function goes here
    %   Detailed explanation goes here
    distance = sqrt((c2(1)-c1(1)).^2 + (c2(2)-c1(2)).^2 + (c2(3)-c1(3)).^2);
end
