classdef fsm < handle
    properties (GetAccess = public, SetAccess = private)
        stateCount = 1;
        curState = 1;
    end
    
    properties (Access = private)
        cond = {};
        next = {};
        actions = {};
    end
    
    methods (Access = public)
        function obj = fsm(stateCount)
            obj.stateCount = stateCount;
            obj.cond = cell(stateCount, 1);
            obj.next = cell(stateCount, 1);
        end
        
        function addTransition(obj, condition, fromState, toState)
            if 1 <= fromState && fromState <= obj.stateCount &&...
                1 <= toState && toState <= obj.stateCount
                obj.cond{fromState}{length(obj.cond{fromState})+1} = condition;
                obj.next{fromState}{length(obj.next{fromState})+1} = toState;
            else
                disp('Reference to nonexistent state');
            end
        end
        
        function associateStateWithAction(obj, state, action)
            if length(obj.actions) >= state && ~isempty(obj.actions{state})
                disp('State action already defined');
            else
                obj.actions{state} = action;
            end    
        end
        
        function res = doAction(obj)
            if length(obj.actions) >= obj.curState && ~isempty(obj.actions{obj.curState})
                res = obj.actions{obj.curState}();
            else
                disp('State action is undefined');
            end
        end
        
        function doTransition(obj, context)
            nextState = obj.curState;
            for k = 1: length(obj.cond{obj.curState})
                if obj.cond{obj.curState}{k}(context)
                    if nextState == obj.curState
                        nextState = obj.next{obj.curState}{k};
                    else
                        disp('Ambiguous fsm transition');
                        break;
                    end
                end
            end
            obj.curState = nextState;
        end
        
        function restart(obj)
            obj.curState = 1;
        end
    end
end