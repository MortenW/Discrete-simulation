function [sorted_job_units] = sort_on_length(colors)
    job_lengths = [];
    for c = colors
        t = total(c{1});
        job_lengths(end + 1) = t;
    end
    sorted_job_units = sort(job_lengths);
end

