addpath(genpath('model'));

% demo Sygnal
sygnal = Sygnal(10);             % tworzony sygna³ o d³ugoœci 10 bitów
sygnal.setBit(2);                % ustawiony 2-gi bit (wagi 2^1)
sygnal.setBit(7);                % ustawiony 7-dmy bit (wagi 2^6)  
sygnal.setBit(10);               % ustawiony 10-ty bit (wagi 2^9)  
sygnal.clearBit(10);             % wyzerowany 10-ty bit (wagi 2^9) 
sygnal.setBitV(4,1);             % ustawiony 4-ty bit (wagi 2^3)   

% ..0001000010

% próba operacji na bicie spoza tablicy
disp("Sprawdzenie zglaszania bledow:");
sygnal.clearBit(11);             
sygnal.negBit(-2); 
sygnal.setBit(0);      
sygnal.setBitV(2131,1);    
disp(" ");                    

% sprawdzenie ustawienia poszczegolnych bitow
disp("Sprawdzenie ustawienia poszczegolnych bitow:");
disp("Powinno byc 1: " + sygnal.getBit(2));   
disp("Powinno byc 1: " + sygnal.getBit(7));   
disp("Powinno byc 0: " + sygnal.getBit(3));  
disp("Powinno byc 0: " + sygnal.getBit(10));  
disp("Powinno byc 1: " + sygnal.getBit(4));  
disp(" ");                  

% sprawdzenie dzia³ania negacji
disp("Sprawdzenie dzialania negacji:");
disp("Powinno byc 0: " + sygnal.getBit(8)); 
sygnal.negBit(8);  
disp("Powinno byc 1: " + sygnal.getBit(8)); 
sygnal.negBit(8);  
disp("Powinno byc 0: " + sygnal.getBit(8)); 
disp(" ");                  

disp("D³ugoœæ sygna³u: " + sygnal.getSize()); 
disp("Wartoœæ sygna³u: " + sygnal.wartoscSygnalu());    