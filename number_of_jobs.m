% Iterates over a two dimensional cell array of strings
% that represents the colors of the tokens (job units) 
% and reads the job id of the job unit. The function
% basically finds the highest value of the job id attribute
% which corresponds to the total number of jobs.
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

