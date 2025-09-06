clc; close all; clear all;

n=10; % length of bit stream
b=[1 0 0 1 1 1 0 0 0 1] % input bit stream
f1=1;f2=2;
t=0:1/30:1-1/30;
sf0=sin(2*pi*f1*t); %carrier signal 
E0=sum(sf0.^2);
sf0=sf0/sqrt(E0); %unit energy 
sf1=sin(2*pi*f2*t);
E1=sum(sf1.^2);
sf1=sf1/sqrt(E1); %unit energy 
fsk=[];

for i=1:n
if b(i)==1 
fsk=[fsk sf1];
else 
fsk=[fsk sf0];
end
end

figure(1)

subplot(211) 
stairs(0:10,[b(1:10) b(10)],'linewidth',1.5) 
axis([0 10 -0.5 1.5]) 
title('Message Bits'); 
grid on % message signal 
xlabel('Time'); 
ylabel('Amplitude')

subplot(212) 
tb=0:1/30:10-1/30; 
plot(tb, fsk(1:10*30),'r','linewidth',1.5) 
title('FSK Modulation'); 
grid on %FSK modulated signal 
xlabel('Time'); 
ylabel('Amplitude')
