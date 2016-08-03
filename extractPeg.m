function [ pegCenter ] = extractPeg( planar )
pegCenter = [];

threshold_neighbor_distance = 10; 
if size(planar,1) > 5
for k = min(10,size(planar,1)):-1:1
    [idx,C] = kmeans(planar,k);
    D = min(min(squareform(pdist(C))+100*eye(k)));
    if D > threshold_neighbor_distance
        break
    end
end

% 
threshold_neighbor_volume = 10;
threshold_circle_fit_error = 0.3;
% D = squareform(pdist(planar));
% D_neighbor = diag(D(1:end-1,2:end));
% neighbor = find(D_neighbor > threshold_neighbor_distance);
% segment = [[1;neighbor],[neighbor;size(planar,1)]];
% segment = [segment,segment(:,2)-segment(:,1)];
% segment = sortrows(segment,-3);
% segment = segment(segment(:,3)>threshold_neighbor_volume,:);
pegCenter = [];
% figure(2)
% hold on
for i = 1:k
    if sum(idx == i) > threshold_neighbor_volume
        [X,fval] = fitcircle(planar(idx == i,:),threshold_circle_fit_error,threshold_neighbor_volume);
%         scatter(planar(idx == i,1),planar(idx == i,2))
        if fval < threshold_circle_fit_error
            pegCenter = [pegCenter;X];
        end
    end
end
if size(pegCenter,1) >1
%     scatter(pegCenter(:,1),pegCenter(:,2),'k','fill')
    pegCenter = [pegCenter];
end
end
end


