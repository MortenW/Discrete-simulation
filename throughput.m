function[sum] = throughput (results)
finish_time = 0;
number_of_jobs = length(results);
for n = 1:number_of_jobs,
    time = results(n);
    if gt(time, finish_time),
        finish_time = time;
    end
end
sum = number_of_jobs/finish_time;
end