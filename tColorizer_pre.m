function [fire, transition] = tColorizer_pre(transition)

global colors;
colors = {{'at:1', 'unit_id:1', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:2', 'total:3','job_id:1'},...
 {'at:1', 'unit_id:3', 'total:3','job_id:1'},...
{'at:2', 'unit_id:1', 'total:2','job_id:2'},...
{'at:2', 'unit_id:2', 'total:2','job_id:2'}};

tColorizer = get_trans('tColorizer');
index = tColorizer.times_fired;
i = index + 1;

at = colors{i}{1};
unit_id = colors{i}{2};
total = colors{i}{3};
job_id = colors{i}{4};
 
transition.new_color = {at, unit_id, total, job_id};

%if eq(tColorizerFired, 6),
 %   global_info.STOP_SIMULATION = 1;
  %  fire = 0;
  %  return
%end;
fire = 1;