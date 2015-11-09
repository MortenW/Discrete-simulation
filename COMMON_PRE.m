function [fire, transition] = COMMON_PRE(transition)
%get rith valuep from token input
global global_info;

colors = global_info.colors;

if strcmp(transition.name, 'tRemove'),
    transition.override = 1;
    fire = 1;
    return;
elseif strcmp(transition.name, 'tColorizer'),
    tColorizer = get_trans('tColorizer');
    index = tColorizer.times_fired;
    i = index + 1;

    at = colors{i}{1};
    unit_id = colors{i}{2};
    total = colors{i}{3};
    id = colors{i}{4};

    transition.new_color = {at, unit_id, total, id};
    fire = 1;
    return;
elseif strcmp(transition.name, 'tCs'),
    fire = tokenAnyColor('pExecute', 1, 'context_switch:1');
    transition.selected_tokens = fire;
    if(fire),
        color = get_color('pExecute', fire);
        id = job_id(color);       
        disp('transition cs');
        disp(id);
        disp(current_time()+ 1);
        global_info.job_execution_time(id) = current_time()+ 1;
    end;
    return;
elseif strcmp(transition.name, 'tNcs'),
    fire = tokenAnyColor('pExecute', 1, 'context_switch:0');
    transition.selected_tokens = fire;
    if(fire),
        color = get_color('pExecute', fire);
        id = job_id(color);       
        disp('transition cs');
        disp(id);
        disp(current_time()+ 0.1);
        global_info.job_execution_time(id) = current_time()+ 0.1;
    end;
    return;
else fire = 1;
end
