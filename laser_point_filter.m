function [ pixel_data_valid ] = laser_point_filter( pixel_data, threshold )

p1 = [107.25,260.75];
p2 = [816.75,241.25];
a = [p2(2)-p1(2),p1(1)-p2(1),p2(1)*p1(2)-p2(2)*p1(1),norm([p2(2)-p1(2),p1(1)-p2(1)])];
dist = abs(a(1)*pixel_data(:,1)+a(2)*pixel_data(:,2) + a(3))/a(4);
pixel_data_valid = pixel_data(dist < threshold,:);

end

