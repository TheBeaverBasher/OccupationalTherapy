% Function to decide the skeleton mapping for the Kinect
% -- Seated mode (10 joints, 9 segments)
% -- Full body mode (20 joints, 19 segments)

% By: Matt Foreman

% -- Last updated 11/05/15 -- %


%% CHANGELOG %%

% Created 11/05/15


function skeletonConnections = skeletonConnectionMapper(mode)


%% Seated Mode %%

if strcmpi(mode,'Seated')
    
    % -- Seated mode (10 joints, 9 segments)
    skeletonConnections = [[3 4];   % Shoulder_Center to Head
                           [3 5];   % Shoulder_Center to Shoulder_Left
                           [5 6];   % Shoulder_Left to Elbow_Left
                           [6 7];   % Elbow_Left to Wrist_Left
                           [7 8];   % Wrist_Left to Hand_Left
                           [3 9];   % Shoulder_Center to Shoulder_Right
                           [9 10];  % Shoulder_Right to Elbow_Right
                           [10 11]; % Elbow_Right to Wrist_Right
                           [11 12]]; % Wrist_Right to Hand_Right
                       
end


%% Full Body Mode %%

if strcmpi(mode,'FullBody')
    
    % -- Full body mode (20 joints, 19 segments)
    skeletonConnections = [[1 2];   % Spine
                           [2 3];
                           [3 4];
                           [3 5];   % Left Hand
                           [5 6];
                           [6 7];
                           [7 8];
                           [3 9];   % Right Hand
                           [9 10];
                           [10 11];
                           [11 12];
                           [1 17];  % Right Leg
                           [17 18];
                           [18 19];
                           [19 20];
                           [1 13];  % Left Leg
                           [13 14];
                           [14 15];
                           [15 16]];
                       
end



