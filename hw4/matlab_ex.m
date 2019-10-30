G1 = tf([1],[1 4 25])
G2 = tf([1 0],[1 4 25])
% G4 = tf([1 0 0 0],[1 4 25])

figure(1); clf
if 1
    step(G1); hold on
    step(G2);

elseif 0
    G5 = tf([0 1 1], [1 4 25])
    G6 = tf([0 0.5 1], [1 4 25])
    G7 = tf([0 0 1], [1 4 25])
    G8 = tf([0 -0.5 1], [1 4 25])
    G9 = tf([0 -1 1], [1 4 25])
    step(G5); hold on
    step(G6); hold on
    step(G7); hold on
    step(G8); hold on
    step(G9);
end