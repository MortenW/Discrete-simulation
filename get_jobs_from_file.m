% Loads the job units from a tab separated file.
% The job units are loaded into a two dimensional
% cell array of strings that represents the colors
% of the tokens in the simulation.
function jobs = get_jobs_from_file(path)
    job_units = dlmread(path, '\t');
    [rows, ~] = size(job_units);
    jobs = cell(1, rows);
    for row = 1 : rows
        at = num2str(job_units(row, 1));
        unit_id = num2str(job_units(row, 2));
        total = num2str(job_units(row, 3));
        job_id = num2str(job_units(row, 4));
        color = {strcat('at:', at), strcat('unit_id:', unit_id), strcat('total:', total), strcat('job_id:', job_id)};
        jobs{row} = color;
    end
end
