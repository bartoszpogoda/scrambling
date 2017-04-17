classdef Helper
    %HELPER class containg some helper methods
    
    methods (Static)
        function obj = appendToAlign64(signal)
            currentSize = signal.getSize();
            newSize = 64 * (floor((currentSize-1)/64) + 1);
            obj = Signal(newSize);
            
            for i = 1 : currentSize
                obj.setBitV(i, signal.getBit(i));
            end
            
            % for i = currentSize + 1 : newSize
            %     obj.clearBit(i)
            % end
        end
        
    end
    
end

