function varargout = MagGridBot(varargin)
% MagGridBot MATLAB code for MagGridBot.fig
%      MagGridBot, by itself, creates a new MagGridBot or raises the existing
%      singleton*.
%
%      H = MagGridBot returns the handle to a new MagGridBot or the handle to
%      the existing singleton*.
%
%      MagGridBot('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MagGridBot.M with the given input arguments.
%
%      MagGridBot('Property','Value',...) creates a new MagGridBot or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MagGridBot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MagGridBot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MagGridBot

% Last Modified by GUIDE v2.5 13-Jun-2018 23:25:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MagGridBot_OpeningFcn, ...
                   'gui_OutputFcn',  @MagGridBot_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before MagGridBot is made visible.
function MagGridBot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MagGridBot (see VARARGIN)

% Choose default command line output for MagGridBot
handlesG.output = hObject;

% Update handles structure
guidata(hObject, handlesG);

% UIWAIT makes MagGridBot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MagGridBot_OutputFcn(hObject, eventdata, handlesG) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handlesG.output;



function edit1_Callback(hObject, eventdata, handlesG)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handlesG.Grid_Filename = get(hObject,'String');

% Open the File
    ext = '.txt';
    name = [handlesG.Grid_Filename ext];
    opener = fopen(name)
    UD = textscan(opener,'%f %f %f')
        LATITUDE  = UD{1,1};
        LONGITUDE = UD{1,2};
        MAGNETIC  = UD{1,3};

% Set Map Limits (In Degree Decimal)
y_min = min(LONGITUDE) ; 
y_max = max(LONGITUDE) ;
x_min = min(LATITUDE) ; 
x_max = max(LATITUDE) ;

d_map = (x_max - x_min)/200;

% Make uniform meshgrid
[x_map,y_map] = meshgrid([x_min:d_map:x_max],[y_min:d_map:y_max]); 
handlesG.X_m= LATITUDE;
handlesG.Y_m= LONGITUDE;
handlesG.Z_m= MAGNETIC;

% Use griddata to pull elevations for each meshgrid point
M_m=griddata(handlesG.X_m,handlesG.Y_m,handlesG.Z_m,x_map,y_map,'cubic');
contourf(x_map,y_map, M_m)
hold on
% Update handles structure
guidata(hObject, handlesG);

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handlesG)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handlesG)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% Plot profile across Hawaii
%%% Click 2 ponts on digital map north first followed by south. The
%%% clicked profile should be plotted on th emap and 100 data points
%%% along the profile plotted in figure 2

 out=ginput(2)

 %%%%%% set up 100 steps in x and y
 handlesG.xi= linspace(out(1,1),out(2,1),100);    
 handlesG.yi= linspace(out(1,2),out(2,2),100);

 hold on;
 plot(handlesG.xi,handlesG.yi,'-r','linewidth',3)

 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Project Points onto Best Fit UTM Line
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Convert LAT/LON to UTM Coordinates
[x_utm,y_utm,not_used] = deg2utm(handlesG.yi,handlesG.xi);

% Find Best Fit
Fit = polyfit(x_utm,y_utm,1);
m = Fit(1);
b = Fit(2);

% Get Positon Vector
Vec = [x_utm y_utm];

% Get Unit Line Vector
Proj_Line = [1 m];
    Proj_Line = Proj_Line / sqrt(Proj_Line(1)^2 + Proj_Line(2)^2);

for i =1:length(handlesG.yi)
% Project to This Line
Proj(i) = dot(Vec(i,:),Proj_Line);
end

% Set Start Point = Zero
 handlesG.Measurement_X = abs(Proj - Proj(1));
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 % Plot Profile
 handlesG.zi=griddata(handlesG.X_m,handlesG.Y_m,handlesG.Z_m,handlesG.xi,handlesG.yi);
 figure(2)
 plot(handlesG.Measurement_X,handlesG.zi,'.b')
 title('Magnetic Profile TJW 5-2-2018','FontSize',14)
 xlabel('Distance From Start (m)')
 ylabel('Magnetic Field (NanoTesla)')
 % Update handles structure
guidata(hObject, handlesG);


% --- Executes on button press in CLEAR.
function CLEAR_Callback(hObject, eventdata, handlesG)
% hObject    handle to CLEAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla


% --- Executes on button press in SAVE.
function SAVE_Callback(hObject, eventdata, handlesG)
% hObject    handle to SAVE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
LATITUDE = handlesG.yi;
    LATITUDE = LATITUDE';
LONGITUDE= handlesG.xi;
    LONGITUDE = LONGITUDE';
MAGNETIC = handlesG.zi;
    MAGNETIC = MAGNETIC';

cd ..
save Grid_Out  LATITUDE LONGITUDE MAGNETIC
% movefile MagGridBot_Out

% Run MagnetoBot
MagnetoBot.m
