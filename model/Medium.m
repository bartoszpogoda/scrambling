classdef Medium < handle
    %MEDIUM klasa abstrakcyjna dla roznych implementacji mediow transmisji
    
    properties (SetAccess = protected, GetAccess = protected)
        zawartosc
    end
    
    methods (Abstract)
        przeslij(obj, sygnal)
        o = pobierz(obj)
    end
    
end

