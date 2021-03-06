%求最优T流水线算法,A,N,V,T,t
function[P,t] = getT3( rand_10,avg,var )
Tmin_95 = 184.7786*0.95;  %95%的Tmin
A = zeros(4,13);%稀疏向量
N = zeros(4,10);%随机重整的avg
V = zeros(4,10);%随机重整的var
%扩充
for n = 1:10
N(1:4,n) = avg(1:4,rand_10(n));
V(1:4,n) = var(1:4,rand_10(n));
end
N = re4_10(N);
V = re4_10(V);
i = 1;
Tarray = zeros(4) ;
Tout = zeros(4,13);
while (i<=13)
    Tarray(1) = Tarray(1) + N(1,i);
    Tout(1,i) = Tarray(1);
    Tarray(2) = Tarray(2) + N(2,i);
    Tout(2,i) = Tarray(2);
    temp2 = Tarray(2);
    if(Tarray(2)<Tarray(1))
        Tarray(2) = Tarray(1);
    end
    Tarray(3) = Tarray(3) + N(3,i);
    Tout(3,i) = Tarray(3);
    temp3 = Tarray(3);
    if(Tarray(3)<temp2)
        Tarray(3) = temp2;
    end
    Tarray(4) = Tarray(4) + N(4,i);
    Tout(4,i) = Tarray(4);
    if(Tarray(4)<temp3)
        Tarray(4) = temp3;
    end
i = i + 1;
end
s = 4;
i = 13;
while i >1
    for k = 1:4
       TTT(k,i) = Tout(s,i) - N(s,i) - Tout (k,i-1);
    if abs(TTT(k,i)) < 0.00001
        A(k,i-1) = 1;
        s = k; 
    end
    end
    i = i-1;
end
 A(4,13) = 1;
t = Tarray(4); 
X = A.* N;
T = sum(sum(X));
mu = T;
sigma = sum(sum(A.* V));%正态分布函数矩阵
P = normcdf(Tmin_95,mu,sigma);
end

%重构矩阵格式
function[A]=re4_10(S)
re_s = reshape(S,[4,10]);
A = zeros(4,13);
Q = zeros(4,16);
Q(1:4,4:13) = re_s;
A(1,1:13)= Q(1,4:16);
A(2,1:13)= Q(2,3:15);
A(3,1:13)= Q(3,2:14);
A(4,1:13)= Q(4,1:13);
end