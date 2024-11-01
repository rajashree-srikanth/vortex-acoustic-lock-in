clc
clear all
format long

%Euler maruyama method to solve governing equation for vortex shedding with turbulence noise

f=0.9; %non-dimensional forcing frequency
A=1.0; % non-dimensional forcing amplitude, varied from 0.55:0.05:1
A_n = 0.02;
omega=2*pi*f; %circular frequency

phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time

dt=1e-5; %time step
num_vor=70000; %number of vortices shed 
randn('state',1) % set the state of randn

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
        
    %plot(tm(1:i),gam_c,'b', tm(1:i+1),X(1:i+1),'k')
    %hold on
    %plot(tm(i),X(i),'or','MarkerFaceColor','r','MarkerSize',10)
  
    clear gam gam_c X
    t1=tm(i+1);  %t1=t2 condition 
    j
end
tt20=(tf(10000:end)); %discard first few iterates manually
figure
%h = histogram(tt1,200)
hold on
%fitdist(tt1(:),'Normal')
dh = 0.01;
x = 0:dh:1.5;
pdKern = fitdist(tt20','kernel')
p20=pdf(pdKern,x)
plot(x,p20,'LineWidth', 2)
h20 = histogram(tt20,'Normalization','pdf')
hold off;
%ax = gca;
%z = linspace(ax.XLim(1), ax.XLim(2), length(tt1));
%plot(z, normpdf(z), 'LineWidth', 2)
xlabel("{\Delta t_m}")
ylabel("pdf")