"Yigit Bektas Gursoy"
"040180063"

clear;
clc;
% A
f_s = 400; %örnekleme frekansı
t = 0:1/f_s:1-1/f_s;

x = sinc(20*t-10);

xf = fftshift(fft(x)); %frekans domeninde x
f = linspace(-200,200,f_s);

figure('name',"Zaman ve Frekans Domeninde X");
subplot(2,1,1)
plot(t,x),xlabel("Zaman"),ylabel("Genlik"), title("Zamanda X");
subplot(2,1,2)
plot(f,abs(xf)),xlabel("Frekans"),ylabel("Genlik"), title("Frekansta X");

% B

fd=40; %impuls katarı frekansı
fsd=fd*10; 
td=0:1/fsd:1-1/fsd; % zaman aralığı
dirac = zeros(size(td));
dirac(1:fsd/fd:end) = 1;


xs = x.*dirac;
figure('name',"x_s");
plot(t,xs),xlabel("Zaman"),ylabel("Genlik"), title("Xs");

% C
x1 = 0:1/f_s:1;
h1 = rectangularPulse((x1-0.0025)/0.005);%pam1 için süzgeç
xpam1 = conv(xs,h1);
xpam1 = xpam1(1:length(xs));
tpam1 = 0:1/f_s:1-1/f_s;



xfpam1 = fftshift(fft(xpam1));
figure('name',"Zaman ve Frekans Domeninde Xpam");
subplot(2,1,1)
plot(tpam1,xpam1),xlabel("Zaman"),ylabel("Genlik"), title("Zamanda Xpam1");
subplot(2,1,2)
plot(f,abs(xfpam1)),xlabel("Frekans"),ylabel("Genlik"), title("Frekansta Xpam1");

% D
x2 = 0:1/f_s:1;
h2 = rectangularPulse((x2-0.005)/0.01); %pam2 için süzgeç
xpam2 = conv(xs,h2);
xpam2 = xpam2(1:length(xs));
tpam2 = 0:1/f_s:1-1/f_s;

xfpam2 = fftshift(fft(xpam2));
figure('name','Zaman ve Frekans Domeninde Xpam');
subplot(2,1,1)
plot(tpam2,xpam2),xlabel("Zaman"),ylabel("Genlik"), title("Zamanda Xpam2");
subplot(2,1,2)
plot(f,abs(xfpam2)),xlabel("Frekans"),ylabel("Genlik"), title("Frekansta Xpam2");