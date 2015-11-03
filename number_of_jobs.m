function number_of_jobs = number_of_jobs(colors)
    max_id = 0;
    for c = colors
        id = job_id(c{1});
        if gt(id, max_id)
            max_id = id;
        end
    end
    number_of_jobs = max_id;
end

