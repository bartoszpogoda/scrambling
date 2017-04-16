classdef Descrambler < handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties (Access = private)
        seed
        LFSR
    end
    
    methods
        function obj = Descrambler(seed)
            if(nargin == 0)
                obj.seed  = [0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 1, 1, 1];%randi([0 1],1,59);
                obj.LFSR = obj.seed;
            else
                obj.seed = seed;
                obj.LFSR = seed;
            end
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
        
        function disp(obj)
            disp("Descrambler LFSR");
            disp(obj.LFSR);
        end
        
        function resetLFSR(obj)
            obj.LFSR = Seed;
        end
        
    end
    
end

