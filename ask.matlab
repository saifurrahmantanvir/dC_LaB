clc; close all; clear all;

n=10; % length of bit stream 
b=[1 0 0 1 1 1 0 0 0 1] % input bit stream 
f1=3;
t=0:1/30:1-1/30; 
sa1=sin(2*pi*f1*t); %carrier signal 
E1=sum(sa1.^2);
sa1=sa1/sqrt(E1); %unit energy 
sa0=0*sin(2*pi*f1*t);
ask=[];

for i=1:n
if b(i)==1 
ask=[ask sa1]; 
else 
ask=[ask sa0]; 
end
end

figure(1)

subplot(411) 
stairs(0:10,[b(1:10) b(10)],'linewidth',1.5) 
axis([0 10 -0.5 1.5])
title('Message Bits'); 
grid on %plot message signal 
xlabel('Time'); 
ylabel('Amplitude')

subplot(412) 
tb=0:1/30:10-1/30; 
plot(tb, ask(1:10*30),'b','linewidth',1.5) 
title('ASK Modulation'); 
grid on %plot ASK signal 
xlabel('Time'); 
ylabel('Amplitude') 
