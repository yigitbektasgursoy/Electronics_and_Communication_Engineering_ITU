clc
clear all
close all
%% Comparison of DFT and FFT

%% Manual DFT

x = [2 3 -1 4];
N = length(x);
X = zeros(4,1);
tic
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1)*exp(-j*pi/2*n*k);
    end
end
toc
t = 0:N-1;
figure
subplot(311)
stem(t,x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Time domain - Input sequence')

subplot(312)
stem(t,abs(X))
xlabel('Frequency');
ylabel('|X(k)|');
title('Frequency domain - Magnitude response')

subplot(313)
stem(t,angle(X))
xlabel('Frequency');
ylabel('Phase');
title('Frequency domain - Phase response')

X         % to check |X(k)|
angle(X)  % to check phase

%% FFT
% clear all
N=4;
x=[2 3 -1 4];
tic
Xk = abs(fft(x));
toc
t=0:N-1;
figure
subplot(311)
stem(t,x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Input sequence')

subplot(312); 
stem(0:N-1,abs(fft(x)));  
xlabel('Frequency');
ylabel('|X(k)|');
title('Magnitude Response'); 

subplot(313); 
stem(0:N-1,angle(fft(x)));
xlabel('Frequency');
ylabel('Phase');
title('Phase Response'); 
