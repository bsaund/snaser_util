function [ snake ] = ConfigurationToBackbone( snake )
% input snake_configuration is a row vector
head_L = (3.19+6.35)/2; % cm
snake.L = 6.39; % cm
snake.num_module = length(snake.configuration)-2;
snake.com = zeros(snake.num_module,3);
snake.com(1,:) = snake.configuration(1:3);
snake.backbone = zeros(snake.num_module+1,2);
snake.backbone(2,:) = [snake.com(1,1)+head_L*cos(snake.com(1,3)),snake.com(1,2)+head_L*sin(snake.com(1,3))];
snake.backbone(1,:) = [snake.com(1,1)-head_L*cos(snake.com(1,3)),snake.com(1,2)-head_L*sin(snake.com(1,3))];
for i = 1:snake.num_module-1
    snake.com(i+1,3) = snake.com(i,3)+snake.configuration(i+3);
    snake.com(i+1,1:2) = [snake.backbone(i+1,1)+snake.L*cos(snake.com(i+1,3)),snake.backbone(i+1,2)+snake.L*sin(snake.com(i+1,3))];
    snake.backbone(i+2,:) = [snake.com(i+1,1)+snake.L*cos(snake.com(i+1,3)),snake.com(i+1,2)+snake.L*sin(snake.com(i+1,3))];
end
snake.point = zeros(2*snake.num_module+1,2);
snake.point(1:2:end,:) = snake.backbone;
snake.point(2:2:end,:) = snake.com(:,1:2);

end

