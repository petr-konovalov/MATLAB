function goalX = trapezoidMotion(t, S, V0, Vmax, a)
    if (Vmax^2-V0^2)/(2*a)+Vmax^2/(2*a) <= S
        ta = (Vmax-V0)/a;
        ts = (Vmax-V0)/a+(S-(2*Vmax^2-V0^2)/(2*a))/Vmax;
    else
        ta = (-V0+sqrt(V0^2/2+a*S))/a;
        ts = ta;
        Vmax = V0+a*ta;
    end
    if t <= ta
        goalX = V0*t+0.5*a*t^2;
    elseif t <= ts
        goalX = V0*ta+0.5*a*ta^2+Vmax*(t-ta);
    elseif (t-ts)*a <= Vmax
        goalX = V0*ta+0.5*a*ta^2+Vmax*(ts-ta)+Vmax*(t-ts)-0.5*a*(t-ts)^2;
    else
        goalX = S;
    end
end