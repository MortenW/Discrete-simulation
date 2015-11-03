function [fire, transition] = COMMON_PRE(transition)
%get rith value from token input
global global_info;

colors = global_info.colors;

if strcmp(transition.name, 'tRemove'),
    transition.override = 1;
    fire = 1;
    return;
    
elseif strcmp(transition.name, 'tInit'),
    at = ['at:', int2str(global_info.counter)];
    tokID = tokenAnyColor('pTask', 1, at);
    if eq(tokID, 0.0),
        global_info.counter = global_info.counter + 1;
        fire = 0;
        disp('null');
        return;
    end;
    disp('not null');
    disp(tokID);
    fire = (tokID);
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
end;
fire = 1;
