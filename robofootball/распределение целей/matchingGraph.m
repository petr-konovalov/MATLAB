classdef matchingGraph < handle
    
    properties
        g;
    end
    
    properties (Access = 'private')
        match;
        used;
        taked;
        usedTimer;
    end
    
    methods (Access = 'private')
        function res = dfs(g, v)
            res = false;
            if g.used(v) ~= g.usedTimer
                g.used(v) = g.usedTimer;
                for toId = 0: g.g{v}.size() - 1
                    to = g.g{v}.get(toId);
                    if g.match(to) == -1
                        g.match(to) = v;
                        g.taked(v) = 1;
                        res = true;
                        return;
                    end
                end
                
                for toId = 0: g.g{v}.size() - 1
                    to = g.g{v}.get(toId);
                    if dfs(g, g.match(to))
                        g.match(to) = v;
                        g.taked(v) = 1;
                        res = true;
                        return;
                    end
                end
            end
        end
    end
    
    methods
        function obj = matchingGraph(szl, szr)
            import java.util.ArrayList;
            obj.match = -ones(1, szr);
            obj.taked = zeros(1, szl);
            obj.g = cell(szl, 1);
            for k = 1: szl
                obj.g(k) = ArrayList;
            end
        end
        
        function res = calcMatching(g)
            run = true;
            g.usedTimer = 0;
            g.used = zeros(1, size(g.g, 1));
            g.taked = zeros(1, size(g.g, 1));
            for k = 1: size(g.match, 2)
                g.match(k) = -1;
            end
            while run
                run = false;
                g.usedTimer = g.usedTimer + 1;
                for k = 1: size(g.g, 1)
                    if ~g.taked(k) && dfs(g, k)
                        run = true;
                    end
                end
            end
            res = g.match;
        end
    end
end

