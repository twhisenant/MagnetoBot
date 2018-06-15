function  [Measurement_X,MAGNETIC] = TJW_DUMMY_MASTER_DATA(NAME,...
    FILE)
%TJW_DUMMY_MASTER Used for testing the communication between GUI and unseen
%files

% In GUI
% Fit = TJW_DUMMY_MASTER(handles.Name,handles.File,handles.Structure,...
%     handles.Inclin,handles.STRIKE,handles.Pos,handles.Dep,...
%     handles.Wid,handles.Len,handles.DIP,handles.Sus,handles.Off);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read in Magnetic Data from File Provided

% Plot User Data %
if FILE == 1
    ext = '-mat';
    load(NAME,ext)
elseif FILE == 2
    ext = '.csv';
    name = [NAME];
    fopen(name);
    UD = csvread(name);
        LATITUDE  = UD(:,1);
        LONGITUDE = UD(:,2);
        MAGNETIC  = UD(:,3);
elseif FILE == 3
    ext = '.txt';
    name = [NAME];
    opener = fopen(name);
    UD = textscan(opener,'%f %f %f');
        LATITUDE  = UD{1,1};
        LONGITUDE = UD{1,2};
        MAGNETIC  = UD{1,3};
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Points onto Best Fit UTM Line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert LAT/LON to UTM Coordinates
[x_utm,y_utm,not_used] = deg2utm(LATITUDE,LONGITUDE);

% Find Best Fit
Fit = polyfit(x_utm,y_utm,1);
m = Fit(1);
b = Fit(2);

% Get Positon Vector
Vec = [x_utm y_utm];

% Get Unit Line Vector
Proj_Line = [1 m];
    Proj_Line = Proj_Line / sqrt(Proj_Line(1)^2 + Proj_Line(2)^2);

for i =1:length(LATITUDE)
% Project to This Line
Proj(i) = dot(Vec(i,:),Proj_Line);
end

% Set Start Point = Zero
 Measurement_X = abs(Proj - Proj(1));
end