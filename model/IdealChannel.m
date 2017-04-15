classdef IdealChannel < Channel
    %IdealChannel representation of ideal transmission channel
    %   There are no bit errors
    
    methods
        function obj = IdealChannel()
            obj.signal = [];
        end
        
        function send(obj, signal)
            if class(signal) == "Signal" 
                obj.signal = signal.copy;
            else
                disp("Error: Object to be sent is not Signal");
            end
        end
        
        function o = receive(obj)
        	if isempty(obj.signal)
                o = Signal(0);
        	else
                o = obj.signal;
                obj.signal = [];
        	end
        end
        
    end
    
end

