%% Fun with Flags
% Project of Data Science - Polytech ET5 2021-2022

% Getting all country codes and flags
%country_flags = CollectFlags();

disp(country_flags)


colors = {      % https://github.com/bahamas10/css-color-names/blob/master/css-color-names.json
    validatecolor("#d2691e"), "brown";
    validatecolor("#0000ff"), "blue";
    validatecolor("#000000"), "black";
    validatecolor("#808080"), "gray";
    validatecolor("#008000"), "green";
    validatecolor("#ffa500"), "orange";
    validatecolor("#663399"), "purple";
    validatecolor("#ff0000"), "red";
    validatecolor("#ffffff"), "white";
    validatecolor("#ffff00"), "yellow";
};



% TODO : use factorial analysis (ACF) through multiple correspondence analysis (ACM)



% TODO : plot ACF results and determine correlations that may exist between the characteristics of a country and the colours of its flag

% TODO : display percentage of information on axes (the distribution of
% information along the different axes (represented by eigenvalues ?)

% ============


% Would be a great idea but sizes are different...
% mean_flag = cellfun(@mean, country_flags(:,2), 'UniformOutput', false);


% ============


% Other method to study :
% use Linear Discriminant Analysis (AFD) with other features (width, height, number of color, ...)