classdef BSChannel < Channel
    
    properties
        probability % crossover probability
    end
    
    methods
        function obj = BSChannel()
            obj.signal = [];
            obj.probability = 0;
        end
        
        function send(obj, signal)
            if class(signal) == "Signal" 
                obj.signal = signal.copy;
            else
                disp("Error: Object to be sent is not Signal");
            end
        end
        
        % applying errors here
        function o = receive(obj)
        	if isempty(obj.signal)
                o = Signal(0);
        	else
                o = obj.signal;
                
                for i = 1 : o.getSize();
                    if rand < obj.probability
                        o.negBit(i);
                    end
                end
                
                obj.signal = [];
        	end
        end
        
        % probably not needed
        function o = probabilityToString(obj)
            o = num2str(obj.probability, 3);
        end
    end
    
end
