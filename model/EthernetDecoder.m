classdef EthernetDecoder < handle
    %ETHERNETDECODER Summary of this class goes here
    
    properties (Access = private)
        errorFlag, badFrameIndex
    end
    
    methods
        function decodedSignal = decode(obj, signal)
            % clear previous error flag
            obj.errorFlag = false;
            obj.badFrameIndex = -1;
            
            signalSize = signal.getSize();
            numberOfFrames = floor(signalSize/66);
            
            decodedSignal = Signal(numberOfFrames*64);
            
            % holds decodedSignal iterator index
            k = 1;      
            currentFrame = 1;
            for i = 1 : 66 : signalSize - 65
                % check for preamble
                if signal.getBit(i) ~= 0 || signal.getBit(i+1) ~= 1
                    obj.errorFlag = true;
                    obj.badFrameIndex = currentFrame;
                    return;
                end
                    
                %copy all the (64 bit length) frame bits
                for j = i + 2 : i + 65
                    decodedSignal.setBitV(k, signal.getBit(j));
                    k = k + 1;
                end
                currentFrame = currentFrame + 1;
            end
        end
        
        function o = wasGood(obj)
            o = not(obj.errorFlag);
        end
        
        function o = badFrame(obj)
            o = obj.badFrameIndex;
        end
        
    end
    
end

