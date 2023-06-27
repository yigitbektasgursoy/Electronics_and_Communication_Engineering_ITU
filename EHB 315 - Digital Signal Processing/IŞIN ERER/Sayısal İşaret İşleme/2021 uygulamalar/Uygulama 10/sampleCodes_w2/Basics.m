clear; % MATLAB bellegini (workspace) temizle
close all; % Acik butun figure pencerelerini kapat
clc; % Konsoldaki yazilari temizle
 
%music adi ile kaydedilmis bir wav dosyasini okur ve y matrisi olarak atar.
[y fs]=audioread('classical.wav'); 
 
%y matrisi olarak atanmis olan ses dosyasini dinler.
sound(y,fs);
 
%% ÖRNEK
 
%örnekleme hýzý 8kHz olan 10 saniyelik ses dosyasý oluþturalým. Bu dosyada
%0-2saniye arasý 0Hz
%2-4saniye arasý 400Hz
%4-6saniye arasý 1000Hz 
 
clear;
close all;
clc;
 
fs=11025; 
ts=1/fs;
 
%istenilen frekans degerleri
f1=4000;
f2=4500;
f3=5000;
f4=5500;
f5=5750;
f6=5200;
%sinuzoidal isaretlerin genliklerini 0.2 olarak aldik.
a1=1;
a2=1;
a3=1;
 
%sinuzoidal isaretlerin faz degerlerini 0 olarak aldik.
faz1=0;
faz2=0;
faz3=0;
 
%istenilen zaman araliklari
t1=(0:ts:1);
t2=(1:ts:2);
t3=(2:ts:3);
t4=(3:ts:4);
t5=(4:ts:5);
t6=(5:ts:5.4219);

%5 aralik icin sinus seklinde isaretler olusturuldu.
tsy1=sin(2*pi*f1*t1);
tsy2=a1*sin(2*pi*f2*t2);
tsy3=a2*sin(2*pi*f3*t3);
tsy4=a2*sin(2*pi*f4*t4);
tsy5=a2*sin(2*pi*f5*t5);
tsy6=a2*sin(2*pi*f6*t6);

%olusturulan zaman araliklari ve isaretler birlestirildi.
t=[t1 t2 t3 t4 t5 t6];
tsy=[tsy1 tsy2 tsy3 tsy4 tsy5 tsy6];
 
%olusturulan isareti cizdirmek

fs1=44100; 
ts1=1/fs1;
% plot(t,tsy,'k');
t1x=(0:ts1:2);
t2x=(4:ts1:11.4358);
tx=2:ts1:4;
tqq=[t1x tx t2x];
tsyx=zeros(1,length(tqq));
tsyx=sin(2*pi*6000*tx);
tsyx1=zeros(1,length(t1x))
tsyx2=zeros(1,length(t2x));
txxx=[tsyx1 tsyx tsyx2];
%wav olarak kaydetmek
audiowrite('sample2.wav',txxx,fs1);
 
%dosyayi dinlemek
sound(tsy,fs);
 
%wav dosyasini okumak
[y fs]=audioread('sample.wav');
