%行平均值
avg_row = mean(timedata,2);
%行方差
std_row = std(timedata,0,2);
var_row = std_row.^2;
%行最大最小值
[max_row,index1] = max(timedata,[],2);
[min_row,index2] = min(timedata,[],2);
%重整均值
avg = reshape(avg_row,[4,10]);
var = reshape(var_row,[4,10]);
N=[10,5,8,2,4,6,7,9,3,1];

[best_solution,best_fit,iter,nice] = mySa3(N,0.99,120,1,10000,avg,var);
%Nal_dis( var_row,avg_row );



%正态分布
function[] = Nal_dis( var_row,avg_row )
for i = 1:40
sigma = var_row(i);
mu = avg_row(i);
x=0:0.1:30;
y(i,:)=gaussmf(x,[sigma mu]);
end
plot(x, y);
end
