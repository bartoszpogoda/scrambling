classdef EthernetCoder < handle
    %ETHERNETCODER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods  
       
        %signalToCode argument is 64 bit 
        function encodedSignal = encode(signalToEncode)
            
            %variable to hold number of frames in the primary signal
            numberOfFrames = signalToEncode.getSize() / 64;
               
            %new length of the encoded signal (e.g. for 128 bits it will expand to 132 bits)
            encodedSignal = signalToEncode.getSize() + numberOfFrames * 2;  
            
            %adds '01' before every frame of the input signal(64 bits length)
            for i = 1 : 66 : encodedSignal.getSize()
            
                encodedSignal.clearBit(i); %sets 0 o on the 2^i position
                encodedSignal.setBit(i);   %sets 1 on the 2^i position
                
                %set all the bits
                for j = i + 2 : i + 66
                    encodedSignal.setBitV(j, signalToEncode.getBit(j - 2 * i));
                end
            end
            %return
            encodedSignal = signalToEncode; 
        end 
    end
end

