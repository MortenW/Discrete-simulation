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
                transition.selected_tokens = fire;
            end
        end
    elseif strcmp(global_info.algorithm, 'rr')
        disp('RR');
        i= 1;
        while(i),
            job_id = ['job_id:', int2str(global_info.i)];
            fire = tokenAnyColor('pTask', 1, job_id);
            disp(global_info.i);
            disp(global_info.prev_job_id);
            if (fire)              
                i = 0;
                if (should_context_switch(global_info.i, global_info.prev_job_id)),                 
                    disp('Context switch');  
                    global_info.prev_job_id = global_info.i;
                    %add color = cs: 1
                else
                    %add color = cs: 0
                    disp('No context switch');
                    transition.selected_tokens = fire;
                    global_info.i = global_info.i + 1;
               end;
            end;
            if eq((number_of_jobs(colors) + 1) , global_info.i),
                global_info.i = 1;       
            end;
        end;
    else
        fire = 0;
    end