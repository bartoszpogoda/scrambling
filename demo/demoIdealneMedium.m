addpath(genpath('model'));

% demo IdealneMedium
idealneMedium = IdealneMedium;             % tworzone idealne medium

% proba przeslania blednego sygnalu
disp("Sprawdzenie zglaszania bledow:");
idealneMedium.przeslij("string");
disp(" ");

% utworzenie poprawnego sygnalu ( 00000010 10000000 00000100 ) = 163 844
% dec
disp("Sprawdzenie poprawnosci przeslania sygnalu:");
sygnalNadawca = Sygnal(24);             
sygnalNadawca.setBit(3);   
sygnalNadawca.setBit(16); 
sygnalNadawca.setBit(18) 
disp("Wartosc sygnalu po stronie nadawcy: " + sygnalNadawca.wartoscSygnalu());    

% przeslanie poprawnego sygnalu po stronie nadawcy
idealneMedium.przeslij(sygnalNadawca);

% pobranie przeslanego sygnalu po stronie odbiorcy
sygnalOdbiorca = idealneMedium.pobierz();
disp("Wartosc sygnalu po stronie odbiorcy: " + sygnalOdbiorca.wartoscSygnalu());
disp(" ");

% zmiana sygna³u po stronie nadawcy nie powinna wywo³aæ zmiany u odbiorcy
disp("Sprawdzenie po zmianie sygnalu u odbiorcy:");
sygnalNadawca.setBit(4);
disp("Wartosc sygnalu po zmianie po stronie nadawcy: " + sygnalNadawca.wartoscSygnalu()); 
disp("Wartosc sygnalu po zmianie po stronie odbiorcy: " + sygnalOdbiorca.wartoscSygnalu()); 
  