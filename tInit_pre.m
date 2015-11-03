function [fire, transition] = tInit_pre(transition)
    global global_info;
    pJobUnits = get_place('pJobbUnits');
    if not(pJobUnits.tokens),
        fire = 0;
        return;
    elseif strcmp(global_info.algorithm, 'fcfs')
        i = 1;
        while(i),
            at = ['at:', int2str(global_info.counter)];
            fire = tokenAnyColor('pTask', 1, at);
            if (fire),
                i = 0;
                %transition.selected_tokens = fire;
            else
                i = i + 1;
            end;
        end;
    elseif strcmp(global_info.algorithm, 'sjf')
        disp('SJF not yet implemented');
        fire = 0;
    elseif strcmp(global_info.algorithm, 'rr')
        disp('RR');
        i= 1;
        while(i),
            job_id = ['job_id:', int2str(global_info.i)];
            fire = tokenAnyColor('pTask', 1, job_id);
            if (fire)              
                i = 0;
                transition.selected_tokens = fire;
            end;                   
            if eq(global_info.possible_number_of_jobs, global_info.i),
                global_info.i = 1;
                disp('setter i til 1');
            end;
            global_info.i = global_info.i + 1;
        end;
    else
        fire = 0;
    end;