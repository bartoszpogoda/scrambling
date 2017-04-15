addpath(genpath('model'));

% demo Sygnal
signal = Signal(10);             % tworzony sygna³ o d³ugoœci 10 bitów
signal.setBit(2);                % ustawiony 2-gi bit (wagi 2^1)
signal.setBit(7);                % ustawiony 7-dmy bit (wagi 2^6)  
signal.setBit(10);               % ustawiony 10-ty bit (wagi 2^9)  
signal.clearBit(10);             % wyzerowany 10-ty bit (wagi 2^9) 
signal.setBitV(4,1);             % ustawiony 4-ty bit (wagi 2^3)   

% ..0001000010

% próba operacji na bicie spoza tablicy
disp("Error report check:");
signal.clearBit(11);             
signal.negBit(-2); 
signal.setBit(0);      
signal.setBitV(2131,1);    
disp(" ");                    

% sprawdzenie ustawienia poszczegolnych bitow
disp("Individual bit set check:");
disp("Should be 1: " + signal.getBit(2));   
disp("Should be 1: " + signal.getBit(7));   
disp("Should be 0: " + signal.getBit(3));  
disp("Should be 0: " + signal.getBit(10));  
disp("Should be 1: " + signal.getBit(4));  
disp(" ");                  

% sprawdzenie dzia³ania negacji
disp("Negation check:");
disp("Should be 0: " + signal.getBit(8)); 
signal.negBit(8);  
disp("Should be 1: " + signal.getBit(8)); 
signal.negBit(8);  
disp("Should be 0: " + signal.getBit(8)); 
disp(" ");                  

disp("Signal size: " + signal.getSize()); 
disp("Signal dec value: " + signal.decValue());    