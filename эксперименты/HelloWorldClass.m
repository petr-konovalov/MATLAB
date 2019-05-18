classdef HelloWorldClass
    
    properties
        a;
        b;
    end
    
    methods 
        function obj = HelloWorldClass(a, b)
            obj.a = a;
            obj.b = b;
        end
        function out = sum(obj)
            out = obj.a + obj.b;
        end
        function obj = setAB(obj, a, b)
            obj.a = a;
            obj.b = b;
        end
    end
    
    methods (Static)
        function print()
            disp('Hello world!!!');
        end
    end
    
end

