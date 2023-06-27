% EHB 315
% Sayisal Isaret Isleme
% Matlab Uygulama

clc,
clear all,
close all,

%%  EXAMPLE 1: Spectogram of a signal that consists of a sum of sinusoids.
%Generate N =1024 samples of a signal that consists of a sum of sinusoids. The normalized frequencies of the sinusoids are 2?/5 rad/sample and 4?/5 rad/sample. 
% The higher frequency sinusoid has 10 times the amplitude of the other sinusoid.

N = 1024;
n = 0:N-1;

w0 = 2*pi/5;
x = sin(w0*n)+10*sin(2*w0*n);

figure
subplot(2,1,1)
plot(x)
subplot(2,1,2)
%Compute the short-time Fourier transform using the function defaults. Plot the spectrogram.
s = spectrogram(x);
spectrogram(x,'yaxis')


%% EXAMPLE 2: 
% Generate a quadratic chirp, x, sampled at 1 kHz for 2 seconds. The frequency of the chirp is 100 Hz initially and crosses 200 Hz at t = 1 s.

t = 0:0.001:2;
x = chirp(t,100,1,200,'quadratic');

figure
subplot(2,1,1)
plot(x)
subplot(2,1,2)
%Compute and display the spectrogram of x.

% -Divide the signal into sections of length 128, windowed with a Hamming window.
% -Specify 120 samples of overlap between adjoining sections.
% -Evaluate the spectrum at floor(128/2+1)=65 frequencies and floor((length(x)?120)/(128?120))=235 time bins.
spectrogram(x,128,120,128,1e3,'yaxis')

%%   EXAMPLE 3: Spectrogram of quadratic chirp
t=0:0.0001:2;                    % 2 secs @ 1kHz sample rate
y=chirp(t,100,1,200,'q');       % Start @ 100Hz, cross 200Hz at t=1sec
figure
subplot(2,1,1)
plot(y)
subplot(2,1,2)
spectrogram(y,kaiser(128,18),120,128,1E4,'yaxis');
title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');



%
%%   EXAMPLE 1: Spectrogram of quadratic chirp
t=0:0.001:2;                    % 2 secs @ 1kHz sample rate
y=chirp(t,100,1,200,'q');       % Start @ 100Hz, cross 200Hz at t=1sec
figure
subplot(2,1,1)
plot(y)
subplot(2,1,2)
spectrogram(y,kaiser(128,18),120,128,1E3,'yaxis');
title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');

%
% %%  EXAMPLE 2: Reassigned spectrogram of quadratic chirp
% t=0:0.001:2;                    % 2 secs @ 1kHz sample rate
% y=chirp(t,100,1,200,'q');       % Start @ 100Hz, cross 200Hz at t=1sec
% figure
% subplot(2,1,1)
% plot(y)
% subplot(2,1,2)
% spectrogram(y,kaiser(128,18),120,128,1E3,'reassigned','yaxis');
% title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');

%% EXAMPLE 3:  Plot instantaneous frequency of quadratic chirp
t=0:0.001:2;                    % 2 secs @ 1kHz sample rate
y=chirp(t,100,1,200,'q');       % Start @ 100Hz, cross 200Hz at t=1sec
% remove estimates less than -30 dB
figure
subplot(2,1,1)
plot(y)
subplot(2,1,2)
[~,~,~,P,Fc,Tc] = spectrogram(y,kaiser(128,18),120,128,1E3,'minthreshold',-30);
plot(Tc(P>0),Fc(P>0),'. ')
title('Quadratic Chirp: start at 100Hz and cross 200Hz at t=1sec');
xlabel('Time (s)')
ylabel('Frequency (Hz)')

%% EXAMPLE 4: Waterfall display of the PSD of each segment of a VCO
% Fs = 10e3;
% t = 0:1/Fs:2;
% x1 = vco(sawtooth(2*pi*t,0.5),[0.1 0.4]*Fs,Fs);
% figure
% subplot(2,1,1)
% plot(x1)
% subplot(2,1,2)
% spectrogram(x1,kaiser(256,5),220,512,Fs);
% view(-45,65)
% colormap bone
% title('Waterfall display of the PSD of each segment of a VCO')