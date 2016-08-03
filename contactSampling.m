function [ last_snake ] = contactSampling( snake, map, h_contact,fbk_position )
snake = pegContact( snake, map ); % detect contact between snake robot and all the pegs (1 is contact, 2 is collision)
last_snake = snake;
n_contact = find(last_snake.contact == 1);
N_sample = 80; % number of possible configurations
counter = 0;
if n_contact > 0
    set(h_contact,'xdata',map(last_snake.contact_pair(:,1),1),'ydata',map(last_snake.contact_pair(:,1),2));
end
n_collision = find(last_snake.contact == 2);
last_snake.possible_configuration = [];
n = 0;
while 1 
    counter = counter + 1;
    if counter > 2000 && ~isempty(last_snake.possible_configuration)
        % if the loop has run 1000 times, then stop
        break
    end
    snake.configuration = [[0,0,0.35*(rand(1)-0.5)]+last_snake.configuration(1:3),fbk_position(1:2:end)];
    snake = ConfigurationToBackbone( snake );
    if (isempty(n_contact) && isempty(n_collision))
        x_deviation = 1.0*(rand(1)-0.5);
        y_deviation = 0.6*(rand(1)-0.5);
        tangent_vector = last_snake.point(1,:)-last_snake.point(2,:);
        tangent_vector = tangent_vector/norm(tangent_vector);
        normal_vector = flip(tangent_vector);
        normal_vector(2) = -normal_vector(2);
        snake.configuration(1) = snake.configuration(1)+(last_snake.point(1,1)-snake.point(1,1))+x_deviation*tangent_vector(1)+y_deviation*normal_vector(1);
        snake.configuration(2) = snake.configuration(2)+(last_snake.point(1,2)-snake.point(1,2))+x_deviation*tangent_vector(2)+y_deviation*normal_vector(2);
    else
        rand_i = randi(size(last_snake.contact_pair,1));
        normal_vector = last_snake.point(last_snake.contact_pair(rand_i,2),:) - map(last_snake.contact_pair(rand_i,1),:);
        normal_vector = normal_vector/norm(normal_vector);
        if last_snake.contact_pair(rand_i,2) == 1
            tangent_vector = last_snake.point(last_snake.contact_pair(rand_i,2),:)-last_snake.point(last_snake.contact_pair(rand_i,2)+1,:);
        else
            tangent_vector = last_snake.point(last_snake.contact_pair(rand_i,2)-1,:)-last_snake.point(last_snake.contact_pair(rand_i,2),:);
        end
        tangent_vector = tangent_vector/norm(tangent_vector);
        x_deviation = 1.0*(rand(1)-0.4);
        y_deviation = 0.6*(rand(1)-0.4); % units in cm

        snake.configuration(1) = snake.configuration(1)+(last_snake.point(last_snake.contact_pair(rand_i,2),1)-snake.point(last_snake.contact_pair(rand_i,2),1))+x_deviation*tangent_vector(1)+y_deviation*normal_vector(1);
        snake.configuration(2) = snake.configuration(2)+(last_snake.point(last_snake.contact_pair(rand_i,2),2)-snake.point(last_snake.contact_pair(rand_i,2),2))+x_deviation*tangent_vector(2)+y_deviation*normal_vector(2);
    end
    snake = ConfigurationToBackbone( snake );
    snake = pegContact( snake, map);
    is_over = overPeg( last_snake, snake, map);
    if max(snake.contact) < 2 && ~is_over
        last_snake.possible_configuration = [last_snake.possible_configuration; snake.configuration];
        n = n+1;
    end
    if n == N_sample
        break
    end
end


end

