clear all; clc;
global global_info;
%global_info.TOKEN_FIRING_TIME = [];
global_info.counter = 1;
global_info.counter_processor = 1;
global_info.i = 1;
global_info.colors = {{'at:1', 'unit_id:1', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:2', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:3', 'total:3','job_id:1'},...
{'at:2', 'unit_id:1', 'total:2','job_id:2'},...
{'at:2', 'unit_id:2', 'total:2','job_id:2'}};

global_info.algorithm = 'rr';

pns = pnstruct('generator_pdf');
dyn.m0 = {'pJobbUnits', 5, 'pTrigger',1}; % pJobbUnits starts with 5 tokens
dyn.ft = {'allothers',1};

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
%plotp(sim, {'pJobbUnits', 'pTask', 'pExecute', 'pJobbDone',...
 %           'pTrigger'});
prnfinalcolors(sim);