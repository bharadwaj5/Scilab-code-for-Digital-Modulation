clear all;
clc;
f=input('enter the analog carrier frequency in Hz:');
t=0:0.00001:0.1;
x=cos(2*%pi*f*t);
message=[];
carrier=[];
I=input('enter the digital binary data:');
for i=1:length(I)
    t=[0:.00001:0.1] 
    if I(i)>0.5 
        m(i)=1; 
        m_s=ones(1,length(t)); 
        carrier=[carrier,x]
    else 
        m(i)=0; 
        m_s=zeros(1,length(t));
        carrier=[carrier,x] 
    end 
    message=[message,m_s];
end

//generation of ask

Xask=[];

for n=1:length(I)

    if((I(n)==1) & (n==1))

        Xask=[x,Xask];

    elseif((I(n)==0) & (n==1))

        Xask=[zeros(1,length(x)),Xask];

    elseif((I(n)==1) & (n~=1))

        Xask=[Xask,x];

    elseif((I(n)==0) & (n~=1))

        Xask=[Xask,zeros(1,length(x))];

    end

end

subplot(4,1,1)
plot(message)
xtitle('Y15EC805   (Binary Message Signal)')
xlabel('Time--->')
ylabel('Amplitude--->')
subplot(4,1,2)
plot(carrier);
xtitle('Carrier signal')
xlabel('Time--->')
ylabel('Amplitude--->')
subplot(4,1,3)
plot(Xask)
xtitle('Amplitude Shift Keying')
xlabel('Time--->')
ylabel('Amplitude--->')
/*
subplot(4,1,4);
plot(message)
xtitle('Demodulated signal')
xlabel('Time--->')
ylabel('Amplitude--->') */
//demodulation
demod=[]
xdm=[]
for i=1:length(I)
    if i>=2
        xdemod=sum(Xask(1:(i*length(t))))-sum(Xask(1:((i-1)*length(t))));
    else
        xdemod=sum(Xask(1:(i*length(t))));
    end
    if xdemod>0
        demod(:,i)=1
        xdm=[xdm,ones(1,length(t))]
    else
        demod(:,i)=0
        xdm=[xdm,zeros(1,length(t))]
    end
end
disp('demodulated data:',demod);
if(demod==I)
    subplot(4,1,4);
    plot(xdm)
    xtitle('Demodulated Signal')
    xlabel('Time--->')
    ylabel('Amplitude--->')
else
    disp('invalid');
end
