function [ coord_data_valid ] = getSnaserFbk( im )
threshold1 = 40;
threshold2 = 800;

pixel_data = extractPixelDataFromImg(im, threshold1);
[ pixel_data_valid ] = laser_point_filter( pixel_data, threshold2 );
%set(h,'xdata',pixel_data_valid(:,1),'ydata',pixel_data_valid(:,2));
coord_data_valid = reconstructCamCoordFromPixelCoord(pixel_data_valid); 
    
    
end

