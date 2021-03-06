%% Fun with Flags
% Project of Data Science - Polytech ET5 2021-2022

% Getting all country codes and flags
country_flags = CollectFlags();

disp(country_flags)

% List of triadic color
colors = {
    validatecolor("#ffffff"), "white";
    validatecolor("#000000"), "black";
    validatecolor("#ff0000"), "red";
    validatecolor("#00ff00"), "green";
    validatecolor("#0000ff"), "blue";
    validatecolor("#00ffff"), "cyan";
    validatecolor("#ff00ff"), "magenta";
    validatecolor("#ffff00"), "yellow";
}

country_size = size(country_flags, 1);
country_colors_proportion = cell(country_size, 2); % 1 row = {'fr'} {colorProportionVector}

country_colors_volume = zeros(country_size, size(colors, 1)); % 1 row = {'fr'} {whi_px_nb} {blk_px_nb} {red_px_nb} ...

% Iterating over countries
for i=1:country_size
    % Setting country data aliases
    country_name = country_flags{i,1};
    country_raw_data = country_flags{i, 2};
    country_colormap = country_flags{i, 3};
    country_color_pixel_number = country_flags{i, 5};

    % Creating color distance map
    distance_map = DistanceMap(country_colormap, colors);

    analysis_color_size = size(colors, 1);
    colormap_color_size = size(country_colormap, 1);

    % Getting every pixel found for EACH defined color
    colors_numbers = zeros(analysis_color_size, 1);
    for j=1:analysis_color_size
        % Iterating over each found color of the color map
        for k=1:colormap_color_size
            if (distance_map(k) == colors{j, 2})
                % Adding the correct number of pixel to the right color
                colors_numbers(j) = colors_numbers(j) + country_color_pixel_number(k);
            end
        end
    end

    % Getting every color proportion (%)
    color_proportion = zeros(analysis_color_size, 1);

    % Total number of pixel
    number_of_pixel = size(country_raw_data, 1) * size(country_raw_data, 2);

    % Iterating over color pixel number vector
    for j=1:analysis_color_size
        proportion = colors_numbers(j) / number_of_pixel;
        px_volume = colors_numbers(j);

        % Removing "transition color", found in the color map between 2 colors.
        if (proportion < 0.005) % 0.5%
            proportion = 0;
            px_volume = 1; % not 0 to avoid NaN/Inf errors in eig/svd functions..
        end

        color_proportion(j) = proportion;
        country_colors_volume(i, j) = px_volume;
    end

    country_colors_proportion{i, 1} = country_name;
    country_colors_proportion{i, 2} = color_proportion;
end

disp(country_colors_proportion);

% disp(DistanceMap(colormap, colors));


% TODO: refine parameters !!!
AFC(country_colors_volume, country_flags(:,1), colors(:,2)')
