classdef Sygnal < handle
    %SYGNAL klasa reprezentuj�ca n-bajtowy sygna�
    %   operacje na poszczeg�lnych bajtach s� umo�liwione poprzez
    %   pobieranie ich metod� getBajt. Bajty indeksowane s� od 1 do n
    
    properties (Access = private) 
        Bajty, n
    end
    
    methods
        % konstruktor tworzy tablice n bajtow
        function obj = Sygnal(n)
            if nargin ~= 0
                obj.n = n;
                obj.Bajty = BajtDanych.empty;
                for k = 1 : n
                    obj.Bajty(k) = BajtDanych;
                end
            else
                obj.n = 0;
            end
        end
        
        % pobranie i-tego bajtu sygnalu
        function o = getBajt(obj, i)
        	if i >= 1 && i<=obj.n
                o = obj.Bajty(i);
            else
                disp("Blad: Nie ma takiego bajtu w sygnale");
                o = [];
        	end
        end
        
        % obliczenie wartosci sygnalu
        function o = wartoscSygnalu(obj)
            o = 0;
        	for i = 1 : obj.n
                o = o + (2^(8*(i-1)))*double(obj.Bajty(i).getBajt());
        	end
        end
        
    end
    
end

