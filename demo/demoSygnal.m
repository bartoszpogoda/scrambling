addpath(genpath('model'));

% demo Sygnal
sygnal = Sygnal(4);             % tworzony sygna� o d�ugo�ci 4 bajt�w
sygnal.getBajt(1).setBit(2);    % ustawiony drugi bit 1 bajtu

% sprawdzenie ustawienia drugiego bitu 1 bajtu
disp("Powinno byc 1: " + sygnal.getBajt(1).getBit(2));     