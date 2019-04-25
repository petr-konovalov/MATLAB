p = 0.02;
w = 2500;
K = (1-p)/p;
T = (1+K)/w;
H = tf([K], [T^2, 2*T, K+1]);
W = tf([0.005 0.55 5], [0.001 0.66 11]);
CW = tf([K], [T^2, 2*T, 1]);
C = CW / W;
bode(H);