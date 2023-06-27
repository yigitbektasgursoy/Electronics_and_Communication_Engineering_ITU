clc
clear all


%% FFT and DFT

% DFT hesaplanmasında N^2 karmaşık çarpma ve N*(N-1) karmaşık toplama gereklidir. 
% FFT yardımıyla N=2^R noktadan oluşan dizinin DFT'sinin hesaplanmasında NR/2 karmaşık çarpma 
% ve NR Karmaşık toplama işlemi yeterlidir.
% Adım sayısı 2 R = log2(N) olarak yazılırsa işlem yoğunluğu açısından DFT ile FFT kıyaslanabilir. 

N=2048;
x=rand(1,N);
tic
fft(x,N);
toc

% tic
% radix2hfd(x,N);
% toc

tic
n=[0:1:N-1];
k=[0:1:N-1];
WN=exp(-j*2*pi/N);
nk=n'*k;
WNnk=WN.^nk;
Xk=x*WNnk;
toc

%% Basic Plotting
x = 0:pi/100:2*pi; 
y = sin(x);

figure
plot(x,y)
% stem(x,y)
xlabel('x=0:2\pi');
ylabel('Sine of x');
title('Sine function')
grid on


%% FFT of Sine Wave
clc
clear all
% close all
Fs = 150;       % Sampling frequency
t = 0:1/Fs:1;   % Time vector of 1 second
f = 5;          % Create a sine wave of f Hz.
x = sin(2*pi*t*f);
nfft = 512;    % Length of FFT

% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2); 
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure;
subplot(2,1,1)
plot(t,x);
title('Sine Wave Signal');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(2,1,2)
plot(f,mx);
title('Power Spectrum of a Sine Wave');
xlabel('Frequency (Hz)'); 
ylabel('Power');

%%  FFT of Cosine Wave
clc
clear all
close all
Fs = 150;           % Sampling frequency
t = 0:1/Fs:1;       % Time vector of 1 second
f = 5;              % Create a sine wave of f Hz.
x = cos(2*pi*t*f);
nfft = 1024; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure(1);
plot(t,x);
title('Cosine Wave Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Cosine Wave');
xlabel('Frequency (Hz)');
ylabel('Power');

%% FFT of Cosine wave with phase shift
clc
clear all
close all

Fs = 150; % Sampling frequency
t = 0:1/Fs:1; % Time vector of 1 second
f = 5; % Create a sine wave of f Hz.
pha = 1/3*pi; % phase shift
x = cos(2*pi*t*f + pha);
nfft = 1024; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure(1);
plot(t,x);
title('Cosine Wave Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Cosine Wave');
xlabel('Frequency (Hz)');
ylabel('Power');

%% FFT of Square wave 
clc
clear all
close all

Fs = 150; % Sampling frequency
t = 0:1/Fs:1; % Time vector of 1 second
f = 5; % Create a sine wave of f Hz.
pha = 1/3*pi; % phase shift
x = square(2*pi*t*f);;
nfft = 1024; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure(1);
plot(t,x);
title('Square Wave Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Square Wave');
xlabel('Frequency (Hz)');
ylabel('Power');

%% FFT of Square pulse 
clc
clear all
close all

Fs = 150; % Sampling frequency
t = -0.5:1/Fs:0.5; % Time vector of 1 second
w = .2; % width of rectangle
x = rectpuls(t,2); % Generate Square Pulse
nfft = 1024; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure(1);
plot(t,x);
title('Square Pulse Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Square Pulse');
xlabel('Frequency (Hz)');
ylabel('Power');


%% FFT of Chirp Signal
clc
clear all
close all

Fs = 200; % Sampling frequency
t = 0:1/Fs:1; % Time vector of 1 second
x = chirp(t,0,1,Fs/6);
nfft = 1024; % Length of FFT
% Take fft, padding with zeros so that length(X) is equal to nfft
X = fft(x,nfft);

% FFT is symmetric, throw away second half
X = X(1:nfft/2);
% Take the magnitude of fft of x
mx = abs(X);
% Frequency vector
f = (0:nfft/2-1)*Fs/nfft;
% Generate the plot, title and labels.
figure(1);
plot(t,x);
title('Chirp Signal');
xlabel('Time (s)');
ylabel('Amplitude');
figure(2);
plot(f,mx);
title('Power Spectrum of a Chirp Signal');
xlabel('Frequency (Hz)');
ylabel('Power');