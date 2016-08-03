function [ planar ] = BoundBox( coord_data_valid )
x_min = -30;
x_max = 30;
z_min = 5;
z_max = 110;
planar = round(coord_data_valid(:,[1,3])*10)/10;
planar = unique(planar,'rows');
planar = planar(planar(:,1)>x_min & planar(:,1)<x_max &planar(:,2)>z_min &planar(:,2)<z_max,:);

end

