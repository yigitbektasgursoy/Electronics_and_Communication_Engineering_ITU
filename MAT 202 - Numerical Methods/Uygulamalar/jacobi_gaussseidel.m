%% Jacobi
clearvars; format long; fprintf('Jacobi\n');
x = [0 0 0 0]; x_g = [7 5 4 3]; hata = max(abs(x_g-x)); k = 0;
while(hata>5E-5)
    disp([k x(1) x(2) x(3) x(4) hata]);
    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
    x(1) = (1/9)*(75 - x2 - x3 - x4);
    x(2) = (1/8)*(54 - x1 - x3 - x4);
    x(3) = (1/7)*(43 - x1 - x2 - x4);
    x(4) = (1/6)*(34 - x1 - x2 - x3);
    hata = max(abs(x_g-x));
    k = k+1;
end
disp([k x(1) x(2) x(3) x(4) hata]);

%% Gauss-Seidel
clearvars; format long; fprintf('Gauss-Seidel\n');
x = [0 0 0 0]; x_g = [7 5 4 3]; hata = max(abs(x_g-x)); k = 0;
while(hata>5E-5)
    disp([k x(1) x(2) x(3) x(4) hata]);    x(1) = (1/9)*(75 - x(2) - x(3) - x(4));
    x(2) = (1/8)*(54 - x(1) - x(3) - x(4));
    x(3) = (1/7)*(43 - x(1) - x(2) - x(4));
    x(4) = (1/6)*(34 - x(1) - x(2) - x(3));
    hata = max(abs(x_g-x));
    k = k+1;
end
disp([k x(1) x(2) x(3) x(4) hata]);