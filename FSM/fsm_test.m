function fsm_test()
    res = fsm();
    res = res.addState();
    res = res.addTransition(@f1, 1, 2);
    res = res.addTransition(@f2, 2, 1);
    disp(res.curState);
    res = res.execute();
    disp(res.curState);
    res = res.execute();
    disp(res.curState);
    res = res.execute();
    disp(res.curState);
end

function res = f1()
    res = true;
end

function res = f2()
    res = true;
end