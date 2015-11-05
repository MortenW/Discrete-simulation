function b = should_context_switch(id, previous_job_id)
    b = id ~= previous_job_id;
end
        