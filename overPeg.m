function [ is_over ] = overPeg( last_snake, snake, peg )
%compute distances between obstacles and links
%contact with two circles
peg = peg(peg(:,1)>(min(snake.point(:,1))-10),:);
peg = peg(peg(:,1)<(max(snake.point(:,1))+10),:);
peg = peg(peg(:,2)>(min(snake.point(:,2))-10),:);
peg = peg(peg(:,2)<(max(snake.point(:,2))+10),:);
is_over = 0;

for i = 1:snake.num_module
    xv = [last_snake.backbone(i,1),last_snake.backbone(i+1,1),snake.backbone(i+1,1),snake.backbone(i,1),last_snake.backbone(i,1)];
    yv = [last_snake.backbone(i,2),last_snake.backbone(i+1,2),snake.backbone(i+1,2),snake.backbone(i,2),last_snake.backbone(i,2)];
    in = inpolygon(peg(:,1),peg(:,2),xv,yv);
    if sum(in) > 0
        is_over = 1;
        break
    end
end
end