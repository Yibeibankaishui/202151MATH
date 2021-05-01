avg_row = mean(timedata,2);
std_row = std(timedata,0,2);
var_row = std_row.^2;
[max_row,index1] = max(timedata,[],2);
[min_row,index2] = min(timedata,[],2);

sigma = var_row(1);
mu = avg_row(1);
x = linspace(mu - 4 * sigma, mu + 4 * sigma, 101).';
y = pdf('Normal', x, mu, sigma);
plot(x, y);
