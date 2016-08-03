function cam_coord = xyzFromPixel(x,y)
% function will return a column vector = [X;Y;Z] if given pixel coord (x,y)
% Z is the distance
% x is the col pixel index of image!!!!!
% y is the row pixel index of image!!!!!

K_inv = [0.0006,0,-0.3296;0,0.0006,-0.1827;0,0,1];

adjust = 1.00;

% gc = [0.0123    0.9998   -0.0157    1.6682];
gc = [0.0369   -0.9991    -0.0185   -1.7207];
K_expand_inv =  [K_inv, zeros(3,1);
                 zeros(1,3),1];

Ad = gc*K_expand_inv;

dist = -Ad(4)/(Ad(1)*x + Ad(2)*y + Ad(3))*adjust;

pixel_coord = [x;y;1];

proj_coord = pixel_coord * dist;

cam_coord = K_inv * proj_coord;
