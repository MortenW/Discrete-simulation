function b = should_context_switch(fire)
    global global_info;
    color = get_color('pTask', fire);
    id = job_id(color);
    
    if(id ~= global_info.prev_job_id),
        b = 'context_switch:1';
    else
        b = 'context_switch:0';
    end
    global_info.prev_job_id = id;
end
        