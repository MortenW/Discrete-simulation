function b = should_context_switch(color, previous_job_id)
    id = job_id(color);
    if (id ~= previous_job_id)
        b = 1
    else
        b =  0
    end;
        