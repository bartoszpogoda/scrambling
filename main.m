%dziêki temu skrypty z widoki/ s¹ widoczne
addpath(genpath('widoki'));

%odpalenie g³ównego widoku aplikacji - czyli wywolanie funkcji
%zdefiniowanej w glownyWidok.m, która z kolei odpala figure
%glownyWidok.fig, stworzon¹ przy pomocy GUIDE (lewym na glownyWidok.fig i
%edytuj w GUIDE)
glownyWidok();

% demo BajtDanych
bajt = BajtDanych();    % inicjowany jest zerem
bajt.setBit(2);         % ustawia drugi bit w sekwencji na 1
bajt.getBit(2)          % zwroci do Command Window 1, poniewa¿ bit zosta³ ustawiony
bajt.clearBit(2);       % ustawia drugi bit w sekwencji na 0
bajt.getBit(2)          % zwroci do Command Window 0, poniewa¿ bit zosta³ wyczyszczony
bajt.setBitV(1,1);      % ustawi pierwszy bit na 1
bajt.setBitV(5,1);      % ustawi pi¹ty bit na 1
bajt.setBitV(5,0);      % wyczyœci pi¹ty bit
bajt                    % wypisze obiekt, z zawartoœci¹ Bajtu czyli 2 (01000000)


