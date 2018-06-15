function varargout = TJW_136C_FIG(varargin)
% TJW_136C_FIG MATLAB code for TJW_136C_FIG.fig
%      TJW_136C_FIG, by itself, creates a new TJW_136C_FIG or raises the existing
%      singleton*.
%
%      H = TJW_136C_FIG returns the handle to a new TJW_136C_FIG or the handle to
%      the existing singleton*.
%
%      TJW_136C_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TJW_136C_FIG.M with the given input arguments.
%
%      TJW_136C_FIG('Property','Value',...) creates a new TJW_136C_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TJW_136C_FIG_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TJW_136C_FIG_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TJW_136C_FIG

% Last Modified by GUIDE v2.5 14-Jun-2018 17:38:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TJW_136C_FIG_OpeningFcn, ...
                   'gui_OutputFcn',  @TJW_136C_FIG_OutputFcn, ...
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


% --- Executes just before TJW_136C_FIG is made visible.
function TJW_136C_FIG_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TJW_136C_FIG (see VARARGIN)

% Choose default command line output for TJW_136C_FIG
handles.output = hObject;

% Add Instruction Sheet
figure('Name','MagnetoBot Instructions',...
        'rend','painters',...
        'pos',[0 10000 500 400]);
    axis off
    text(0,0.75,{'MagnetoBot: Initial Guess Values Format',...
        ' ',...
        '1. Position- Horizontal Offset (in meters) of the anomaly',...
        '2. Depth (in meters) to the top of the anomaly',...
        '3. Width (in meters) of the anomaly',...
        '4. Length (in meters) of the anomaly',...
        '5. Dip (in degrees) of the dike face or fault plane',...
        '6. Magnetic Susceptibility',...
        '7. Constant Field (in nT) of the background B-field',...
        '8. Slope (in nT/meters) horizontal gradient of the B-field'},...
        'FontSize',16)
    
   text(0,0.2,{'MagnetoBot: Background Values Format',...
        ' ',...
        '1. Strike (in degrees) of the feature clockwise from North',...
        '2. Inclination (in degrees) for the region of study'},...
        'FontSize',16)

    % Turn Orange Warnings Off
        warning off;
    
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TJW_136C_FIG wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TJW_136C_FIG_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function FileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Regional Background Info
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STRIKE 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Strike_Callback(hObject, eventdata, handles)
% hObject    handle to Strike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear global fixparm(2)
STRIKE = str2double(get(hObject,'String'))
handles.STRIKE = STRIKE;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function Strike_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Strike (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inclination of Earth's Field
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Inclination_Callback(hObject, eventdata, handles)
% hObject    handle to Inclination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Inclination as text
%        str2double(get(hObject,'String')) returns contents of Inclination as a double
clear global fixparm(1)
Inclin = str2double(get(hObject,'String'))
handles.Inclin = Inclin;
guidata(hObject,handles)




% --- Executes during object creation, after setting all properties.
function Inclination_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Inclination (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dike Parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Position
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Position_Callback(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Pos = str2double(get(hObject,'String'))
handles.Pos = Pos;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Position_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Position (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Depth
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Depth_Callback(hObject, eventdata, handles)
% hObject    handle to Depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Dep = str2double(get(hObject,'String'))
handles.Dep = Dep;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Depth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Depth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Width
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Width_Callback(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Wid = str2double(get(hObject,'String'))
handles.Wid = Wid;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Width_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Width (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Length
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Length_Callback(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Len = str2double(get(hObject,'String'))
handles.Len = Len;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dip
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Dip_Callback(hObject, eventdata, handles)
% hObject    handle to Dip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dip = str2double(get(hObject,'String'))
handles.dip = dip;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Dip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Susceptibility
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Susceptibility_Callback(hObject, eventdata, handles)
% hObject    handle to Susceptibility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Sus = str2double(get(hObject,'String'))
handles.Sus = Sus;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Susceptibility_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Susceptibility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Offset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Offset_Callback(hObject, eventdata, handles)
% hObject    handle to Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Off = str2double(get(hObject,'String'))
handles.Off = Off;
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function Offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Slope (Background Mag Gradient)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Slope_Callback(hObject, eventdata, handles)
% hObject    handle to Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Slope as text
%        str2double(get(hObject,'String')) returns contents of Slope as a double

Slope = str2double(get(hObject,'String'))
handles.Slope = Slope;
guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function Slope_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Slope (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Monopole
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in Monopole.
function Monopole_Callback(hObject, eventdata, handles)
% hObject    handle to Monopole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Structure = [];
   Structure = 1;
   handles.Structure=Structure;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dipole
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in Dipole.
function Dipole_Callback(hObject, eventdata, handles)
% hObject    handle to Dipole (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Structure = [];
   Structure = 2;
   handles.Structure=Structure;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sheet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in Sheet.
function Sheet_Callback(hObject, eventdata, handles)
% hObject    handle to Sheet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Structure = [];
   Structure = 3;
   handles.Structure=Structure;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FileType
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MAT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in MAT.
function MAT_Callback(hObject, eventdata, handles)
% hObject    handle to MAT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.File = [];
   File = 1;
   handles.File=File;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CSV
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in csv.
function csv_Callback(hObject, eventdata, handles)
% hObject    handle to csv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.File = [];
   File = 2;
   handles.File=File;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TXT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in TXT.
function TXT_Callback(hObject, eventdata, handles)
% hObject    handle to TXT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.File = [];
   File = 3;
   handles.File=File;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File Name
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FileName_Callback(hObject, eventdata, handles)
% hObject    handle to FileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Name = get(hObject,'String');
handles.Name = Name;
guidata(hObject,handles)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Command Buttons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Display
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in DISP.
function DISP_Callback(hObject, eventdata, handles)
% hObject    handle to DISP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Measurement_X,MAGNETIC] = TJW_DUMMY_MASTER_DATA(handles.Name,handles.File);

% Plot Master Function Outputs %

    % Phony Plot for Legendary Purpose
     l(1) = plot(NaN,'ob');
     hold on
     grid on
     l(2) = plot(NaN,'-r');
     l(3) = plot(NaN,'-k');
         % Legend/Labels
         lg = legend(l,{'Data','Guess','Fit'});
            lg.FontSize = 14;

    % Grab Data
     handles.data_plot  = plot(Measurement_X,MAGNETIC,'bo');
         
         % Check if Guess has Been Made
         Ex = isfield(handles,'Structure');
         if Ex == 1;

% Input into Guess if Any Given
[thr,guess_thr,Measurement_X,MAGNETIC] = TJW_DUMMY_MASTER_DISPLAY(handles.Name,...
    handles.File,handles.Structure,...
    handles.Inclin,handles.STRIKE,handles.Pos,handles.Dep,...
    handles.Wid,handles.Len,handles.dip,handles.Sus,handles.Off,handles.Slope);
 
    % Plot the Guess
     handles.guess_plot = plot(thr,guess_thr,'-r','linewidth',2);
 
 % Labels
     xlabel('Distance from Start (m)','FontSize',14)
     ylabel('B-Field (nT)','FontSize',14)
     
         end
    
% Make handles carry over
guidata(hObject,handles)
    



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fit
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in FIT.
function FIT_Callback(hObject, eventdata, handles)
% hObject    handle to FIT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[Fit,STD,B_e,thr,guess_thr,fit_thr,Measurement_X,MAGNETIC] = TJW_DUMMY_MASTER(handles.Name,handles.File,handles.Structure,...
    handles.Inclin,handles.STRIKE,handles.Pos,handles.Dep,handles.Wid,...
    handles.Len,handles.dip,handles.Sus,handles.Off,handles.Slope);

    % Phony Plot for Legendary Purpose
     l(1) = plot(NaN,'ob');
      hold on
      grid on
     l(2) = plot(NaN,'-r');
     l(3) = plot(NaN,'-k');
         % Legend/Labels
         lg = legend(l,'Data','Guess','Fit');
            lg.FontSize = 14;
 
% Plot Master Function Outputs  
 handles.data_plot  = plot(Measurement_X,MAGNETIC,'bo');
 handles.guess_plot = plot(thr,guess_thr,'-r','linewidth',2);
 handles.fit_plot   = plot(thr,fit_thr,'-k','linewidth',2);
     
 % Send Fit Info Back in Digestible Way
     % Print to Command Window
 
 lab_par = {'Position: ','Depth: ','Width: ','Dip: ',...
     'Susceptibility: ','Background B-Field: ','Background Horizontal Gradient: '};
 lab_rap = {'(m)','(m)','(m)','(Deg)','()','(nT)','(nT/m)'};
 
 for i = 1:length(Fit)
     if i == 6
        disp([lab_par{i} num2str(Fit(i) + B_e) ' +/- ' num2str(3*STD(i)) '  ' lab_rap{i}])
     else
        disp([lab_par{i} num2str(Fit(i)) ' +/- ' num2str(3*STD(i)) '  ' lab_rap{i}])
     end
 end
 
% Make handles carry over
guidata(hObject,handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in CLEAR.
function CLEAR_Callback(hObject, eventdata, handles)
% hObject    handle to CLEAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla
    legend('hide')
