classdef CustomChannel < Channel
    
    properties 
        singleErrors, periodicNumOfBits, periodicInterval, periodicStart,
        desyncBreakpoint, desyncType % type 1 - add, 0 - none, -1 - delete, 2 - random
    end
    
	methods (Access = private)
        function applySingleErrors(obj, signal)
            for i = 1 : size(obj.singleErrors)
                if obj.singleErrors(i) <= -1 && obj.singleErrors(i) >= -(signal.getSize())
                    signal.negBit(signal.getSize() + obj.singleErrors(i) + 1);
                elseif obj.singleErrors(i) >= 1 && obj.singleErrors(i) <= signal.getSize()
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
                        if tmp == obj.periodicInterval
                            intervalFlag = false;
                            tmp = 0;
                        elseif tmp > obj.periodicInterval
                            % interval was 0
                            signal.negBit(i);
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
        
        function applyDesyncErrors(obj, signal)
            if obj.desyncType == 0 || obj.desyncBreakpoint == 0
                return;
            end
            
            repeatState = -1; 
            repeatCounter = 0;
            
            i = 1;
            while i <= signal.getSize()
                if signal.getBit(i) == repeatState
                   repeatCounter = repeatCounter + 1; 
                else
                   repeatCounter = 0;
                end
                
                if repeatCounter == 0 
                    repeatState = signal.getBit(i);
                    repeatCounter = repeatCounter + 1;
                end
                
                if repeatCounter == obj.desyncBreakpoint
                    if obj.desyncType == 1
                        % add one more 0 or 1
                        signal.insertBit(i, repeatState);
                        i = i+1; % fix loop
                    elseif obj.desyncType == -1
                        % delete one bit
                        signal.removeBit(i);
                        i = i-1; % fix loop
                    elseif obj.desyncType == 2
                        % random
                        if round(rand())
                            signal.insertBit(i, repeatState);
                            i = i+1; % fix loop
                        else
                            signal.removeBit(i);
                            i = i-1; % fix loop
                        end
                    end
                    
                    repeatCounter = 0;
                end
                i = i + 1;
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
            obj.desyncType = 0;
            obj.desyncBreakpoint = 0;
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
                obj.applyDesyncErrors(o);
                
                obj.signal = [];
        	end
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
