%% Get the cones of uncertainty for each prediction 
% Read html from NOAA page 
w = webread('https://www.nhc.noaa.gov/gis/archive_forecast_results.php?id=al05&year=2019&name=Hurricane%20DORIAN');
% Get a list of the filenames
w2 = string(extractBetween(w,"<br>",".zip</a>"));
filelist = extractBetween(w2,"/archive/",".zip");
% Fix the first filename
filelist(1) = "al052019_5day_001"; 
% Store data
data = table('Size',[length(filelist),4],...
    'VariableNames',{'Time','Lat','Lon','Type'},...
    'VariableTypes',{'string','cell','cell','string'});
for ii = 1:length(filelist)
    fname = filelist(ii)+".zip";
    url = "https://www.nhc.noaa.gov/gis/forecast/archive/"+fname;
    websave(fname,url);
    fnames = unzip(fname);
    parts = split(filelist(ii),'_');
    sfile = "al052019-"+parts(3)+"_5day_pgn.shp";
    s = shaperead(sfile,'UseGeoCoords',true);
    data.Time(ii) = s.ADVDATE;
    data.Lat{ii} = s.Lat;
    data.Lon{ii} = s.Lon;
    data.Type(ii) = s.STORMTYPE;
    delete(fname,fnames{:})
    disp("Processed "+fname)
end

%% Save processed data for later
save dorian.mat data


