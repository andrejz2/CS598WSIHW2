function plot_ant_phases_1_and_2( h1, t1 )

load h_move.mat

ratio_phase_h1 = unwrap(angle(h1(:,1) ./ h1(:,2)));

plot(t1, ratio_phase_h1);

ratio_phase_h2 = unwrap(angle(h2(:,1) ./ h2(:,2)));

plot(t2, ratio_phase_h2);