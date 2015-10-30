function [fire, transition] = COMMON_PRE(transition)
%get rith value from token input
global global_info;
global_info.counter = 0;

if strcmp(transition.name, 'tRemove'),
    transition.override = 1;
    fire = 1;
    return;
elseif strcmp(transition.name, 'tInit'),
    global_info.counter = global_info.counter + 1;
    
    %for n = 1:4
    tokID = tokenAnyColor('pTask',1,{'at:1'});
    disp(tokID);
    fire = (tokID);
    %end;
    return;
end;
fire = 1;