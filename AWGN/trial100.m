clc
clear all
format long
 
f=0.8; %non-dimensional forcing frequency
A=0.05; % non-dimensional forcing amplitude
omega=2*pi*f; %circular frequency
 
phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time
 
dt=10^-5; %time step
num_vor=250; %number of vortices shed 
A_noise = 0.05
 
randn('state',100) % set the state of randn
 
for j=1:num_vor
    tm=(t1):dt:(t1+t_run);

    dX = zeros(1,length(tm)); % preallocate arrays 
    X = zeros(1,length(tm)); 

    dX(1) = A_noise*sqrt(dt)*randn; %first approximation outside the loop
    gam(1) = 0;
    gam_c(1)=0.5*(1+A*sin(omega*tm(1+1)));
    X(1) = gam(1) + dX(1); % First EM solution

    for i=2:length(tm)
        tt = tm(i+1)-t1; 
        dX(i) = A_noise*sqrt(dt)*randn;
        gam(i) = ((1+A*sin(omega*tm(i+1))^2)/2)*dt; %gam = dGam = gam(m+1)-gam(m)     
        X(i) = X(i-1) + gam(i) + dX(i);

        gam_c(i)=0.5*(1+A*sin(omega*tm(i+1))); %threshold circulation
        if X(i)>=gam_c(i)
           X(i+1)=0;
           tf(j)=tt; %Shedding time period
           break
        end
    end

    plot(tm(1:i), gam_c,'b')
    plot(tm(1:i+1),X(1:i+1),'k')
    hold on
    plot(tm(i),X(i),'or','MarkerFaceColor','r','MarkerSize',5)

    clear gam gam_c X
    t1=tm(i+1);  %t1=t2 condition 
    j    
end

tt1=tf(end-200:end); %discard first few iterates manually
figure
plot(tf,'.k') %iterates of shedding time period 
figure
plot(tt1(1:end-1),tt1(2:end),'.') %phase portrait plot