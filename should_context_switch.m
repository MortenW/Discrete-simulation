function b = should_context_switch(fire)
    global global_info;
    color = get_color('pTask', fire);
    c = {char(color(1)), char(color(2)), char(color(3)), char(color(4))};
    id = job_id(c);
    
    if(id ~= global_info.prev_job_id),
        b = 'context_switch:1';
    else
        b = 'context_switch:0';
    end
    global_info.prev_job_id = id;
end
        