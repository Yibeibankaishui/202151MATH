task_num = [1000,500,600,1000,1200,1600,1800,800,600,900];%����
max_avg = max(avg,[],1);
mu = task_num.*max_avg;
sigma = [1.88973229562857,1.25291127780000,0.844790781636735,1.12771557856735,1.13957072352653,0.973471332689796,0.656362277126530,1.07001134177959,0.973807391220409,0.263394333636735];
mu0 = sum(mu);
sigma0 = sum(task_num.*sigma);
x=140000:1:240000;
P = normcdf(x,mu0,sigma0);
X = norminv(0.9,mu0,sigma0);
Daynum = X/60/24;
plot(x,P);