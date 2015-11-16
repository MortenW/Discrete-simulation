clear all; clc;
global global_info;
% #### USER SETTINGS #### %
global_info.algorithm = 'fcfs';
global_info.jobs_file = 'job_generator/job_units_short.txt';
global_info.time_quantum = 3;
% ####################### %

global_info.STOP_AT = 10000;
global_info.counter = 1;
global_info.counter_processor = 1;
global_info.job_id = 1;
global_info.prev_job_id = 0;
global_info.units_done = 1;
global_info.number = 0 ;
global_info.prev_at = 1;
global_info.counter_cs = 0;
global_info.number_of_jobs_ncs = 0;
global_info.number_of_jobs_cs = 0;
file = strcat('output/', global_info.algorithm,'_result_wt.txt');
fileID = fopen(file, 'w');

global_info.colors = {{'at:1', 'unit_id:1', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:2', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:3', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:4', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:5', 'total:5','job_id:1'},...
 {'at:2', 'unit_id:1', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:2', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:3', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:4', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:5', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:6', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:7', 'total:8','job_id:2'},...
 {'at:2', 'unit_id:8', 'total:8','job_id:2'},...
 {'at:3', 'unit_id:1', 'total:5','job_id:3'},...
 {'at:3', 'unit_id:2', 'total:5','job_id:3'},...
 {'at:3', 'unit_id:3', 'total:5','job_id:3'},...
 {'at:3', 'unit_id:4', 'total:5','job_id:3'},...
 {'at:3', 'unit_id:5', 'total:5','job_id:3'},...
 {'at:4', 'unit_id:1', 'total:3','job_id:4'},...
 {'at:4', 'unit_id:2', 'total:3','job_id:4'},...
 {'at:4', 'unit_id:3', 'total:3','job_id:4'}};


disp('Loading jobs from file ...');
%global_info.colors = get_jobs_from_file(global_info.jobs_file);
disp('All jobs loaded');

jobs = number_of_jobs(global_info.colors);
for n = 1:jobs,
    global_info.waiting_time(n) = 0;
 end

disp('Sorting jobs on length ...');
global_info.remaining_units = sort_on_length(global_info.colors);
disp('Done');

pns = pnstruct('generator_pdf');
dyn.m0 = {'pJobUnits', length(global_info.remaining_units), 'pReady',1};
dyn.ft = {'tProcess', 0.1, 'tColorizer', 0.1, 'tColorRemover', 0.01,...
           'tCs', 0.7, 'tNcs',0.5, 'allothers', 0.1};

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, {'pJobUnits', 'pReadyQueue', 'pExecute', 'pJobUnitDone',...
            'pTrigger'});
prnfinalcolors(sim);

occupancy_matrix = occupancy(sim, {'tNcs'});
disp(occupancy_matrix);
occupancy_matrix = occupancy(sim, {'tCs'});
disp(occupancy_matrix);

duration_matrix_ncs = extractt(sim, {'tNcs'});
disp('duration_matrix');
disp(duration_matrix_ncs(1,2));
disp(duration_matrix_ncs);

duration_matrix_cs = extractt(sim, {'tCs'});
disp('duration_matrix');
disp(duration_matrix_cs(1,2));
disp(duration_matrix_cs);


%{
The section calculate the average execution time.
It also writes to result to file
%}
sum = 0;
for n = 1:length(global_info.job_execution_time),
    sum = sum + global_info.job_execution_time(n);
    fprintf(fileID,'%12.8f\r\n' ,global_info.job_execution_time(n));

end
%average
disp('Execution time');
average = sum / length(global_info.job_execution_time);
disp(average);
fprintf(fileID,'%12s\r\n' ,'avg:');
fprintf(fileID,'%12.8f\r\n' ,average);

disp('finish time for each job');
disp(global_info.job_execution_time);

% write start time for transition Ncs
fprintf(fileID,'%12s\r\n' ,'no_context_switch_started_after:');
fprintf(fileID,'%12.8f\r\n' ,duration_matrix_ncs(1,2));

% write start time for transition cs
fprintf(fileID,'%12s\r\n' ,'context_switch_started_after:');
fprintf(fileID,'%12.8f\r\n' ,duration_matrix_cs(1,2));

%cpu utilization
disp('cpu utilization');
cpu_idle_time = global_info.counter_cs * 0.2;
fprintf(fileID,'%12s\r\n' ,'cpu_idle_time:');
fprintf(fileID,'%12.8f\r\n' ,cpu_idle_time);
disp(cpu_idle_time); 

%throughput
disp('Throughput');
res = throughput(global_info.job_execution_time);
fprintf(fileID,'%12s\r\n' ,'Throughput:');
fprintf(fileID,'%12.8f\r\n' ,res);
disp(res);
fclose(fileID);

%waiting time
disp('waiting time');
r = 0;
for n = 1:length(global_info.waiting_time),
    r = r + global_info.waiting_time(n);
end
disp('average')
disp(r/length(global_info.waiting_time))