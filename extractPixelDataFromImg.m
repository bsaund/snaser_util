function pixel_data_valid = extractPixelDataFromImg(im, threshold)
% take an rgb image as input, output the pixel coordinates(x,y) of the
% detected laser pixels (max 2000 pixel data)

im_gray = im(:,:,1)-im(:,:,2)-im(:,:,3);

% extract laser pixel from the image and get their coordinates (x,y)
aux_vect = 1:size(im_gray,1);

% to avoid dynamic array a=[a,new], to enhance speed
data_pts_limit = 4000; 
pixel_data = zeros(data_pts_limit,2);
pixel_data_index = 1;

% handle each row
for col = 1:size(im_gray,2)
    work_col = im_gray(:,col) > threshold;
    work_col(400:end) = 0;
    if sum(work_col)>0 && std(find(work_col == 1)) < 20
        weightedCenterOfCol = work_col' * ( aux_vect' .* double(im_gray(:,col)) )/sum(work_col' * double(im_gray(:,col)));
        weightedCenterOfCol = round(weightedCenterOfCol);
        if(weightedCenterOfCol <10)
            continue;
        end
        pixel_data(pixel_data_index,:) = [col,weightedCenterOfCol]; % pixel x,y in image
        pixel_data_index = pixel_data_index + 1;
        if pixel_data_index > data_pts_limit
            break;
        end
    end
end

% return result
pixel_data_valid = pixel_data([1:(pixel_data_index-1)], :);