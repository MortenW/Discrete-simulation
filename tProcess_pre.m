function [fire, transition] = tProcess_pre(transition)
    global global_info;
    colors = global_info.colors; 
    % Do not fire until all job units are colorized.
    
    pJobUnits = get_place('pJobUnits');
    if (pJobUnits.tokens),
        fire = 0;
        return;
    elseif strcmp(global_info.algorithm, 'fcfs')
        i = 1;
        while(i),
            at = ['at:', int2str(i)];
            fire = tokenAnyColor('pTask', 1, at);
            if (fire),
                i = 0;   
                c = should_context_switch(fire);                 
                transition.new_color={c};
                transition.selected_tokens = fire;
            else
                i = i + 1;
            end
        end
    elseif strcmp(global_info.algorithm, 'sjf')
        i = 1;
        while(i),
            units = global_info.remaining_units;
            shortest_job = units(1);
            % Remove the first job unit in the list of remaining units.
            global_info.remaining_units = units(2:length(units));
            total = ['total:', int2str(shortest_job)];
            fire = tokenAnyColor('pTask', 1, total);

            if (fire),
                i = 0;
                c = should_context_switch(fire);                 
                transition.new_color={c};            
                transition.selected_tokens = fire;
            end
        end
    elseif strcmp(global_info.algorithm, 'rr')      
        k = 1;
        while (k),
            id = ['job_id:', int2str(global_info.job_id)];
            fire = tokenAnyColor('pTask', 1, id);            
            if (fire)  
                k = 0;
                c = should_context_switch(fire);                 
                transition.new_color={c}; 
                transition.selected_tokens = fire;
            end
                global_info.job_id = global_info.job_id + 1;

            if eq((number_of_jobs(colors) + 1) , global_info.job_id),
                global_info.job_id = 1;
                global_info.prev_job_id = 0;
            end;
        end;
    else
        fire = 0;
    end