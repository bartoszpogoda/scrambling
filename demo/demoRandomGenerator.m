addpath(genpath('helper'));
addpath(genpath('model'));

randomGen = RandomGenerator();
randomGen.duplProb = 0.5;

signal = randomGen.generate(50);
disp(signal.toString());