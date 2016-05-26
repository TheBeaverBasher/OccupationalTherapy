% Function to set string array for GAME TYPES for VRConnect
% -- plotTypesVRC() gets a list of games from the 'Games' folder
% -- This may eventually be different for different sensors?

% By: Matt Foreman

% -- Last Updated 02/17/16 -- %


%% CHANGELOG %%

% Created 02/17/16


function gameTypes = gameTypesVRC(sensorType)

% Inputs
% -- sensorType == Type of sensor (kinectV1, kinectV2, leap, myo)

% Outputs
% -- gameTypes == cell array of strings for game types


%% SET GAME STRINGS %%

% Get current working directory
currentFolder = pwd;

% Populate Games
% -- This should automatically update when games are dumped in the folder
gameFolder = dir([currentFolder,'\Games\']);
gameFolder = gameFolder(3:end);

% Create game list
gameList{1} = 'Choose game...';
for k = 2:length(gameFolder)
    gameList{k} = gameFolder(k).name;
end

% gameTypes = gameList
gameTypes = gameList;


% Eventually have an IF statement for different game types for sensors?
% Could navigate to different folders in 'Games'

% Kinect V1
if strcmpi(sensorType,'kinectV1')
 
% Kinect V2
% -- Should theoretically always be the same as KinectV1
elseif strcmpi(sensorType,'kinectV2')

% Leap sensor
elseif strcmpi(sensorType,'leapSensor')

% Myo sensor
elseif strcmpi(sensorType,'myoSensor')

% No recognizable sensor
else
    
    % Throw error dialog if no sensor type chosen
    errordlg('No working sensor type chosen!','Sensor Type Error');
    
end

