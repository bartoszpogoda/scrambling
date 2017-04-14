addpath(genpath('model'));

% demo IdealneMedium
idealneMedium = IdealneMedium;             % tworzone idealne medium

% proba przeslania blednego sygnalu
idealneMedium.przeslij("string");

% utworzenie poprawnego sygnalu ( 00000010 10000000 00000100 ) = 163 844
% dec
sygnal = Sygnal(3);             
sygnal.getBajt(1).setBit(2);   
sygnal.getBajt(2).setBit(7); 
sygnal.getBajt(3).setBit(1);   
disp("Wartosc sygnalu po stronie nadawcy: " + sygnal.wartoscSygnalu());    

% przeslanie poprawnego sygnalu po stronie nadawcy
idealneMedium.przeslij(sygnal);

% pobranie przeslanego sygnalu po stronie odbiorcy
pobranySygnal = idealneMedium.pobierz();
disp("Wartosc sygnalu po stronie odbiorcy: " + pobranySygnal.wartoscSygnalu());  
  