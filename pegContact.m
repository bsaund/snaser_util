function [ snake ] = pegContact( snake, peg)
%compute distances between obstacles and links
%contact with two circles
% peg = peg(peg(:,1)>(min(snake.point(:,1))-10),:);
% peg = peg(peg(:,1)<(max(snake.point(:,1))+10),:);
% peg = peg(peg(:,2)>(min(snake.point(:,2))-10),:);
% peg = peg(peg(:,2)<(max(snake.point(:,2))+10),:);
% 
is_collision = 0;
bandwidth = 1.5;
D = pdist2(peg,snake.point);
radius = 5.5;
[row,col] = find(D<radius+bandwidth);% & D >=(radius-bandwidth));
snake.contact_pair = [row,col];
snake.contact = double((min(D)<radius+bandwidth) & (min(D)>=(radius-bandwidth)));
snake.contact_peg = double((min(D')<radius) & (min(D')>=(radius-bandwidth)));
if min(min(D))<radius-bandwidth
    is_collision = 1;
    snake.contact = 2*(min(D)<(radius-bandwidth))+snake.contact;
end


end

