%% mandelbrot #4

%% Ok, so there are a lot of global variables in here, but I can explain myself.
% MATLAB doesn't let you pass output arguments through callbacks, so this
% is my only option as far as I know.

global magnitude
global focus
global main_plot
global resolution
global map
global contrast_data
format long

%% Turbospeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed
map = colormap('turbo');


magnitude = -2.5;
focus = [-0.5;0];
%magnitude = -17;
%focus = [0.344805312655833;0.056276952979636];
%magnitude = -8;
%focus = [0.329437386925848;0.042031781888114];



%resolution = round([2880; 1920]/4);
resolution = [3840;2160];

main_UI = uifigure('Name','Mandelbrot');
main_UI.KeyPressFcn = @keypress;
main_plot = uiaxes(main_UI, 'position', [1,1,1000, 700]);


disp('RENDERING...')

img = mandelbrot_generate(focus, magnitude, resolution);
[img, contrast_data] = imagecontrast(img);

img = round(img);
img = ind2rgb(img, map);
imshow(img, 'Parent', main_plot)


main_plot.XLim = [0, resolution(1,1)];
main_plot.YLim = [0, resolution(2,1)];

disp('RENDERED')


function keypress(~, event)

global magnitude
global focus
global main_plot
global resolution
global map
global contrast_data


event.Key
if strcmp(event.Key,'space') == true

% Updating the focus:
Df = 0.5*([sum(get(main_plot, 'Xlim'), 'all');
           sum(get(main_plot, 'Ylim'), 'all')] - resolution)*10^magnitude;


focus = focus + Df;

new_height = get(main_plot, 'Ylim');
new_height = new_height(1,2) - new_height(1,1);

d_magnitude = log10(new_height/resolution(2,1));
magnitude = magnitude + d_magnitude;

if magnitude < -12
digits(round(-magnitude)+6);
end


% Rendering the next frame:
disp('RENDERING...')
img = mandelbrot_generate(focus, magnitude, resolution);
[img, contrast_data] = imagecontrast(img);% contrast_data, 0.1);
img = round(img);
img = ind2rgb(img, map);
imshow(img, 'Parent', main_plot)
%imagesc(main_plot, img, 'XData', [0,resolution(1,1)], 'YData', [0, resolution(2,1)]);

main_plot.XLim = [0, resolution(1,1)];
main_plot.YLim = [0, resolution(2,1)];
drawnow
disp('RENDERED')




% Printout
disp('Magnitude:'+ string(magnitude))
disp('Cordinates')
focus


end
end
