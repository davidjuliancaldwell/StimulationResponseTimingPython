% first load in the MATLAB file as a table 

load('resultTrimTable.mat')

% sid of interest, experiment, block
sid = 'acabb1';
experiment = 'tactor';
block = 1;

rows = find(strcmp(sid,resultTrim.sid)&strcmp(experiment,resultTrim.experiment)&resultTrim.block==block);

responseTimeSubj = resultTrim{rows,'responsetimems'};