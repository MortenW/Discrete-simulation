function [fire, transition] = tInit_pre(transition)
    global global_info;
    
    % Do not fire until all job units are colorized.
    pJobUnits = get_place('pJobbUnits');
    if (pJobUnits.tokens),
        fire = 0;
        return;
    end
    
    if strcmp(global_info.algorithm, 'fcfs')
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
        disp('RR not yet implemented');
        fire = 0;
    else
        fire = 0;
    end