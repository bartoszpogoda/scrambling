classdef CustomChannel < Channel
    %CUSTOMCHANNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected, GetAccess = protected)
        singleErrors
    end
    
    methods
        function obj = CustomChannel()
            obj.signal = [];
            obj.singleErrors = [];
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
                % negate all the bits where should be error
                for i = 1 : size(obj.singleErrors)
                    if obj.singleErrors(i) >= 1 && obj.singleErrors(i) <= o.getSize()
                        o.negBit(obj.singleErrors(i));
                    end
                end
                
                obj.signal = [];
        	end
        end
        
        function setSingleErrors(obj, bits)
            obj.singleErrors = bits;
        end
        
        % add error on bit's position in received signal
        function addSingleError(obj, bit)
            obj.singleErrors = [obj.singleErrors; bit];
        end
        
        % clear error on bit's position in received signal
        function deleteSingleError(obj, bit)
            index = find(obj.singleErrors==bit,1);
            obj.singleErrors(index) = [];
        end
        
        function o = singleErrorsToString(obj)
            if size(obj.singleErrors) < 1
               o = string;
               return; 
            end
            
            obj.singleErrors = sort(obj.singleErrors);
            
            o = num2str(obj.singleErrors(1));
            for i = 2 : size(obj.singleErrors)
                o = [o, ' ', num2str(obj.singleErrors(i))];
            end
        end
    end
    
end
