clear all; clc;
%global global_info;
%global_info.TOKEN_FIRING_TIME = [];


pns = pnstruct('generator_pdf');
dyn.m0 = {'pJobbUnits', 5, 'pTrigger',1}; % pJobbUnits starts with 5 tokens
pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
%plotp(sim, {'pJobbUnits', 'pTask', 'pExecute', 'pJobbDone',...
 %           'pTrigger'});
prnfinalcolors(sim);