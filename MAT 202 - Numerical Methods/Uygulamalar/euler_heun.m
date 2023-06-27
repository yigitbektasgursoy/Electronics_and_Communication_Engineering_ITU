%% Euler
clearvars; format long; fprintf('Euler ');
Y = @(x) x/(1+x^2);
a = 0; b = 10; h = 0.05; xn = a; yn = 0;
fprintf('(h=%.2f)\n',h);
while(xn<=b)
    f = (1/(1+xn^2)-2*yn^2);
    yn = yn + h*f;
    xn = round(xn + h,2); hata = abs(Y(xn)-yn); b_hata = hata/(abs(Y(xn)));
    if(mod(xn,1)==0)
        disp([xn yn hata b_hata]);
    end
end
%% Heun
clearvars; format long; fprintf('Heun ');
Y = @(x) x/(1+x^2);
a = 0; b = 10; h = 0.05; xn = a; yn = 0;
fprintf('(h=%.2f)\n',h);
while(xn<=b)
    f1 = (1/(1+xn^2)-2*yn^2); f2 = (1/(1+(xn+h)^2)-2*(yn+h*f1)^2);
    F = (1/2)*(f1 + f2);
    yn = yn + h*F;
    xn = round(xn + h,2); hata = abs(Y(xn)-yn); b_hata = hata/(abs(Y(xn)));
    if(mod(xn,1)==0)
        disp([xn yn hata b_hata]);
    end
end