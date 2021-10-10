x = -1 + (1+1)*rand(1,10);
y = -1 + (1+1)*rand(1,10);

sz = 25;

c = linspace(1,10,length(x));

scatter(x, y, sz, c, 'filled')

txt = {'FR','(France)'};
% txt.FontSize = 28;
text(0.2, 0.7, txt)

txt = {'USA','(United States of America)'};
% txt.FontSize = 28;
text(-0.8, -0.4, txt)

axis([-1 1 -1.5 1.5])
grid on
title({'\fontsize{12}Correlations between the characteristics of';...
'a country and the colours of its flag'})