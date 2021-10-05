%% Fun with Flags

% Getting all country names and their ISO 3166 country code
codes = webread('https://flagcdn.com/en/codes.json');

% Getting country codes
country_names = fieldnames(codes);
data_size = size(country_names, 1);

% Iterating over every countries
for i = 1:data_size
    country_code = char(country_names(i));  
    url = strcat('https://flagcdn.com/w2560/', country_code, '.png');
  
    try
        [data, colormap, alpha] = webread(url);
    catch
        disp(['[Error] Unable to fetch ' url]);
    end
end