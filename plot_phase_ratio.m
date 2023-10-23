function plot_phase_ratio( h, t )

load h_static.mat

ratio_phase = angle(h(:,1) ./ h(:,2));

plot(t, ratio_phase);