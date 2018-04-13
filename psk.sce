clear all
clc
f=input('enter frequency in Hz:')
t=0:0.0001:1
x1=sin(2*%pi*f*t);
x2=sin((2*%pi*f*t)+%pi)
message=[];
carrier1=[];
carrier2=[];
I=input('Enter binary data:')
for i=1:length(I)
    if(I(i))==1
        m_s=ones(1,length(t));
    else
        m_s=zeros(1,length(t));
    end
    message=[message,m_s];
    carrier1=[carrier1,x1]
    carrier2=[carrier2,x2]
end
psk=[];
for n=1:length(I)
    if(I(n)==1)
        psk=[psk,x2];
    else
        psk=[psk,x1]
    end
end
subplot(4,1,1);
plot(message,"r");
xtitle('Y15EC847   Message Signal');
xlabel('Time---->');
ylabel('Amplitude--->');
subplot(4,1,2);
plot(carrier1,"g");
xtitle('Carrier Signal');
xlabel('Time---->');
ylabel('Amplitude--->');
subplot(4,1,3);
plot(psk);
xtitle('Modulated Signal');
xlabel('Time---->');
ylabel('Amplitude--->');

//demodulation
xdemod1=[];
xdemod2=[];
demod=[];
xdemod1=psk.*carrier1;
xdemod2=psk.*carrier2;
xdemod=xdemod2-xdemod1;
for i=1:length(I)
    if i==1
        s=sum(xdemod(1:length(t)))
    else
        s=sum(xdemod((i-1)*length(t):i*length(t)))
    end
    if(s>0)
        demod=[demod,zeros(1,length(t))]
    else
        demod=[demod,ones(1,length(t))]
    end
   
end

subplot(4,1,4);
plot(demod);
xtitle('DeModulated Signal');
xlabel('Time---->');
ylabel('Amplitude--->');
