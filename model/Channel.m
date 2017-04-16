classdef Channel < handle
    %Channel abstract class for transmission channels
    
    properties (SetAccess = protected, GetAccess = protected)
        signal
    end
    
    methods (Abstract)
        send(obj, sygnal)
        receive(obj)
    end
    
    methods
        function disp(obj)
            disp("In channel: ");
            if isempty(obj.signal)
                disp("empty");
            else
                obj.signal.disp();
            end
        end
    end
    
end

