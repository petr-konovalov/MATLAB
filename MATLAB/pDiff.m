function nFunc = pDiff(func, x)
    syms sx;
    nFunc = subs(func, x, sx);
    nFunc = diff(nFunc, sx);
    nFunc = simplify(subs(nFunc, sx, x));
end