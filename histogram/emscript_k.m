 clc
clear all
format long

%Euler maruyama method to solve governing equation for vortex shedding with turbulence noise

f=0.8; %non-dimensional forcing frequency
A=0.4; % non-dimensional forcing amplitude
A_n = 10^-1;
omega=2*pi*f; %circular frequency

phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time

dt=1e-5; %time step
num_vor=200; %number of vortices shed 
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
%xlabel("{\it t_m}")
%ylabel("Circulation strength, {\Gamma_m}")
tt1=(tf(end-50:end)); %discard first few iterates manually
%figure
%plot(tf,'.k') %iterates of shedding time period 
%xlabel("Vortex count")
%ylabel("{\Delta t_m}")
%figure
%plot(tt1(1:end-1),tt1(2:end),'.') %phase portrait plot
%xlabel("{\Delta t_m}")
%ylabel("{\Delta t_{m+1}}")
figure
%h = histogram(tt1,length(tt1),'Normalization','pdf')
Kerneldist=fitdist(tt1(:),'Kernel','Kernel','epanechnikov')
x = 0:0.01:1.5
plot(x,Kerneldist)
%hold on;
%ax = gca;
%z = linspace(ax.XLim(1), ax.XLim(2), length(tt1));
%plot(z, normpdf(z), 'LineWidth', 2)
xlabel("{\Delta t_m}")
ylabel("Nunber of Vortices")