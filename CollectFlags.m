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

country_flags = cell(data_size, 4); % 1 row = {'fr'} {dataMatrix} {colormapMatrix} {alphaMatrix}

% Iterating over every countries
for i = 1:data_size
    country_code = char(country_names(i));
    url = strcat('https://flagcdn.com/w2560/', country_code, '.png');

    try
        [data, colormap, alpha] = webread(url);

	country_flags{i, 1}= country_code;
	country_flags{i, 2} = data;
	country_flags{i, 3} = colormap;
	country_flags{i, 4} = alpha;
    catch
        disp(['[Error] Unable to fetch ' url]);
    end
end

% TODO : remove empty rows (unreached flags)
% TODO : save in another format ?

end % CollectFlags
