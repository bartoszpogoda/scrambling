classdef CustomChannel < IdealChannel
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = CustomChannel()
            obj.signal = [];
        end
        
        function changeSingleBits(obj, array)
            for i=1 : length(array)
                obj.signal.negBit(array(i));
            end
        end
        
        
    end
    
end

