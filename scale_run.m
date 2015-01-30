function [Nodes_list] = scale_run(Nodes_list, Event_list, max_time, log_file)

clock = 0;

% 
while 1
    clock = clock + 1;
    [min_instant, min_index] = min([Event_list(:).instant]);
    
    for k=1:numel(Nodes_list)
        if Nodes_list(k).status == 1
           Nodes_list(k).active_time_left = Nodes_list(k).active_time_left - 1;
           
           % Check to see if it has any any event from the event queue
           
           % Send out beacon message to annouce its active 
           
           if Nodes_list(k).active_time_left == 0
               Nodes_list(k).status = 0;
               Nodes_list(k).sleeping_time_left = 5; % Need to construct a function to get_next_sleeping_time();
           end
        else
           Nodes_list(k).sleeping_time_left = Nodes_list(k).sleeping_time_left - 1;
           if Nodes_list(k).sleeping_time_left == 0
               Nodes_list(k).satus = 1;
               Nodes_list(k).active_time_left = 5; % Need to construct a function to get_next_active_time();
           end
        end
        
    end
    
    
    [min_instant, min_index] = min([Event_list(:).instant]);
    if isempty(min_instant)
        break;
    end
    if min_instant > max_time
        break;
    end
    NewEvents = action(Event_list(min_index), log_file);      % Get new events from executing the latest 'action'
    current_time = min_instant;
    Event_list(min_index) = [];                     % Delete the latest event which has been just executed.
    Event_list = [NewEvents; Event_list];   % Append new events generated by executing the latest event
end

return;