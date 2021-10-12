function res = PixelNumberPerColor(data, colorMap)
    res = zeros(size(colorMap, 1), 1);

    for i = 1:size(colorMap, 1)
        % Data value starts with 0, therefore we need to use i-1
        res(i) = nnz(data==(i-1));
    end
end

