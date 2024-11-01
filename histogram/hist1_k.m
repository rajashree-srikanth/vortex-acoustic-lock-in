clc
clear all
format long

%%%%%%Variable decleration%%%%%%%%%%%%
%-------------------------------------------%
F_f=0.8; %non-dimensional forcing frequency
A=0.4; % non-dimensional forcing amplitude
omega=2*pi*F_f; %circular frequency

phi=0; %initial phase
t1=0; % initial time
t_run=40; %final time

dt=1e-5; %time step
num_vor=250; %number of vortices shed;
for j=1:num_vor
    
    tm=(t1):dt:(t1+t_run);
    for i=1:length(tm)
        tt=tm(i+1)-t1; 
        gam(i)=tt*(A^2/4+1/2)-A^2*(sin(2*omega*tm(i+1)+2*phi)-sin(2*omega*t1+2*phi))/(8*omega)+...
            A*(cos(omega*t1+phi)-cos(omega*tm(i+1)+phi))/omega; %Gamma_m
        gam_c(i)=0.5*(1+A*sin(omega*tm(i+1)+phi)); %threshold circulation Gamma_sep
        
        if gam(i)>=gam_c(i)
            gam(i+1)=0;
            tf(j)=tt; %Shedding time period
            break
        end
    end
    %plot(tm(1:i),gam_c,'b', tm(1:i+1),gam(1:end),'k')
    %hold on
    %plot(tm(i),gam(i),'or','MarkerFaceColor','r','MarkerSize',10)
   
    clear gam gam_c
    t1=tm(i+1);  %t1=t2 condition 
    j
end
tt1=tf(end-200:end); %discard first few iterates manually
%figure
%plot(tf,'.k') %iterates of shedding time period 
%figure
%plot(tt1(1:end-1),tt1(2:end),'.') %phase portrait plot
h = histogram(tt1,(num_vor-50))