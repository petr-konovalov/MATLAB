classdef matchingAD < aimDistributor
    
    methods
        function obj = matchingAD(startPos, aimPos)
            if size(startPos) ~= size(aimPos)
                error('Error. \nstartPos size must be equal aimPos size');
            end
            obj = obj.setArrangement(startPos, aimPos);
        end
        
        function distribution = getDistribution(obj)
            obj.g = matchingGraph(size(obj.startPos, 1), size(obj.aimPos, 1));
            for k = 1: obj.g.leftLobeSize
                obj.g.g{k}.ensureCapacity(obj.g.rightLobeSize);
            end
            distribution = zeros(1, obj.g.leftLobeSize);
            
            edgeArr = obj.calcEdgeArr;
            disp(edgeArr);
            edgeArrWorkLen = size(edgeArr, 1);
            isAppointed = zeros(2, obj.g.leftLobeSize);
            for proc = obj.g.leftLobeSize: -1: 2
                l = 0;
                r = edgeArrWorkLen;
                while (r - l > 1)
                    mid = fix((l + r) / 2);
                    for k = 1: obj.g.leftLobeSize 
                        obj.g.g{k}.clear;
                    end
                    for k = 1: mid
                        if ~isAppointed(1, edgeArr(k, 2)) && ~isAppointed(2, edgeArr(k, 3))
                            obj.g.g{edgeArr(k, 2)}.add(edgeArr(k, 3));
                        end
                    end
                    obj.g.calcMaxMatching;
                    if obj.g.getMatchingSize == proc
                        r = mid;
                    else
                        l = mid;
                    end
                end
                edgeArrWorkLen = r;
                match = obj.g.getMatching;
                disp(obj.g.getMatchingSize);
                disp(match);
                maxEdge = [-1 -1];
                maxEdgeLen = 0;
                for k = 1: size(match, 2)
                    if match(k) ~= -1
                        curEdgeLen = norm2(obj.startPos(match(k), :) - obj.aimPos(k, :));
                        if curEdgeLen > maxEdgeLen
                            maxEdge = [match(k), k];
                        end
                    end
                end
                isAppointed(1, maxEdge(1)) = 1;
                isAppointed(2, maxEdge(2)) = 1;
                distribution(maxEdge(1)) = maxEdge(2);
            end
        end
    end
    
    methods (Access = 'private')
        function edgeArr = calcEdgeArr(obj)
            edgeArr = zeros(obj.g.leftLobeSize ^ 2, 3);
            edgeArrIt = 1;
            for j = 1: size(obj.startPos, 1)
                for k = 1: size(obj.aimPos, 1)
                    edgeArr(edgeArrIt, :) = [norm2(obj.startPos(j, :) - obj.aimPos(k, :)), j, k];
                    edgeArrIt = edgeArrIt + 1;
                end
            end
            edgeArr = sortrows(edgeArr);
        end
    end
    
    properties (Access = 'private')
        g;
    end
    
end

function res = norm2(vect)
    res = vect(1) ^ 2 + vect(2) ^ 2;
end

