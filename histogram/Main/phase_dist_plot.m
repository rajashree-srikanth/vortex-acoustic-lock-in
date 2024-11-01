%load main_maindata.mat
%f = 0.9
%omega = 2*pi*f
%phi is  omegat -> the raw phase values
%phi = omega.*[tt0; tt1; tt2; tt3; tt4; tt6; tt5; tt7; tt8; tt9; tt10; tt11; tt12; tt13; tt14; tt15; tt16; tt17; tt18; tt19; tt20; tt_1; tt_2; tt_3; tt_4];
%psi = mod(phi,2*pi); %modulo(raw phase for every 2pi)
%y = psi./pi; %the y axis value
%kai = histogram(y,100,'Normalization','pdf');
%dh = 0.01;
%x = 0:dh:2;
%pdKern_4= fitdist(y(:,25),'kernel');
%kai_4=pdf(pdKern_4,x);
%plot(x,kai,'LineWidth', 2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
x = [0 0.05:0.01:0.1 0.15:0.05:1]; %the amplitude values
y1 = 0:0.01:2;
Z = [kai0' kai1' kai_1' kai_2' kai_3' kai_4' kai2' kai3' kai4' kai6' kai5' kai7' kai8' kai9' kai10' kai11' kai12' kai13' kai14' kai15' kai16' kai17' kai18' kai19' kai20'];
[X,Y] = meshgrid(x,y1);
figure
plot3(X,Y,Z)
figure
contourf(X,Y,Z, 10,'edgecolor', 'none')
shading interp;
colormap jet;
%xlim([0,0.95])
%ylim([0.2,1.2])
%xlabel ('A','interpreter','latex')
%ylabel ('$\tau$','interpreter','latex')
a = colorbar;
%a.Label.String = '\rho';
