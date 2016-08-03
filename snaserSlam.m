function [ snake,map,pegPoints ] = snaserSlam( snake,map,fbk_position,im, h_contact )
coord_data_valid = getSnaserFbk( im );
planar = BoundBox( coord_data_valid );
snake.configuration = [snake.T(1,3),snake.T(2,3),atan2(snake.T(2,1),snake.T(1,1))-pi/2,fbk_position(1:2:end)];
[ snake ] = ConfigurationToBackbone( snake );
[ pegPoints ] = extractPeg( planar );
[ snake ] = contactSampling( snake, map, h_contact,fbk_position );
[ snake,map ] = localization_only( pegPoints,map,snake );

end

