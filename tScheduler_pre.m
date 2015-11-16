function [fire, transition] = tScheduler_pre(transition)
    global global_info;
    colors = global_info.colors; 
    
    %{
    This check is to ensure that tScheduler doesn't fire
    before all tokens have been colorized.
    %} 
    
    pJobUnits = get_place('pJobUnits');
    if (pJobUnits.tokens),
        fire = 0;
        return;
    %{
    This check is to see which algorithm we want to simulate.
    This one is for first-come, first-served. 
    %}
    elseif strcmpi(global_info.algorithm, 'fcfs')
        i = global_info.prev_at;
        i_max = i;
        while(i),
            
            % at represent a field in the color f.exampel 'at:2'.
            at = ['at:', int2str(i)];
            
            %want a token with this at value
            fire = tokenAnyColor('pReadyQueue', 1, at);
            if (fire),
                   color = get_color('pReadyQueue', fire);
                   id = job_id(color);
                   if eq(global_info.waiting_time(id), 0)
                        global_info.waiting_time(id) = current_time();
                   end

                % The i just stop the while loop.
                i = 0;
                
                %{
                should_context_switch() is a function that checks if we have
                a new job id and need to do a context switch. Returns a
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);                 
                transition.new_color={c};
                transition.selected_tokens = fire;
            else
                
                %{
                If there are no tokens with the requested color in
                pReadyQueue, we increment the value i.               
                %}                
                i = i + 1;
                i_max = i;
            end
        end
        global_info.prev_at = i_max;
        
        %{
    This check is to se which algorithm we want to simulate
    This one is for shortest job first.  
    %}
    elseif strcmpi(global_info.algorithm, 'sjf')
        i = 1;
        while(i),
            
            %{
            Units is a list of all available jobs. This list is sorted 
            on the length of the jobs, so the shortest job is the first
            item in the list.
            %}
            units = global_info.remaining_units;
            
            % Get the value of the shortest job from the list.
            shortest_job = units(1);
            
            % Remove the first job unit in the list of remaining units.
            global_info.remaining_units = units(2:length(units));
            
            % Total represents a field in the color e.g 'total:12'.
            total = ['total:', int2str(shortest_job)];
            fire = tokenAnyColor('pReadyQueue', 1, total);

            if (fire),
               color = get_color('pReadyQueue', fire);
               id = job_id(color);
               if eq(global_info.waiting_time(id), 0)
                    global_info.waiting_time(id) = current_time();
               end
                
                % Stop the while loop.
                i = 0;
                
                %{
                should_context_switch() is a function that checks if we have
                a new job id and need to do a context switch. Returns a
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);                 
                transition.new_color={c};            
                transition.selected_tokens = fire;
            end
        end
        
    %{
    This check is to se which algorithm we want to simulate
    This is for round-robin.  
    %}
    elseif strcmpi(global_info.algorithm, 'rr')           
        i = 1;
        while (i),
            %job_id: represents a field in the color f.exampel 'job_id:2'.
            id = ['job_id:', int2str(global_info.job_id)];
            fire = tokenAnyColor('pReadyQueue', 1, id);            
            if (fire) 
                % The i just stop the while loop.
                i = 0;
               
                %{
                should_context_switch() is a function that checks if we have
                a new job id and need to do a context switch. Returns a
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);
                transition.new_color={c}; 
                transition.selected_tokens = fire;
                
                %{
                This check will make sure that we do a given amount of 
                units per job (specified by global_info.time_quantum).
                %}
                if eq(global_info.units_done, global_info.time_quantum),
                    global_info.job_id = global_info.job_id + 1;
                    
                    %{
                    Need to reset this variable so that the if check
                    will be positive on a regular basis.
                    %}
                    global_info.units_done = 0;
                end
                
                global_info.units_done = global_info.units_done + 1;
            else
                
                %{
                If fire is zero it means that there is no tokens left
                with the desired job id value. Therefore we need to 
                increment the job id value to find the next job.
                %}             
                global_info.job_id = global_info.job_id + 1;
            end
            
            %{
            number_of_jobs() returns the number of different jobs, and not
            the length of the list of colors. If we have reached the 
            highest job id, we need to start all over again.
            %}
            if eq((number_of_jobs(colors) + 1) , global_info.job_id),
                global_info.job_id = 1;
                global_info.prev_job_id = 0;
                global_info.units_done = 1;
            end
        end
    else
        fire = 0;
    end
