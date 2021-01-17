function fsm_test()
    res = fsm(3);
    context = 1;
    res.addTransition(@f12, 1, 2);
    res.addTransition(@f13, 1, 3);
    res.addTransition(@f21, 2, 1);
    res.addTransition(@f32, 3, 2);
    res.associateStateWithAction(1, @state1Action);
    res.associateStateWithAction(2, @state2Action);
    res.associateStateWithAction(3, @state3Action);
    for k = 1:25
        disp(res.doAction());
        res.doTransition(context);
        if res.curState == 1
            context = mod(context + 1, 3);
        end
    end
end

function res = f12(context)
    res = context == 1;
end

function res = f13(context)
    res = context == 2;
end

function res = f21(context)
    res = true;
end

function res = f32(context)
    res = true;
end

function res = state1Action()
    res = 'its State 1';
end

function res = state2Action()
    res = 'its State 2';
end


function res = state3Action()
    res = 'its State 3';
end
