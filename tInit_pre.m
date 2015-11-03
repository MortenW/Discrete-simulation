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
        disp('RR not yet implemented');
        fire = 0;
    else
        fire = 0;
    end;