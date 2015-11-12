clear all; clc;
global global_info;
global_info.STOP_AT = 1000;
global_info.counter = 1;
global_info.counter_processor = 1;
global_info.job_id = 1;
global_info.prev_job_id = 0;
global_info.units_done = 1;
global_info.algorithm = 'sjf';
algorithm = global_info.algorithm;
global_info.number = 0 ;
global_info.prev_at = 1;
global_info.counter_cs = 0;
global_info.number_of_jobs_ncs = 0;
global_info.number_of_jobs_cs = 0;


%{
global_info.colors = {{'at:1', 'unit_id:1', 'total:5','job_id:1'},...
{'at:1', 'unit_id:2', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:3', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:4', 'total:5','job_id:1'},...
 {'at:1', 'unit_id:5', 'total:5','job_id:1'},...
{'at:2', 'unit_id:1', 'total:4','job_id:2'},...
 {'at:2', 'unit_id:2', 'total:4','job_id:2'},...
 {'at:2', 'unit_id:3', 'total:4','job_id:2'},...
{'at:2', 'unit_id:4', 'total:4','job_id:2'},...
 {'at:3', 'unit_id:1', 'total:2','job_id:3'},...
 {'at:3', 'unit_id:2', 'total:2','job_id:3'},...
{'at:4', 'unit_id:1', 'total:5','job_id:4'},...
 {'at:4', 'unit_id:2', 'total:5','job_id:4'},...
 {'at:4', 'unit_id:3', 'total:5','job_id:4'},...
{'at:4', 'unit_id:4', 'total:5','job_id:4'},...
{'at:4', 'unit_id:5', 'total:5','job_id:4'}};
%}
disp('Loading jobs from file ...');
global_info.colors = get_jobs_from_file('job_generator/jobs_test.txt');
disp('All jobs loaded');

disp('Sorting jobs on length ...');
global_info.remaining_units = sort_on_length(global_info.colors);
disp('Done');

pns = pnstruct('generator_pdf');
dyn.m0 = {'pJobUnits', length(global_info.remaining_units), 'pReady',1};
dyn.ft = {'tProcess', 0.1, 'tColorizer', 0.1, 'tRemove', 0.01,...
           'tCs', 0.7, 'tNcs',0.5, 'allothers', 0.1};

pni = initialdynamics(pns, dyn);

sim = gpensim(pni);
prnss(sim);
plotp(sim, {'pJobUnits', 'pTask', 'pExecute', 'pJobDone',...
            'pTrigger'});
prnfinalcolors(sim);

occupancy_matrix = occupancy(sim, {'tNcs'});
disp(occupancy_matrix);
occupancy_matrix = occupancy(sim, {'tCs'});
disp(occupancy_matrix);
duration_matrix = extractt(sim, {'tNcs'});
disp('duration_matrix');
disp(duration_matrix);

disp('Execution time')

%{
The section calculate the average execution time.
It also writes to result to file
%}
sum = 0;
file = strcat('output/',algorithm,'_result.txt');
fileID = fopen(file, 'w');
for n = 1:length(global_info.job_execution_time),
    sum = sum + global_info.job_execution_time(n);
    fprintf(fileID,'%12.8f\r\n' ,global_info.job_execution_time(n));

end
%average
average = sum / length(global_info.job_execution_time);
disp(average);
fprintf(fileID,'%12.8f\r\n' ,average);
fclose(fileID);
disp(global_info.job_execution_time);

%cpu utilization
disp('cpu utilization (job/tot_time)');
cpu_idle_time = global_info.counter_cs * 0.2;
disp(cpu_idle_time); 

%throughput
disp('Throughput');
res = throughput(global_info.job_execution_time);
disp(res);
