classdef BSChannel < Channel
    %BSCHANNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected, GetAccess = protected)
        p % crossover probability
    end
    
    methods
        function obj = BSChannel()
            obj.signal = [];
            obj.p = 0;
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
                    if rand < obj.p
                        o.negBit(i);
                    end
                end
                
                obj.signal = [];
        	end
        end
        
        function setProbability(obj, probability)
            obj.p = probability;
        end
        
        function o = getProbability(obj)
            o = obj.p;
        end
        
        % probably not needed
        function o = probabilityToString(obj)
            o = num2str(obj.p, 3);
        end
    end
    
end
