function res = lmda(p, sgm, tau, h)
    prec = tau * (sin(p * pi * h / 2) / h) ^ 2;
    res = (1 - 4 * (1 - sgm) * prec) / (1 + 4 * sgm * prec);
end