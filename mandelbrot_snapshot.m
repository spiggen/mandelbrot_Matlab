%% Snapshot

function mandelbrot_snapshot(focus,magnitude, resolution, filename)
map = colormap('turbo');
img = mandelbrot_generate(focus, magnitude, resolution);
img = imagecontrast(img);
img = ind2rgb(img, map);

imwrite(img, map, filename)
end