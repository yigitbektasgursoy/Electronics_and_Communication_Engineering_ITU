clear     % MATLAB hafizasini temizler.
clc       % Komut satirini temizler.
close all % Önceden açik halde bulunan sekil(Figure) pencerelerini kapatir. 

% classical.wav ses dosyasinin okutulmasi
[X,fs]=audioread('classical.wav'); %fs, ornekleme frekansi
% Burada X degerleri, okutulan dosyanin örnek basina genlik degerlerine
% karsilik düsmektedir. 
% Okunan classical.wav dosyasini dinlemek için sound komutunu kullaniniz.
sound(X,fs);

% classical1.wav olarak yazildi.
% audiowrite('classical1.wav',X,fs); 

N = 512; % Kullanilan pencerenin uzunlugu
hop_size = 0.5*N; % % Kullanilan pencere kaydirma miktari

% Finding the number of frames (Simplest way)
N_frames = floor(length(X)/hop_size)-1;
% Sonuçta elimizde  N_frames degeri kadar pencerelenmis isaret olacak.

win = hann(N)';  % Hanning penceresi
% Istenilen özellige göre herhangi bir pencere kullanilabilir.

figure % Bos yeni bir sekil (Figure) penceresi açar.
plot(win) % win penceresini çizdirme komutu
title('Pencere Fonksiyonu') % sekil basligi
grid on 
% Finding the windowed signal & calculating energy in dB
r=0;
for k = 1:hop_size:(N_frames)*hop_size % k=1, 1+hop_size, 1+hop_size+hop_size, ... seklinde...
    ... artarak degerleri alip hesapliyor 
    r=r+1;
    windowed_sig(r,:)=X(k:k+N-1)'.*win; % Pencerelenmis isaret
    Es(r)=10*log10(sum(abs(windowed_sig(r,:)).^2)); % Pencerelenmis isaretin enerji degerleri (dB)

end
% Buradaki çerçeveleme isareti, farkli sekilde de hesaplatilabilir. 

figure
stem(Es) % Enerji degerlerinin çizdirilmesi (Çerçeve sayisina göre)
title('Pencerelenmis isaretin enerjisinin çerçeve Sayisina Göre Degisimi')
xlabel('Çerçeve Sayisi')
ylabel('Enerji (dB)')
grid on

% Eneri Degerlerinin Zaman Eksenine karsilik düsecek sekilde çizdirilmesi
figure
time_end=length(X)/fs; % Isaretin bittigi zaman ani saniye cinsinden
time = linspace(0,time_end,length(Es)); % 0 ile son zaman degeri araligini Es uzunlugu kadar noktaya esit araliklarla böler
plot(time,Es) % Zamana göre enerji degerlerinin çizdirilmesi
hold on % Ayni sekli tutarak üstüne diger sekli çizdirmek için tut
time2=linspace(0,length(X)/fs,length(X));
plot(time2, X, 'r') % isaretin genlik degerlerini zaman araligina göre çiz
title('Pencerelenmis isaretin Enerjisinin Zamana Göre Degisimi')
legend('Isaret Enerjisi','Isaret Genligi') % Iki tane çizdirilen degerlerden ilki isaret enerjisi, ikincisi isaret genligi
xlabel('Zaman (s)') % x-eksenini etiketlemek
ylabel('Enerji (dB)') % y-eksenini etiketlemek
grid on


% Pencerelenmis Isaretin Enerji degerlerini Örnek Sayisina Göre Çizdirme
figure
plot(linspace(0,length(X),length(Es)),Es);
title('Pencerelenmis Isaretin Enerjisinin Örnek Sayisina Göre Degisimi')
xlabel('Örnek Sayisi')
ylabel('Enerji (dB)')
grid on

save enerji Es % Sadece Es degerini kaydeder.

save enerji % Tüm degiskenleri enerji.mat olarak kaydeder. 

% Daha sonra tüm verilerinizi yükleyip islemlerinizi kodu çalistirmadan
% yapabilmek için
load enerji.mat % komutunu kullanabilirsiniz.

% Ayrica herhangi bir komutun ne ise yaradigini detaylariyla ...
... help komut_ismi (help linspace gibi) yazarak ögrenebilirsiniz.  
    



