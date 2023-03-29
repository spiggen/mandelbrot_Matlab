
%% Video- render

focus = [0.329437386925848;0.042031781888114];
resolution = [3840;2160];
%resolution = round(1000*[3840;2160]/norm([3840;2160]));

map = colormap('turbo');
videoObj = VideoWriter('Mandelbrots_buttcrack_4.avi');

videoObj.FrameRate = 24;
%videoObj.FrameRate = 0.5;
open(videoObj);

for magnitude = -2.5:-0.01:-15
%for magnitude = -2:-2:-14
%disp('RENDERING...')
img = mandelbrot_generate(focus, magnitude, resolution);
if exist('contrast_data', 'var')
[img, contrast_data] = imagecontrast(img, contrast_data, 0.001);
else
[img, contrast_data] = imagecontrast(img);
end
img = ind2rgb(img, map);
disp('RENDERED:¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨¨') % Cat made an edit to my script. I'm gonna keep it.
videoObj.writeVideo(img);
disp(string(magnitude))
end
disp('finished')

close(videoObj);

% test