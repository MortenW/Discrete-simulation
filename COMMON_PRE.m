function [fire, transition] = COMMON_PRE(transition)
%get rith valuep from token input
global global_info;

colors = global_info.colors;

pReadyQueue = get_place('pReadyQueue');
pJob_Units = get_place('pJobUnits');
    if not(pReadyQueue.tokens),
        if not(pJob_Units.tokens),
            global_info.STOP_SIMULATION = 1;
        end
    end

if strcmp(transition.name, 'tColorRemover'),
    % Enable override to prevent color pollution.
    transition.override = 1;
    fire = 1;
    return;
elseif strcmp(transition.name, 'tColorizer'),
    % This transition handles colorizing of all the
    % tokens in 'pJobUnits'. All the possible colors
    % are declared in the 'colors' object which is a
    % two dimensional cell array.
    tColorizer = get_trans('tColorizer');
    index = tColorizer.times_fired;
    i = index + 1;

    % The attributes that are used to describe the job
    % units are extracted from the 'colors' object.
    at = colors{i}{1}; % Arrival time
    unit_id = colors{i}{2}; % Id of the job unit
    total = colors{i}{3}; % Total number of job units
    j_id = colors{i}{4}; % Id of the job

    % The color of the transition is assigned a list of
    % strings describing the job unit.
    transition.new_color = {at, unit_id, total, j_id};
    
    global_info.number = global_info.number + 1;
    if eq (global_info.number, 10),
        disp('Tokens gets color');
        global_info.number = 0;
    end
    
    fire = 1;
    return;
elseif strcmp(transition.name, 'tCs'),
    % This transition will fire if there are any tokens
    % in the place 'pExecute' that has the 'context_switch:1'
    % color. That particular color indicates that a context
    % switch should be performed. The purpose of this transition
    % is to simulate the overhead related to a context switch.
    % This is achieved by setting a higher firing time than
    % for the transition that does not perform a context switch.

    % If no tokens matches the requested color, fire will be
    % equal to zero, and hence the transition will not fire.
    % If a token is found, the transition will fire.
    fire = tokenAnyColor('pExecute', 1, 'context_switch:1');
    transition.selected_tokens = fire;
    if(fire),
                      
        global_info.counter_cs = global_info.counter_cs + 1;
        color = get_color('pExecute', fire);
        id = job_id(color);       
        disp('transition cs');
        %waiting time
   
        disp(id);
        disp(current_time()+ 1);
        global_info.job_execution_time(id) = current_time()+ 1;
        
        
    end;
    return;
elseif strcmp(transition.name, 'tNcs'),
    % This transition will fire if there are any tokens
    % in the place 'pExecute' that has the 'context_switch:0'
    % color. That particular color indicates that a context
    % switch should not be performed and the execution should
    % go on as normal.

    % If no tokens matches the requested color, fire will be
    % equal to zero, and hence the transition will not fire.
    % If a token is found, the transition will fire.
    
    fire = tokenAnyColor('pExecute', 1, 'context_switch:0');
    transition.selected_tokens = fire;
    if(fire),
        color = get_color('pExecute', fire);
        id = job_id(color);       
        disp('transition ncs');
        disp(id);
        disp(current_time()+ 0.1);
        global_info.job_execution_time(id) = current_time()+ 0.1;
    end;
    return;
else fire = 1;
end
