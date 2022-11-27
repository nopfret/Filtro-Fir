clc 
clear all 
close all

[x,Fs] = audioread('audio_roteiro10.wav');

fp = 3e3/Fs; 
fst = 3.3e3/Fs;
fc = 3.15e3/Fs;
alpha = 80;
wp = 2*fc;


%% 1
Mb = ceil((alpha-7.95)/(14.36*(fst-fp)))+1;
alp = Mb /2;


b = 0.1102*(alpha-8.7)
w = kaiser(Mb+1,b)';
figure(1);
wvtool(w)

b = fir1(Mb,wp,w);
[H,w] = freqz(b,1,Mb);

figure(2)
subplot(2,1,1)
plot((w/(2*pi))*Fs,20*log10(abs(H)))
xlabel('Frequência (Hz)')
ylabel('Magnitude (dB)')
subplot(2,1,2)
plot((w/(2*pi))*Fs,phase(H)*180/pi)
xlabel('Frequência (Hz)')
ylabel('Fase (graus)')

%%2 

%%a
figure(3)
y = fft(x);
z = fftshift(y);

ly = length(y);
f = (-ly/2:ly/2-1)/ly*Fs;
subplot(2,1,1)
stem(f,abs(z))
title("Gráfico do sinal de audio original no domínio da frequencia (modulo da FFT)")
xlabel("Frequencia (Hz)")
ylabel("|y|")
grid

aud_fill = filter(b, 1, x);

y = fft(aud_fill);
z = fftshift(y);

ly = length(y);
f = (-ly/2:ly/2-1)/ly*Fs;
subplot(2,1,2)
stem(f,abs(z))
title("Gráfico do sinal de audio filtrado no domínio da frequencia (modulo da FFT)")
xlabel("Frequencia (Hz)")
ylabel("|y|")
grid

%b 

audio = audioplayer(aud_fill*1000,Fs);
play(audio);