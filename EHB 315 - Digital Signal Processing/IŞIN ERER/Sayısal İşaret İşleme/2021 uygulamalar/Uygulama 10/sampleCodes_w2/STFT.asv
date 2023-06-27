clear     % MATLAB hafizasini temizler.
clc       % Komut satirini temizler.
close all % Önceden açik halde bulunan sekil(Figure) pencerelerini kapatir. 

% classical.wav ses dosyasinin okutulmasi
[ wav fs ]=audioread('classical.wav'); 
 %% Genlik ve faz hesaplamasi
  % frame sayisini belirlemek
fft_size  =1024; %window size       (unit:samples)
hopsize   =512;  %fft window hopsize (unit:samples)    

frames = 0;
idx =1:fft_size;
while idx <= length(wav), 
    frames = frames + 1; 
    idx = idx + hopsize;
end

%zeros komutuyla uzunlugunu bildiginiz bir vektor olusturabilirsiniz.
X=zeros(fft_size,frames);
idx = 1:fft_size;
w = hann(fft_size); %hanning pencereleme fonksiyonu 
for i=1:frames 
    X(:,i) = fft(wav(idx).*w);%% FFT
    idx = idx + hopsize;
end
 %% Grafikleri cizdirmek
 
% x ve y eksenlerini belirlemek
max_freq = fs/2;
ff=linspace(0,max_freq,fft_size);
fr=1:frames;
figure; 
hs(1) = subplot(3,1,1); %% audio signal
plot(wav,'k'); axis tight;
ylabel('PCM'),title('sinyal')
hs(2) = subplot(3,1,2); %% amplitude
imagesc(fr,ff,10*log10(abs(X)));
ylabel('Frekans(Hz)'),xlabel('Pencere Sayýsý'),title('Genlik')
colorbar

hs(3) = subplot(3,1,3); %% phase
%     tmp.phase(tmp.phase<1)=0; %% for dB 
imagesc(fr,ff,(angle(X))); 
ylabel('Frekans(Hz)'),title('Faz')
colorbar
