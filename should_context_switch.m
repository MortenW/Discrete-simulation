% Determines if a context switch should be performed for the
% current CPU cyle.
function b = should_context_switch(fire)
    global global_info;
    color = get_color('pTask', fire);
    c = {char(color(1)), char(color(2)), char(color(3)), char(color(4))};
    id = job_id(c);
    
    % If the job id of the unit that is currently being
    % processed is not equal to the job id of the unit
    % that was processed in the previous cycle, a context
    % switch should be performed.
    if(id ~= global_info.prev_job_id),
        b = 'context_switch:1';
    else
        b = 'context_switch:0';
    end
    global_info.prev_job_id = id;
end
        
