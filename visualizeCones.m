%% Plot cones of uncertainty for Hurricane Dorian

% Load previously imported data
load dorian

% Plot on map over time
figure;
g = geoaxes('Basemap','colorterrain');
hold on
for ii = 1:height(data)
    geoplot(g,data.Lat{ii},data.Lon{ii},'k');
    title(["Uncertainty Cones, Hurricane Dorian",data.Time(ii)])
    pause(0.25)
end
hold off

%% Create video
clear frame
v = VideoWriter('dorian.avi');
v.FrameRate = 10;
open(v)
figure;
g = geoaxes('Basemap','colorterrain');
hold on
for ii = 1:height(data)
    geoplot(g,data.Lat{ii},data.Lon{ii},'k');
    title(["Uncertainty Cones, Hurricane Dorian",data.Time(ii)])
    pause(0.25)
    frame = getframe(gcf);
    writeVideo(v,frame);
end
hold off
close(v)
