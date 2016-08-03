function [X,fval] = fitcircle(data,threshold_circle_fit_error,threshold_neighbor_volume)
%% least square
% n = size(data,1);
% A = [-2*data(:,1),ones(n,1),-2*data(:,2),ones(n,1)];
% b = 9 - data(:,1).^2-data(:,2).^2;
% X = A\b;

%% optimization
r = 3;
func = @(x) norm((data(:,1)-x(1)).^2+(data(:,2)-x(2)).^2-r^2);
[X,fval] = fminsearch(func,mean(data));
fval = fval/size(data,1);
n_loop = 1;
while 1
    if size(data,1)>threshold_neighbor_volume
        score = abs((data(:,1)-X(1)).^2+(data(:,2)-X(2)).^2-r^2);
        data = sortrows([data,score],3);
        
        data = data(1:(10+(size(data,1)-10)*0.6),1:2);
        func = @(x) norm((data(:,1)-x(1)).^2+(data(:,2)-x(2)).^2-r^2);
        [X,fval] = fminsearch(func,X);
        fval = fval/size(data,1);
        if fval < threshold_circle_fit_error || n_loop > 10
            break
        end
        n_loop = n_loop + 1;
    else
        break
    end
end


end

