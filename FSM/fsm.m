classdef fsm 
    properties (GetAccess = public, SetAccess = private)
        stateCount = 1;
        curState = 1;
    end
    properties (Access = private)
        cond = {};
        next = {};
    end
    methods (Access = public)
        function obj = addState(obj)
            obj.stateCount = obj.stateCount + 1;
            obj.cond{obj.stateCount} = {};
            obj.next{obj.stateCount} = {};
        end
        function obj = addTransition(obj, condition, fromState, toState)
            if 1 <= fromState && fromState <= obj.stateCount &&...
                1 <= toState && toState <= obj.stateCount
                obj.cond{fromState}{length(obj.cond{fromState})+1} = condition;
                obj.next{fromState}{length(obj.next{fromState})+1} = toState;
            else
                disp('Reference to nonexistent state');
            end
        end
        function obj = execute(obj)
            nextState = 0;
            for k = 1: length(obj.cond{obj.curState})
                if obj.cond{obj.curState}{k}()
                    if nextState == 0
                        nextState = obj.next{obj.curState}{k};
                    else
                        disp('Ambiguous fsm transitions');
                    end
                end
            end
            if nextState ~= 0
                obj.curState = nextState;
            end
        end
        function obj = restart(obj)
            obj.curState = 1;
        end
    end
end