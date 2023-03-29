%% Generates image of mandelbrot's set


function [img] = mandelbrot_generate(focus, magnitude, resolution)


%% Parameters:
if exist('resolution','var') == false; resolution = [2880; 1920]; end
%if exist('mag_0', 'var') == false; mag_0 = -2; end

xlim = focus(1,1) + [-1, 1]*10^(magnitude)*resolution(1,1)*0.5;
ylim = focus(2,1) + [-1, 1]*10^(magnitude)*resolution(2,1)*0.5;
n_x = resolution(1,1);
n_y = resolution(2,1);

%pix_width = abs(xlim(1,2)-xlim(1,1))/n_x;
it_max = round(abs(magnitude)*100);
%exponent = 0.2*(1-10^((magnitude - mag_0)*2)) + 2;


%% Matrix gunk setup shit;
[x,y] = meshgrid(linspace(xlim(1,1), xlim(1,2), n_x), ...
                 linspace(ylim(1,1), ylim(1,2), n_y));
x = reshape(x, 1, n_x*n_y); y = reshape(y, 1, n_x*n_y);


if gpuDeviceCount("available") == 0 % Checks if gpu is available, and if so runs the code on the gpu.
    c_mat = x + y*1i;
    it_mat = arrayfun(@iterate, c_mat);

else
    x = gpuArray(x); y = gpuArray(y);
    c_mat = x + y*1i;
    it_mat = arrayfun(@iterate, c_mat);
    it_mat = gather(it_mat);

end


img = reshape(it_mat, n_y, n_x);








    function value = iterate(c)
        z = complex(0);
        iteration = 0;
        while abs(z) < 2 && iteration < it_max
            z = z^2 + c;
            iteration = iteration + 1;
        end
        if iteration == it_max
        value = 0; else
        value = iteration;
        end
    end


end