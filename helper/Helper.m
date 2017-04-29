classdef Helper
    %HELPER class containg some helper methods
    
    methods (Static)
        function o = appendToAlign64(signal)
            currentSize = signal.getSize();
            newSize = 64 * (floor((currentSize-1)/64) + 1);
            o = Signal(newSize);
            
            for i = 1 : currentSize
                o.setBitV(i, signal.getBit(i));
            end
            
            % for i = currentSize + 1 : newSize
            %     obj.clearBit(i)
            % end
        end
        
        function o = calculateBER(signalA, signalB)
            sizeDifference = max(signalA.getSize(), signalB.getSize()) - min(signalA.getSize(), signalB.getSize());

            allBits = max(signalA.getSize(), signalB.getSize());
            incorrectBits = sizeDifference;
            
            for i = 1 : min(signalA.getSize(), signalB.getSize())
                if signalA.getBit(i) ~= signalB.getBit(i)
                    incorrectBits = incorrectBits + 1;
                end
            end
            
            o = incorrectBits/allBits;
        end
        
        function o = randSignal(signalSize)
            o = Signal(signalSize);
            for i = 1 : signalSize 
                if round(rand())
                    o.setBit(i);
                end
            end
        end
        
    end
    
end
