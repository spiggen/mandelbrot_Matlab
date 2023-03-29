%% Active-scaling


function [mat_out, line_out] = imagecontrast(matrix, prev_line, stepsize)
if exist('stepsize', 'var') == false; stepsize = 1;end
matrix = matrix.^2;

min_in = min(matrix,[],'all');
max_in = max(matrix,[],'all');

min_value = 1;
max_value = 254;

k1 = 8.5*numel(matrix)/sum(matrix,'all');
k2 = (max_value - min_value)/(max_in - min_in);
k = (k1+k2)/2;
m = min_in*k + min_value;


v2_hat = [-k;1]/sqrt(1+k^2); % Characteristic vector for the new line
v2_mag = m/sqrt(1+k^2);

if exist('prev_line', 'var')
    v1_hat = prev_line(1:2,1); % Characteristic vector for the previous line
    v1_mag = prev_line(3,1);
    
    

    theta = acos(dot(v2_hat, v1_hat))*stepsize;
    if r2cross(v2_hat, v1_hat) > 0; theta = -theta; end

    transformation_mat = [cos(theta), -sin(theta);
                          sin(theta), cos(theta)];

    v2_hat = transformation_mat*v1_hat;
    v2_mag = v1_mag + (v2_mag-v1_mag)*stepsize;
    
    
    k = -v2_hat(1,1)/v2_hat(2,1);
    m = (v2_mag^2)/v2_hat(2,1);


end




f = @(x) x.*k + m;
%g = @(x) (254*2/pi)*atan((pi/2)*x/254);

% x_vec1 = min_in:max_in;
% y_vec1 = round(g(f(x_vec1)));
% x_vec2 = [max_in, max_in];
% y_vec2 = [1, 254];
% x_vec3 = [min_in, min_in];
% y_vec3 = [1, 254];
% 
% plot(x_vec1, y_vec1, ...
%      x_vec2, y_vec2, ...
%      x_vec3, y_vec3)

%matrix = matrix.^2;
matrix = f(matrix);
matrix = matrix - (matrix > 255).*(matrix - 255);
mat_out = round(matrix);
line_out = [v2_hat;v2_mag];

end