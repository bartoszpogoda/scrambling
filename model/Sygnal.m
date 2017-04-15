classdef Sygnal < handle
    %SYGNAL klasa reprezentujaca n-bitowy sygnal
    %   bity indeksowane sa od 1 do n
    
    properties (Access = private) 
        bity, n
    end
    
    methods
        % konstruktor tworzy tablice n bitow
        function obj = Sygnal(n)
            if nargin ~= 0
                obj.n = n;
                obj.bity = logical.empty;
                for k = 1 : n
                    obj.bity(k) = false;
                end
            else
                obj.n = 0;
            end
        end
        
        % utworzenie kopii sygnalu
        function o = copy(obj)
            o = Sygnal(obj.n);
            for k = 1 : o.n
            	o.bity(k) = obj.bity(k);
            end
        end
        
        % pobranie dlugosci sygnalu
        function o = getSize(obj)
        	o = obj.n;
        end
        
        % pobranie i-tego bitu sygnalu
        function o = getBit(obj, i)
        	if i >= 1 && i<=obj.n
                if obj.bity(i)
                    o = 1;
            	else
                    o = 0;
                end
            else
                disp("Blad: Sygnal jest " + obj.n + " bitowy!");
                o = [];
        	end
        end
        
        % ustawienie i-tego bitu sygnalu na 1
        function setBit(obj, i)
        	if i >= 1 && i<=obj.n
                obj.bity(i) = true;
            else
                disp("Blad: Sygnal jest " + obj.n + " bitowy!");
        	end
        end
        
        % ustawienie i-tego bitu sygnalu na 0
        function clearBit(obj, i)
        	if i >= 1 && i<=obj.n
                obj.bity(i) = false;
            else
                disp("Blad: Sygnal jest " + obj.n + " bitowy!");
        	end
        end
        
        % negacja i-tego bitu sygnalu
        function negBit(obj, i)
        	if i >= 1 && i<=obj.n
                if obj.bity(i)
                    obj.bity(i) = false;
            	else
                    obj.bity(i) = true;
                end
            else
                disp("Blad: Sygnal jest " + obj.n + " bitowy!");
        	end
        end
         
        % ustawienie i-tego bitu sygnalu na wartosc v
        function setBitV(obj, i, v)
        	if v == 0
                obj.clearBit(i);
        	else
                obj.setBit(i);
        	end
        end
        
        % obliczenie wartosci sygnalu
        function o = wartoscSygnalu(obj)
            o = 0;
        	for i = 1 : obj.n
                o = o + (2^(i-1))*(obj.getBit(i));
        	end
        end
        
        function disp(obj)
            disp(obj.bity);
        end
       
    end
    
end

