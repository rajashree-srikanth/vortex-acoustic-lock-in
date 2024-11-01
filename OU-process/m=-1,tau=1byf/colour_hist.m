clc
clear all
format long

%Euler maruyama method to solve governing equation for vortex shedding with turbulence noise

f = 0.9; %non-dimensional forcing frequency
A = 0.65; % non-dimensional forcing amplitude
A_n0 = 0.02;
m = -1;
tau =1/f;%correlation time - 0.01, 0.1, 0, 1, 10
omega=2*pi*f; %circular frequency

phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time

dt=1e-5; %time step
num_vor = 70000; %number of vortices shed 
randn('state',1) % set the state of randn


    for j=1:num_vor
        tm=(t1):dt:(t1+t_run);
        
        d_eta = zeros(1,length(tm)); % preallocate arrays 
        gam = zeros(1,length(tm)); 
        zi = zeros(1,length(tm));
        
        zi(1) = 0;
        gam(1)= 0;
        A_n(1) = A_n0 + (m*gam(1));
        d_eta(1) = sqrt(dt)*randn; %first approximation outside the loop
        gam_c(1)=0.5*(1+A*sin(omega*tm(1+1))); %tm(1) = t1 = 0, so all subsequent time instances will need to be i+1
    
            for i=2:length(tm)
                tt=tm(i+1)-t1;
                d_eta(i) = sqrt(dt)*randn; %Stochastic Brownian motion term
                gam(i) = gam(i-1)  + (((1+A*sin(omega*tm(i+1)))^2)*0.5 + zi(i-1))*dt;  %eqn 1, gamma to be determined, "deterministic" term
                A_n(i) = A_n0 + (m*gam(i-1)); %gam(i-1) = gam_t,i.e., gamma from previous iteration (known gamma)
                zi(i) = zi(i-1) + ((-zi(i-1)/tau)*dt) + ((A_n(i)/tau)*d_eta(i)); %eqn 2, OU process
                gam_c(i)=0.5*(1+A*sin(omega*tm(i+1))); %threshold circulation  
                
                
               if gam(i)>=gam_c(i)
                  gam(i+1)=0;
                  tf(j)=tt; %Shedding time period
                  break
               end
            end
  
%             plot(tm(1:i), gam_c,'b')
%             plot(tm(1:i+1),gam (1:i+1),'k')
%             hold on
%             plot(tm(i),gam(i),'or','MarkerFaceColor','r','MarkerSize',10)
  
            clear gam gam_c zi A_n
            t1=tm(i+1);  %t1=t2 condition 
            j    
end
tt14=tf(10000:end); %discard first few iterates manually
A14 = A;
figure
hold on
dh = 0.01;
x = 0:dh:1.5;
pdKern14 = fitdist(tt14', 'kernel')
p14 = pdf(pdKern14, x)
plot(x,p14,'LineWidth', 2)
h14 = histogram(tt14,'Normalization','pdf')
hold off
xlabel("{\Delta t_m}")
ylabel("pdf")
% figure
% plot(tf,'.k') %iterates of shedding time period 
% figure
% plot(tt1(1:end-1),tt1(2:end),'.') %phase portrait plot