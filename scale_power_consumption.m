function [node_power] = scale_power_consumption(node_power, action)
% Calculate energy spent for each each action a node conducted 
    
    global broadcast_message_size;
    global beacon_message_size;
    global sleeping_power;
    global active_power;
    global sending_power;
    global receiving_power; 
    global computation_power;
    
    if(strcmp(action.type, 'broadcast_join'))
        power_required = broadcast_message_size*sending_power;
    end
    
    if(strcmp(action.type, 'broadcast_beacon'))
        power_required = beacon_message_size*sending_power;
    end
    
    if(strcmp(action.type, 'active'))
        power_required = action.time*active_power;
    end
    
    if(strcmp(action.type, 'sleeping'))
        power_required = action.time*sleeping_power;
    end
    
    if(strcmp(action.type, 'sending'))
        power_required = action.packet_size*sending_power;
    end
    
    if(strcmp(action.type, 'receiving'))
        power_required = action.packet_size*receiving_power;
    end
    
    if(strcmp(action.type, 'computing'))
        power_required = computation_power;
    end
    
    if(node_power > power_required)
        node_power =  node_power - power_required;     
    else
        node_power = 0;
    end
    
    return;
end

