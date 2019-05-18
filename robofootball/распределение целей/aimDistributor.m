%aim distributor interface
classdef (Abstract) aimDistributor
    
    properties (Access = 'protected')
        startPos;
        aimPos;
    end
    
    methods (Abstract)
        distribution = getDistribution(obj)
    end
    
end

