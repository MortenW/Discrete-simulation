function [fire, transition] = tProcess_pre(transition)
    global global_info;
    colors = global_info.colors; 
    
    %{
    This check is to ensure that tProcess doesn't fire
    before all tokens have been colorized.
    %}    
    pJobUnits = get_place('pJobUnits');
    if (pJobUnits.tokens),
        fire = 0;
        return;
        
    %{
    this check is to se which algorithm we want to simulate
    this time. This one  is for first come first serve
    %}
    elseif strcmp(global_info.algorithm, 'fcfs')
        i = 1;
        while(i),
            
            % at represent a field in the color f.exampel 'at:2'.
            at = ['at:', int2str(i)];
            
            %want a token with this at value
            fire = tokenAnyColor('pTask', 1, at);
            if (fire),
                
                % The i just stop the while loop.
                i = 0;
                
                %{
                Should_context_switch() is method that check if we have
                a new job id and need to do a context switch. returna new 
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);                 
                transition.new_color={c};
                transition.selected_tokens = fire;
            else
                
                %{
                If there is no token with this color value 'at:i'  in the 
                pTask, we increment the value i.               
                %}                
                i = i + 1;
            end
        end
        
        %{
    this check is to se which algorithm we want to simulate
    this time. This one is for shortest job first.  
    %}
    elseif strcmp(global_info.algorithm, 'sjf')
        i = 1;
        while(i),
            
            %{
            Units is a list of all available jobs. This list is shorted 
            on the length of the jobs, so the shortest job is first.
            %}
            units = global_info.remaining_units;
            
            %Get the value of the shortest job from the list.
            shortest_job = units(1);
            
            % Remove the first job unit in the list of remaining units.
            global_info.remaining_units = units(2:length(units));
            
            % total represent a field in the color f.exampel 'total:12'.
            total = ['total:', int2str(shortest_job)];
            fire = tokenAnyColor('pTask', 1, total);

            if (fire),
                
                % The i just stop the while loop.
                i = 0;
                
                %{
                Should_context_switch() is method that check if we have
                a new job id and need to do a context switch. returna new 
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);                 
                transition.new_color={c};            
                transition.selected_tokens = fire;
            end
        end        
        %{
    this check is to se which algorithm we want to simulate
    this time. This is for round robin.  
    %}
    elseif strcmp(global_info.algorithm, 'rr')      
       %{
        i = 1;
        while (i),
            
            
            job_id: represent a field in the color f.exampel 'job_id:2'.
            id = ['job_id:', int2str(global_info.job_id)];
            fire = tokenAnyColor('pTask', 1, id);            
            if (fire) 
                % The i just stop the while loop.
                i = 0;
                
                %{
                Should_context_switch() is method that check if we have
                a new job id and need to do a context switch. returna new 
                color value 'context_switch:1' or 'context_switch:0'.
                %}
                c = should_context_switch(fire);
                transition.new_color={c}; 
                transition.selected_tokens = fire;
                
                %{
                This check will achieve that we do 5 units per job.
                This gives a more realistic simulation of a round robin
                %}
                if eq(global_info.units_done, 3),
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
                if fire is zero it means that there is no tokens left
                with the desire job id value. Therefor we need to increment
                the job id value to find the next job.
                %}             
                global_info.job_id = global_info.job_id + 1;
            end
            
            %{
            number_of_jobs() return the number of different jobs, and not
            the length of the list of colors. This will ensure that we
            better performance for the code.
            If we have reaced the highest job id, we need to start all over
            again.
            %}
            disp('info');
            disp(number_of_jobs(colors)+1);
            disp(global_info.job_id);
            if eq((number_of_jobs(colors) + 1) , global_info.job_id),
                global_info.job_id = 1;
                global_info.prev_job_id = 0;
            end;
        end;
            %}
        k = 1;
        while (k),
            id = ['job_id:', int2str(global_info.job_id)];
            fire = tokenAnyColor('pTask', 1, id);            
            if (fire)  
                k = 0;
                c = should_context_switch(fire);                 
                transition.new_color={c}; 
                transition.selected_tokens = fire;
            end
                global_info.job_id = global_info.job_id + 1;

            if eq((number_of_jobs(colors) + 1) , global_info.job_id),
                global_info.job_id = 1;
                global_info.prev_job_id = 0;
            end;
        end;
    else
        fire = 0;
    end