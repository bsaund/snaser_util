function [ snake ] = localization_only( inputPts,map,snake )
if isempty(inputPts)
    snake.T = config2T(snake.possible_configuration(1,:));
else
    N_sample = size(snake.possible_configuration,1);
    % map = prevT\[map';ones(1,size(map,1))];
    % map = map(1:2,:)';

    score = zeros(1,N_sample);
    for n = 1:N_sample
        T = config2T(snake.possible_configuration(n,:));
        temp = T*[inputPts';ones(1,size(inputPts,1))];
        costMatrix = pdist2(map,temp(1:2,:)');
        costOfNonAssignment = 10;
        [assignments, ~, ~] = assignDetectionsToTracks( costMatrix,costOfNonAssignment);
        prevPts = map(assignments(:,1),:);
        currPts = temp(1:2,assignments(:,2))';
        score(n) = norm(prevPts-currPts)/size(assignments,1) + norm(snake.configuration(1:2)-snake.possible_configuration(n,1:2));
    end
    snake.T = config2T(snake.possible_configuration(score == min(score),:));
%     temp = snake.T*[inputPts';ones(1,size(inputPts,1))];
%     costMatrix = pdist2(map,temp(1:2,:)');
%     costOfNonAssignment = 10;
%     [~, ~, unassignedDetections] = assignDetectionsToTracks( costMatrix,costOfNonAssignment);
% 
%     if ~isempty(unassignedDetections)
%         map = [map;temp(1:2,unassignedDetections)'];
%     end
end
end

