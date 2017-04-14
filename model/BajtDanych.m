classdef BajtDanych < handle
    %BAJTDANYCH Klasa obudowuj¹ca 8-bitów danych
    %   wraz z funkcjami do operacji na pojedyñczych bitach - narazie
    %   zapewnienie dostêpu i ustawiania bitów na 1/0
    
    properties (Access = private) 
    	Bajt
    end
    
    methods
        % konstruktor ustawia bajt na 0
    	function obj = BajtDanych()
        	obj.Bajt = uint8(0);
        end
        
        % pobranie i-tego bitu z bajtu
        function o = getBit(obj, i)
        	maska = bitshift(1,i);
            if bitand(maska, obj.Bajt) == 0
                o = 0;
        	else
                o = 1;
            end
        end
        
        % ustawienie bitu o i-tej wadze na wartoœæ 1
        function setBit(obj, i)
           maska = uint8(bitshift(1,i));
           obj.Bajt = bitor(obj.Bajt, maska);
        end
        
        % ustawienie bitu o i-tej wadze na wartoœæ 0
        function clearBit(obj, i)
           maska = uint8(bitshift(1,i));
           maska = bitcmp(maska);
           obj.Bajt = bitand(obj.Bajt, maska);
        end
        
        % ustawienie i-tego bitu na wartoœæ v
        function setBitV(obj, i, v)
           if v == 0 
               obj.clearBit(i)
           else
               obj.setBit(i)
           end
        end
        
        % pobranie ca³ego bajtu
        function o = getBajt(obj)
        	o = obj.Bajt;
        end
        
    end
    
end

