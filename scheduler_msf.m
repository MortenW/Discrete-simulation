clear all; clc;
global global_info;
global_info.STOP_AT = 30;
global_info.counter = 1;
global_info.counter_processor = 1;
global_info.i = 1;
global_info.prev_job_id = 1;
global_info.colors = {{'at:1', 'unit_id:1', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:2', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:3', 'total:3','job_id:1'},...
{'at:2', 'unit_id:1', 'total:2','job_id:2'},...
{'at:2', 'unit_id:2', 'total:2','job_id:2'}};

global_info.remaining_units = sort_on_length(global_info.colors);

global_info.algorithm = 'rr';

pns = pnstruct('generator_pdf');
dyn.m0 = {'pJobUnits', 5, 'pReady',1}; % pJobbUnits starts with 5 tokens
dyn.ft = {'tProcess', 1, 'tColorizer', 0.1, 'tRemove', 0.1,...
           'tCs', 3, 'allothers',1};

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
%plotp(sim, {'pJobbUnits', 'pTask', 'pExecute', 'pJobbDone',...
 %           'pTrigger'});
prnfinalcolors(sim);