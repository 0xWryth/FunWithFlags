function country_flags = CollectFlags()
% COLLECTFLAGS Used to get flags as image matrixes using flagcdn API
%
% COUNTRY_FLAGS = COLLECTFLAGS() Common usage
% COUNTRY_FLAGS = COLLECTFLAGS   Can also be called without parentheses

% Getting all country names and their ISO 3166 country code
codes = webread('https://flagcdn.com/en/codes.json');

% Getting country codes
country_names = fieldnames(codes);
data_size = size(country_names, 1);

country_flags = cell(data_size, 5); % 1 row = {'fr'} {dataMatrix} {colormapMatrix} {alphaMatrix} {colorPixelNumberVector}

% Iterating over every countries
for i = 1:data_size
    country_code = char(country_names(i));
    url = strcat('https://flagcdn.com/w2560/', country_code, '.png');

    try
        [data, colormap, alpha] = webread(url);
        colorPixelNumberVector = PixelNumberPerColor(data, colormap);

        country_flags{i, 1} = country_code;
        country_flags{i, 2} = data;
        country_flags{i, 3} = colormap;
        country_flags{i, 4} = alpha;
        country_flags{i, 5} = colorPixelNumberVector;
    catch
        disp(['[Error] Unable to fetch ' url]);
    end
end

% Remove empty rows (unreached flags) :
% Trim cell array to only rows that are not empty in their first column.
country_flags = country_flags(~cellfun(@isempty, country_flags(:,1)), :);


%% TODO : save in another format like 'RGB type' ?
%  SEE : image-types.html and ind2rgb.html in documentation

% TEMPO EXAMPLE: pick random flag and display it
random_flag = randi([0 size(country_flags, 1)]);
%imshow(country_flags{random_flag, 2}, country_flags{random_flag, 3}) % give data and colormap

random_flag_rgb = ind2rgb(country_flags{random_flag, 2}, country_flags{random_flag, 3});
imshow(random_flag_rgb) % give only 'rgb variable(s)'

end % CollectFlags
