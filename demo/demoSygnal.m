addpath(genpath('model'));

% demo Sygnal
sygnal = Sygnal(3);             % tworzony sygna³ o d³ugoœci 3 bajtów
sygnal.getBajt(1).setBit(2);    % ustawiony bit wagi 2 - 1 bajtu
sygnal.getBajt(2).setBit(7);    % ustawiony bit wagi 7 - 2 bajtu     
sygnal.getBajt(3).setBit(1);    % ustawiony bit wagi 1 - 3 bajtu

% 00000010 10000000 00000100

% sprawdzenie ustawienia poszczegolnych bajtow
disp("Powinno byc 1: " + sygnal.getBajt(1).getBit(2));   
disp("Powinno byc 1: " + sygnal.getBajt(2).getBit(7));  
disp("Powinno byc 1: " + sygnal.getBajt(3).getBit(1));  
disp("Powinno byc 0: " + sygnal.getBajt(3).getBit(2));  

disp("Wartosc sygnalu: " + sygnal.wartoscSygnalu());    