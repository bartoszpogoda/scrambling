classdef IdealneMedium < handle
    %IdealneMedium klasa reprezentuj¹ca idealne medium transmisji
    %   Transmisja odbywa sie bez zadnych przeklaman
    
    properties
        Zawartosc
    end
    
    methods
        % ...
        function obj = IdealneMedium()
            obj.Zawartosc = [];
        end
        
        % ...
        function przeslij(obj, sygnal)
            if class(sygnal) == "Sygnal" 
                obj.Zawartosc = sygnal;
            else
                disp("Blad: Przesylany obiekt nie jest sygna³em");
            end
        end
        
        % ...
        function o = pobierz(obj)
        	if isempty(obj.Zawartosc)
                o = Sygnal(0);
        	else
                o = obj.Zawartosc;
                obj.Zawartosc = [];
        	end
        end
        
    end
    
end

