load main_maindata.mat
x = [0 0.05:0.01:0.1 0.15:0.05:0.95];
y = 0:0.01:1.5;
Z = [p0' p1' p_1' p_2' p_3' p_4' p2' p3' p4' p6' p5' p7' p8' p9' p10' p11' p12' p13' p14' p15' p16' p17' p18' p19'];
[X,Y] = meshgrid(x,y);
figure
%plot3(X,Y,Z)
%figure
%surf(X,Y,Z, 'edgecolor', 'none')
contourf(X,Y,Z,50, 'edgecolor', 'none')
shading interp;
colormap jet;
xlim([0,0.95])
ylim([0.2,1.2])
xlabel ('A','interpreter','latex')
ylabel ('$\tau$','interpreter','latex')
a = colorbar;
a.Label.String = '\rho';