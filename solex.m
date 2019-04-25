function sol = solex(p_eq, q_eq, r_eq, f_eq, alpha1, alpha2, alpha, beta1, beta2, beta, a, b) 

%Задано уравнение вида p_eq(x)y''+q_eq(x)*y'+r_eq(x)*y=f_eq(x)
%Требуется привести к виду y''+q(x)*y'+r(x)*y=f(x)
%var 5
   
   %Строим коэффициенты нового уравнения
    function[X]=q(x)
       X=q_eq(x)/p_eq(x);       
    end
    function[X]=r(x)
       X=r_eq(x)/p_eq(x);
    end  
    function[X]=f(x)
      X=f_eq(x)/p_eq(x);      
    end

 %Задаем коэффициенты в граничных условиях 
 %   alpha1*u(a)-alpha2*u'(a)=alpha
 %   beta1*u(b)+beta2*u'(b)=beta  
    
    %solution solver bvp4c()    
    %Вводим вспомогательные функции y1(x)=y(x), y2(x)=y'(x) и сводим уравнение к системе уравнений первого порядка относительно них
    %   y1'=y2;
    %   y2'=f(x)-q(x)*y2-r(x)*y1
        
    %Задаем правые части уравнений    
    function tmp = twoode(x,y)
       tmp = [ y(2)              
              f(x)-q(x)*y(2)-r(x)*y(1)];         
    end
    %Граничные условия следует выписать так, чтобы в правых частях стояли  нули
    function res = twobc(ya,yb)
         res = [ alpha1*ya(1)-alpha2*ya(2)-alpha
                 beta1*yb(1)+beta2*yb(2)-beta];
    end
     n=40;
    xx = linspace(a,b,n+1); %Задаем сетку, в узлах которой требуется получить решение
    solinit = bvpinit(xx, [0.6 0]);%Выбор начальной сетки и начального приближения к решению
    options = bvpset('Reltol',1e-06,'abstol',1e-06,'Nmax',1e10); %здесь задается точность решения - оценивается невязка
    sol = bvp4c(@twoode,@twobc,solinit,options);%Собственно обращение к солверу
        
    ExSol = deval(sol,xx);%Интерполяция - вычисление решения в заданных точках сетки
    sol = ExSol(1,:);
    %{
    mas=[xx;ExSol(1,:)];
    fprintf('%5.2f  %10.5f \n',mas);        
    %}
    hold on;
    plot(xx,sol,'red');
    %{
    title('Решение граничной задачи солвером bvp4c');
    legend(  ' Решение  солвером bvp4c');    
     dat=[mas'];%Данные располагаются в 2 столбца
    cnames={'x','ybvc4c'};
    uitable('Parent',figure('Position',[150 150 200 280]),'Position',[20 20 160 240],'Data',dat,'ColumnName',cnames,'RowName',([]));    
    %}
end

