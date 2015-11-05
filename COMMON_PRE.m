function [fire, transition] = COMMON_PRE(transition)
%get rith value from token input
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
    job_id = colors{i}{4};

    transition.new_color = {at, unit_id, total, job_id};
    fire = 1;
    return;
elseif strcmp(transition.name, 'tCs'),
    fire = tokenAnyColor('pExecute', 1, 'context_switch:1');
    transition.selected_tokens = fire;
elseif strcmp(transition.name, 'tNcs'),
    fire = tokenAnyColor('pExecute', 1, 'context_switch:0');
    transition.selected_tokens = fire;
end;
fire = 1;
