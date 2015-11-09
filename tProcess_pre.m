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
                color = get_color('pTask', fire);
                c = {char(color(1)), char(color(2)), char(color(3)), char(color(4))};
                id = job_id(c);
                disp(id);
                disp(global_info.prev_job_id);
                if (should_context_switch(id, global_info.prev_job_id)),                 
                    disp('Context switch');  
                    transition.new_color={'context_switch:1'};
                else                   
                    disp('No context switch');
                    transition.new_color={'context_switch:0'};
                end;
                global_info.prev_job_id = id;
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
            token_found = tokenAnyColor('pTask', 1, total);

            if (token_found),
                i = 0;
                color = get_color('pTask',token_found);
                c = {char(color(1)), char(color(2)), char(color(3)), char(color(4))};
                id = job_id(c);
                disp(id);
                disp(global_info.prev_job_id);
                if (should_context_switch(id, global_info.prev_job_id)),                 
                    disp('Context switch');  
                    transition.new_color={'context_switch:1'};
                else                   
                    disp('No context switch');
                    transition.new_color={'context_switch:0'};
                end;
                transition.selected_tokens = token_found;
                global_info.prev_job_id = id;
            end
            fire = token_found;
        end
    elseif strcmp(global_info.algorithm, 'rr')      
        k = 1;
        while (k),
            id = ['job_id:', int2str(global_info.job_id)];
            fire = tokenAnyColor('pTask', 1, id);            
            if (fire)  
                k = 0;
                if (should_context_switch(global_info.job_id, global_info.prev_job_id)),                 
                    disp('Context switch');  

                    transition.new_color={'context_switch:1'};
                else                   
                    disp('No context switch');
                    transition.new_color={'context_switch:0'};

                end;
                transition.selected_tokens = fire;
                global_info.prev_job_id = global_info.job_id;
                global_info.job_id = global_info.job_id + 1;
            else
                global_info.job_id = global_info.job_id + 1;
            end;

            if eq((number_of_jobs(colors) + 1) , global_info.job_id),
                global_info.job_id = 1;
                global_info.prev_job_id = 0;
            end;
        end;
    else
        fire = 0;
    end