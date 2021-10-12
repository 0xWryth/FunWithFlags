function distancemap = DistanceMap(colormap, colors)
    %DISTANCEMAP Summary of this function goes here
    %   Detailed explanation goes here
    
    distancemap = strings(size(colormap, 1), 1);
    
    for i = 1:size(colormap, 1)
        
        lowest = 1000;
        
        for j = 1:size(colors, 1)
            value = ColorDistance(colormap(i,1:3), colors{j,1});
            if lowest > value
                distancemap(i, 1) = colors{j,2};
                lowest = value;
            end
        end
        
    end
end