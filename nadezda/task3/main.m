A = [-1 0 0; 0 -1 0; 0 0 -1];
B = [-0.1; -0.2; -0.3];
C = [-0.4 -0.5 0];
D = -0.1;

n = size(A, 1);
p = size(D, 1);

eps = 1e-6;

cvx_clear;
cvx_begin sdp
    variable H(n, n) symmetric
    H >= eye(n, n)*eps
    [H*A+A'*H+C'*C H*B+C'*D; B'*H+D'*C D'*D-eye(p,p)] <= -eye(n+p, n+p)*eps
cvx_end
