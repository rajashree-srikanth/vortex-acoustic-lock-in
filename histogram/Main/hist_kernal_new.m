clc
clear all
format long

%Euler maruyama method to solve governing equation for vortex shedding with turbulence noise

f=0.9; %non-dimensional forcing frequency
A_range=0.05:0.05:0.5; % non-dimensional forcing amplitude
A_n = 0.02;
omega=2*pi*f; %circular frequency

phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time

dt=1e-5; %time step
num_vor=70000; %number of vortices shed 
randn('state',1) % set the state of randn
sb = 1;

for A = A_range
    for j=1:num_vor
        tm=(t1):dt:(t1+t_run);
    
        dX = zeros(1,length(tm)); % preallocate arrays 
        X = zeros(1,length(tm)); 
    
        dX(1) = A_n*sqrt(dt)*randn; %first approximation outside the loop
        gam(1)= 0;
        X(1) = gam(1) + dX(1); % First EM solution
        gam_c(1)=0.5*(1+A*sin(omega*tm(1+1)));
    
            for i=2:length(tm)
                tt=tm(i+1)-t1;
                dX(i) = A_n*sqrt(dt)*randn; %Stochastic term
                gam(i)=((1+A*sin(omega*tm(i+1)))^2)*0.5*dt;  %Deterministic term
                X(i) = X(i-1) + gam(i) + dX(i);
                gam_c(i)=0.5*(1+A*sin(omega*tm(i+1))); %threshold circulation 
            
               if X(i)>=gam_c(i)
                  X(i+1)=0;
                  tf(j)=tt; %Shedding time period
                  break
               end
            end
  
           clear gam gam_c X
           t1=tm(i+1);  %t1=t2 condition 
           j
    end
    
    subplot(4,2,sb)
    tt1=(tf(10000:70000)); %discard first few iterates manually
    %figure
    hold on
    dh = 0.01;
    x = 0:dh:2;
    pdKern = fitdist(tt1','kernel')
    p1=pdf(pdKern,x);
    h1 = histogram(tt1, 'Normalization', 'pdf')
    hold on;
    plot(x,p1,'LineWidth', 2)
    box off;
    hold off;
    title(['Amplitude = ', num2str(A)])
    xlabel("{\Delta t_m}")
    ylabel("PDF")
    xlim([0.25 1.75])
    legend('Histogram','PDF')
    sb = sb + 1;
end
