%ģ���˻�
function [best_solution,best_fit,iter,pkq] = mySa5(solution,a,t0,tf,Markov,avg)
% ===== ���� ======%
% solution ��ʼ�� 
% a �¶�˥��ϵ�� 0.99
% t0 ��ʼ�¶� 120
% tf �����¶� 1
% Markov �����Ʒ������� 10000
% ====== ��� =====%
% best_solution ���Ž�
% best_fit ���Ž�Ŀ��ֵ
% iter ��������
n = length(solution);
t = t0;
solution_new = solution;  % ��ʼ�⸳�����µĽ�
best_fit = Inf;   % ��ʼ��������Ӧ�ȣ�������Ӧ�ȣ�
fit = Inf;      %  ��ʼ����ǰ����Ӧ��
best_solution = solution;  % ���Ž�
iter = 1;
l_s =[];
q=1;
% -----------------------��������------------------------------------%
while t >= tf
    for j = 1:Markov
% -----------------------�����½����------------------------------------%
        %�����Ŷ�,�����µ�����solution_new;
        if (rand < 0.7) % ����С��0.7 ��ȡ����������λ�õķ�ʽ�����½�
            ind1 = 0;  ind2 = 0;
            while(ind1 == ind2 && ind1 >= ind2)
                ind1 = ceil(rand*n);
                ind2 = ceil(rand*n);
            end
            if (ind1 == 66)     %%%%
                ind2 = 1;
            else
                ind2 = ind1+1;
            end
            temp = solution_new(ind1);
            solution_new(ind1) = solution_new(ind2);
            solution_new(ind2) = temp;
        else % ���ʴ��ڵ���0.7 ��ȡ���齻������������λ�õķ�ʽ�����½�
            ind = zeros(3,1);
            L_ind = length(unique(ind));
            while (L_ind < 3)
                ind = ceil([rand*n rand*n rand*n]);
                L_ind = length(unique(ind));
            end
            ind0 = sort(ind);
            a1 = ind0(1);  b1 = ind0(2);  c1 = ind0(3);
            solution0 = solution_new;
            solution0(a1:a1+c1-b1-1) = solution_new(b1+1:c1);
            solution0(a1+c1-b1:c1) = solution_new(a1:b1);
            solution_new = solution0;
        end
% -----------------------������Ӧ�ȹ���------------------------------------ %
        %������Ӧ��fit_new
        fit_new = getT5(solution_new,avg);
        
% -----------------------��ĸ��¹���------------------------------------ %
        if fit_new<fit 
            fit = fit_new;
            disp(fit);
            solution = solution_new;
            %������·�ߺ;������
            if  fit_new < best_fit           
                iter = iter + 1;
                best_fit = fit_new;
                best_solution = solution_new;
            end
        else
            if rand<exp(-(fit_new-fit)/t)
                solution = solution_new;
                fit = fit_new;
            end
        end
        solution_new = solution;
%         disp(solution_new);
    end
    t = t*a; %����
    pkq(q,:) = solution_new;
    l_s(q) = fit_new;
    q=q+1;
    if(mod(q,30)==0)
        plot(l_s)
    end
end
end


%��t
function[t] = getT5( P,avg )
N = zeros(4,100);
%����
for n = 1:66        %%%%%%
N(1:4,3+n) = avg(1:4,P(n));
end
i = 4;
Tarray = zeros(4) ;
while (i<=66)
    Tarray(1) = Tarray(1) + N(1,i);
    Tarray(2) = Tarray(2) + N(2,i-1);
    if(Tarray(2)<Tarray(1))
        Tarray(2) = Tarray(1);
    end
    Tarray(3) = Tarray(3) + N(3,i-2);
    if(Tarray(3)<Tarray(2))
        Tarray(3) = Tarray(2);
    end
    Tarray(4) = Tarray(4) + N(4,i-3);
    if(Tarray(4)<Tarray(3))
        Tarray(4) = Tarray(3);
    end 
i = i + 1;
end
t = Tarray(4); 
end