function goalV = trapezoidMotionSpeed(t, S, V0, Vmax, a)
    ts = (Vmax-V0)/a+(S-(2*Vmax^2-V0^2)/(2*a))/Vmax;
    goalV = max(min(min(V0+a*t, Vmax), Vmax-(t-ts)*a), 0);
end