classdef EthernetCoder < handle
    %ETHERNETCODER Summary of this class goes here
    
    methods  
        %signalToCode argument's size is 64 bit aligned 
        function encodedSignal = encode(~, signalToEncode)
            
            %variable to hold number of frames in the primary signal
            numberOfFrames = signalToEncode.getSize() / 64;
               
            %new length of the encoded signal (e.g. for 128 bits it will expand to 132 bits)
            encodedSignal = Signal(signalToEncode.getSize() + numberOfFrames * 2);  
            
            % holds signalToEncode iterator index - changes from 1 to signalToEncode.getSize()
            k = 1;      
            
            for i = 1 : 66 : encodedSignal.getSize() - 65
            
                %adds '01' before every (64 bit length) frame of the input signal
                encodedSignal.clearBit(i);   %sets i bit to 0
                encodedSignal.setBit(i+1);   %sets i+1 bit to 1
                
                %copy all the (64 bit length) frame bits
                for j = i + 2 : i + 65
                    encodedSignal.setBitV(j, signalToEncode.getBit(k));
                    k = k + 1;
                end
            end
        end 
        
    end
    
end

