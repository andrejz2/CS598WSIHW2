function plot_phase_ant_one( h, t )

load h_static.mat

phase_ant_1 = angle(h(:,1));

plot(t, phase_ant_1);