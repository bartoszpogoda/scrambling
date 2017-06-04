addpath(genpath('helper'));
addpath(genpath('model'));

randomGen = RandomGenerator();
randomGen.mode = 1;
randomGen.duplProb = 0.7;

signal = randomGen.generate(50);
signal