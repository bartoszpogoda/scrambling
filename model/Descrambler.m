classdef Descrambler
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Default
        LFSR
    end
    
    methods
        function obj = Descrambler()
            Default  = [0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1];%randi([0 1],1,59);
            obj.LFSR = Default;
        end
        
        function o = scramble(obj, signalToScramble)
            for i = 1:signalToScramble.getSize()
                insertBit = signalToScramble.getBit(i);
                x = xor(obj.LFSR(1,1), xor(obj.LFSR(1,40), obj.LFSR(1,59)));
                x = xor(insertBit, x);
                signalToScramble.setBitV(i, x);

                obj.LFSR = [insertBit, obj.LFSR(1:end-1)];
                
                o = signalToScramble;
            end
            end
                
    end
    
end

