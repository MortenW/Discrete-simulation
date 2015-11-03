function [fire, transition] = tInit_pre(transition)
    global global_info;
    if strcmp(global_info.algorithm, 'fcfs')
        
        pJobUnits = get_place('pJobbUnits');
        if not(pJobUnits.tokens),
            fire = 0;
            return;
        end;
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
    else
        fire = 0;
    end;