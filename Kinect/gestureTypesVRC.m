% Function to set cell array of MOVEMENT TYPES for VRConnect
% -- gestureTypesVRC() creates list of definable movement
% -- This can be different for DIFFERENT SENSORS
% -- Basically a space saving measure, and we can modify only this function

% By: Matt Foreman

% -- Last Updated 12/15/15 -- %

%% CHANGELOG %%

% Updated 12/15/15
% -- Added functional space for further sensors
% -- Kinect V2, Leap sensor, Myo sensor

% Created 12/09/15


function movementList = gestureTypesVRC(sensorType)

% Inputs
% -- sensorType == Type of sensor (kinectV1, kinectV2, leap, myo)

% Outputs
% -- movementList == cell array of strings for movement types


%% SET MOVEMENT STRINGS %%

% Append these lists when new movements are added

% Kinect V1
if strcmpi(sensorType,'kinectV1')
    
    movementList = {'Choose exercise...'; ...
                    'Forward Reach'; ...
                    'Side Reach'; ...
                    'Vertical Reach'; ...
                    'Shoulder Flexion'; ...
                    'Shoulder Abduction'; ...
                    'Shoulder Internal Rotation'; ...
                    'Elbow Flexion'; ...
                    'Wrist Flexion'; ...
                    'Wrist Deviation'; ...
                    };
 
% Kinect V2
elseif strcmpi(sensorType,'kinectV2')
    
    movementList = {'Choose exercise...'; ...
                    'Forward Reach'; ...
                    'Side Reach'; ...
                    'Vertical Reach'; ...
                    'Shoulder Flexion'; ...
                    'Shoulder Abduction'; ...
                    'Shoulder Internal Rotation'; ...
                    'Elbow Flexion'; ...
                    'Wrist Flexion'; ...
                    'Wrist Deviation'; ...
                    };

% Leap sensor
elseif strcmpi(sensorType,'leapSensor')

% Myo sensor
elseif strcmpi(sensorType,'myoSensor')

% No recognizable sensor
else
    
    % Throw error dialog if no sensor type chosen
    errordlg('No working sensor type chosen!','Sensor Type Error');
    
end

