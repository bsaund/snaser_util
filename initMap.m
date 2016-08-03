function [ snake,map ] = initMap(fbk_position,cam)
map = ones(20,40); % screw hole
map_coordinate = generate_map(map) * 2.54; % coordinate of all screw holes in cm
% peg_coordinate = generate_special_peg(map_coordinate);
lateral_spacing = 8*2.54;
longitude_spacing = 4*sqrt(3)*2.54;
map = generate_uniform_peg(map_coordinate,lateral_spacing,longitude_spacing); % coordinate of all pegs in cm


x_0 = 38; % initial position of head 
y_0 = 60; % initial position of head 
snake.T = [1,0,x_0;0,1,y_0;0,0,1]; % initial pose
snake.configuration = [snake.T(1,3),snake.T(2,3),atan2(snake.T(2,1),snake.T(1,1))-pi/2,fbk_position(1:2:end)]; % snake configuration is defined [x,y,theta,alphas]
[ snake ] = ConfigurationToBackbone( snake ); % compute coordinates of feature points along backbone curve
% while 1
%     try 
%         im = getsnapshot(cam);
%     catch
%         continue
%     end
%     break
% end
% coord_data_valid = getSnaserFbk( im );
% planar = BoundBox( coord_data_valid );
% snake.configuration = [snake.T(1,3),snake.T(2,3),atan2(snake.T(2,1),snake.T(1,1))-pi/2,fbk_position(1:2:end)];
% [ snake ] = ConfigurationToBackbone( snake );
% [ pegPoints ] = extractPeg( planar );


end

