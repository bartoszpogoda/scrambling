classdef CustomChannel < Channel
    %CUSTOMCHANNEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (SetAccess = protected, GetAccess = protected)
        singleErrors, periodicNumOfBits, periodicInterval, periodicStart
    end
    
	methods (Access = private)
        function applySingleErrors(obj, signal)
            for i = 1 : size(obj.singleErrors)
                if obj.singleErrors(i) >= 1 && obj.singleErrors(i) <= signal.getSize()
                    signal.negBit(obj.singleErrors(i));
                end
            end		
        end
        
        function applyPeriodicErrors(obj, signal)
            if obj.periodicNumOfBits == 0
                return;
            end
            % Below Sebastian's algorithm
            intervalFlag = false; 
            tmp = 0;
            
            for i=1 : signal.getSize()
                if i >= obj.periodicStart
                    if intervalFlag
                        tmp = tmp+1;
                        if tmp == (obj.periodicInterval)
                            intervalFlag = false;
                            tmp = 0;
                        end
                    else
                        if tmp ~= obj.periodicNumOfBits
                            signal.negBit(i);
                            tmp = tmp+1;
                        end
                        if tmp == obj.periodicNumOfBits
                            intervalFlag = true;
                            tmp = 0;
                        end
                    end
                end
            end
        end
	end
    
    methods
        function obj = CustomChannel()
            obj.signal = [];
            obj.singleErrors = [];
            obj.periodicNumOfBits = 0;
            obj.periodicInterval = 0;
            obj.periodicStart = 1;
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
                
                obj.applyPeriodicErrors(o);
                obj.applySingleErrors(o);
                
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
        
        function setPeriodicNumOfBits(obj, periodicNumOfBits)
            obj.periodicNumOfBits = periodicNumOfBits;
        end
        
        function setPeriodicInterval(obj, periodicInterval)
            obj.periodicInterval = periodicInterval;
        end
        
        function setPeriodicStart(obj, periodicStart)
            obj.periodicStart = periodicStart;
        end
        
        function o = getPeriodicNumOfBits(obj)
            o = obj.periodicNumOfBits;
        end
        
        function o = getPeriodicInterval(obj)
            o = obj.periodicInterval;
        end
        
        function o = getPeriodicStart(obj)
            o = obj.periodicStart;
        end
        
    end
end
