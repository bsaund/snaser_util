function [ snake,pegPoints ] = snaserLocalization( snake,map,fbk_position,im, h_contact,h_pc )
coord_data_valid = getSnaserFbk( im ); % get point cloud in current image
planar = BoundBox( coord_data_valid ); % prune the points that are out of a certain range
snake.configuration = [snake.T(1,3),snake.T(2,3),atan2(snake.T(2,1),snake.T(1,1))-pi/2,fbk_position(1:2:end)]; % update configuration with fbk joint angles 
[ snake ] = ConfigurationToBackbone( snake ); % calculate coodinates of feature points along the backbone curve
[ pegPoints ] = extractPeg( planar ); % fitting circle on point cloud to detect pegs, and give the coordinates of pegs
[ snake ] = contactSampling( snake, map, h_contact,fbk_position ); %PARTICLE FILTER -- sampling possible configurations based on snake-peg contact

[ snake ] = localization_only( pegPoints,map,snake ); % choose the best configuration that the detected pegs match the best with map

% transform pegs from snaser frame to world frame
if ~isempty(pegPoints)
    temp = snake.T*[pegPoints';ones(1,size(pegPoints,1))];
    pegPoints = temp(1:2,:)';
end

% transform point cloud from snaser frame to world frame
if ~isempty(planar)
    temp = snake.T*[planar';ones(1,size(planar,1))];
    planar = temp(1:2,:)';
    set(h_pc,'xdata',planar(:,1),'ydata',planar(:,2));
end

end

