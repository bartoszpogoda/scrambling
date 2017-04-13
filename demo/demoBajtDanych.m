addpath(genpath('model'));

% demo BajtDanych
bajt = BajtDanych();    % inicjowany jest zerem
bajt.setBit(2);         % ustawia drugi bit w sekwencji na 1

disp("Zawarto�� 2 bitu po ustawieniu: " + bajt.getBit(2));

bajt.clearBit(2);       % ustawia drugi bit w sekwencji na 0

disp("Zawarto�� 2 bitu po wyczyszczeniu: " + bajt.getBit(2)); 

bajt.setBitV(1,1);      % ustawi pierwszy bit na 1
bajt.setBitV(5,1);      % ustawi pi�ty bit na 1
bajt.setBitV(5,0);      % wyczy�ci pi�ty bit

disp("Zawarto�� bajtu dziesi�tnie (00000010): " + bajt.getBajt());          
