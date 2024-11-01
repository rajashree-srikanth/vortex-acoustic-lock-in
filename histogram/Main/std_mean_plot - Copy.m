%FINDING MEAN AND SD OF SHEDDING TIME PERIODS FOR ALL TIME PERIODS
%load main_maindata.mat
%Amp = [0 A A_1 A_7 A_3 A_4 A2 A3 A4 A6 A5 A7 A8 A9 0.5 0.55 ... 0.95]
%tt = [tt0 tt1 tt_1 tt_2 tt_3 tt_4 tt2 tt3 tt4 tt6 tt5 tt7 tt8 ... tt20]
%NOTE THE PECULIARITY IN THE ORDER OF VALUES!
tt = [tt0' tt1' tt_1' tt_2' tt_3' tt_4' tt2' tt3' tt4' tt6' tt5' tt7' tt8' tt9' tt10' tt11' tt12' tt13' tt14' tt15' tt16' tt17' tt18' tt19'];
mean_tt = mean(tt);
std_tt = std(tt);
A_int = 0:0.01:0.95;
meani = spline(x, mean_tt, A_int);%interpolate
stdi = spline(x, std_tt, A_int); %interpolation fn
ylabel('$\mu$','interpreter','latex')
xlabel('A','interpreter','latex')
yyaxis left
hold on
plot(A_int, meani, 'linewidth', 1.5)
plot(A_int, meani+stdi, 'm')
yyaxis right
plot(A_int, stdi,'linewidth', 1.5)
ylabel('$\sigma$','interpreter','latex')

