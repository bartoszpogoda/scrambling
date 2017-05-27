classdef EthernetDecoder < handle
    %ETHERNETDECODER Summary of this class goes here
    
    properties (Access = private)
        errorFlag, badFrameIndex,
        resyncPreamblesToCheck = 3, % number of preambles to check both to the left and right side
        resyncPreambleCheckRange = 3
    end
    
    methods
        function dataIndex = resync(obj, signal, badFrameIndex)
            % scores for preambles are 0, and they are not yet found so
            % indexex are -1
            potentialPreamblesScores = zeros(1,2*obj.resyncPreamblesToCheck);
            potentialPreamblesIndexes = zeros(1,2*obj.resyncPreamblesToCheck);
            
            for i = 1 : 2*obj.resyncPreamblesToCheck
                potentialPreamblesIndexes(i) = -1;
            end
            
            % go left
            iterator = badFrameIndex - 1;
            foundPreamblesLeft = 0;
            
            while iterator >= 1 && foundPreamblesLeft ~= obj.resyncPreamblesToCheck
                while ~(signal.getBit(iterator) == 0 && signal.getBit(iterator+1)) && iterator >= 1
                    iterator = iterator - 1;
                end
                
                if iterator >= 1
                    % found '01' preamble
                    foundPreamblesLeft = foundPreamblesLeft + 1;
                    potentialPreamblesIndexes(foundPreamblesLeft) = iterator;
                    
                    % score logic
                    score = 53151531531;
                    
                    % save score
                    potentialPreamblesScores(foundPreamblesLeft) = score;
                    
                    iterator = iterator - 1;
                end
            end
            
            % go right
            iterator = badFrameIndex + 1;
            foundPreamblesRight = 0;
            
            while iterator < signal.getSize() && foundPreamblesRight ~= obj.resyncPreamblesToCheck
                while iterator < signal.getSize() && ~(signal.getBit(iterator) == 0 && signal.getBit(iterator+1)) 
                    iterator = iterator + 1;
                end
                
                if iterator < signal.getSize()
                    % found '01' preamble
                    foundPreamblesRight = foundPreamblesRight + 1;
                    potentialPreamblesIndexes(foundPreamblesRight + foundPreamblesLeft) = iterator;
                    
                    % score logic
                    score = 53151531531;
                    
                    % save score
                    potentialPreamblesScores(foundPreamblesRight + foundPreamblesLeft) = score;
                    
                    iterator = iterator + 1;
                end
            end
            
            
            potentialPreamblesIndexes
            
            dataIndex = 12141512;
        end
        
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
                    obj.badFrameIndex = i;
                    
                    %dbg---
                    obj.resync(signal, i);
                    %dbg---
                    
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

