function  [Fit,STD,B_e,thr,guess_thr,fit_thr,Measurement_X,MAGNETIC] = TJW_DUMMY_MASTER(NAME,...
    FILE,STRUCTURE,INCLINATION,STRIKE,POSITION,DEPTH,WIDTH,...
    LENGTH,DIP,SUSCEPTIBILITY,OFFSET,SLOPE)
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STATUS: Have LONGITUDE,LATITUDE, and MAGNETIC Variables
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     % Fill in Fixed Parameters
%     global fixparm
%     % Est Global Values
% 
%         % Radian Conversion
%             dr		= pi/180;
% 
%     incb = INCLINATION*dr;     % Inclination
%     beta = (360-(STRIKE))*dr;  % Input = Clockwise Deg, Output = Counterclockwise Rad
%     length1 = LENGTH;
%     fixparm = [incb, beta,length1];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get Idea of Magnetic Field of Earth at measurement point

B_e = mean(MAGNETIC);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Send out Data to Appropriate Model (by Structure Choice)

    % STRUCTURE 1: MONOPOLE
    if STRUCTURE == 1
        % FORM THE GUESS
        Guess = [POSITION,DEPTH,WIDTH,DIP*pi/180,SUSCEPTIBILITY,OFFSET,SLOPE];
        % INVOKE NLINFIT
        [Fit, r, J, COVB, mse] = nlinfit([Measurement_X,B_e,INCLINATION,STRIKE,LENGTH],MAGNETIC,@Monopole,Guess);
        % Outputs
        thr = min(Measurement_X):(max(Measurement_X)- min(Measurement_X))/100:max(Measurement_X);
        guess_thr = Monopole(Guess,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
        fit_thr   = Monopole(Fit,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
    elseif STRUCTURE == 2
        % FORM THE GUESS
        Guess = [POSITION,DEPTH,WIDTH,DIP*pi/180,SUSCEPTIBILITY,OFFSET,SLOPE];
        % INVOKE NLINFIT
        [Fit, r, J, COVB, mse] = nlinfit([Measurement_X,B_e,INCLINATION,STRIKE,LENGTH],MAGNETIC,@Dipole,Guess);
        % Outputs
        thr = min(Measurement_X):(max(Measurement_X)- min(Measurement_X))/100:max(Measurement_X);
        guess_thr = Dipole(Guess,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
        fit_thr   = Dipole(Fit,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
    elseif STRUCTURE == 3
        % FORM THE GUESS
        Guess = [POSITION,DEPTH,WIDTH,DIP*pi/180,SUSCEPTIBILITY,OFFSET,SLOPE];
        % INVOKE NLINFIT
        [Fit, r, J, COVB, mse] = nlinfit([Measurement_X,B_e,INCLINATION,STRIKE,LENGTH],MAGNETIC,@Semi_Inf_Sheet,Guess);
        % Outputs
        thr = min(Measurement_X):(max(Measurement_X)- min(Measurement_X))/100:max(Measurement_X);
        guess_thr = Semi_Inf_Sheet(Guess,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
        fit_thr   = Semi_Inf_Sheet(Fit,[thr,B_e,INCLINATION,STRIKE,LENGTH]);
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STATUS: Have fitted variables and COVB for requested structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Get Standard Deviation of Each Guess Parameter
std_sqrd = diag(COVB);
    STD = std_sqrd .^ (0.5);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the Data and Fit
% figure(42)
% plot(Measurement_X,MAGNETIC,'bo')
%   hold on
%     plot(thr,fit_thr,'-k')

% Save to a .mat File
save MagnetoBot_Out Fit STD thr guess_thr fit_thr Measurement_X MAGNETIC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% STATUS: Numbers and FIgures Shown and Saved
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Send inputs back to OG GUI

% Display extras
    % Guesses +- 3 Std Deviations
end

