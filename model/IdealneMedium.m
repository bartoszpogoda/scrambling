classdef IdealneMedium < Medium
    %IdealneMedium klasa reprezentuj¹ca idealne medium transmisji
    %   Transmisja odbywa sie bez zadnych przeklaman
    
    methods
        % ...
        function obj = IdealneMedium()
            obj.zawartosc = [];
        end
        
        % ...
        function przeslij(obj, sygnal)
            if class(sygnal) == "Sygnal" 
                obj.zawartosc = sygnal.copy;
            else
                disp("Blad: Przesylany obiekt nie jest sygna³em");
            end
        end
        
        % ...
        function o = pobierz(obj)
        	if isempty(obj.zawartosc)
                o = Sygnal(0);
        	else
                o = obj.zawartosc;
                obj.zawartosc = [];
        	end
        end
        
    end
    
end

