% Function to recognize gestures/movements from the Kinect
% Intended to work with data structures from VRConnect


% By: Matt Foreman

% -- Last Updated 01/11/2016 -- %


%% CHANGELOG %%

% Updated 01/11/16 -- MHF
% -- Added bounds for repetition failure
% -- Failure = 1 if (failPercent*thresh < moveDist < Thresh)

% Updated 11/19/15 -- MHF
% -- Added movements! (shoulder, elbow, wrist)

% Updated 11/17/15  -- MHF
% -- Added trigger and reset outputs to facilitate "movement reloading"
% -- Added ROM handle updater (and guidata to update)

% Created 11/06/15 -- MHF


function [moveTrigger,moveReset,moveFail] = gestureDetectorVRC(joints,s,figureHandles,side)

% Function inputs:
% -- (s.movement.left and s.movement.right preallocated)
% -- joints = 3D joint coordinates from the Kinect
% -- s = structure for left/right movement from VRConnect main GUI
% -- figureHandles = handles of VRConnect GUI
% -- side = side of body (left, right, or none)

% Function outputs:
% -- moveTrigger = Did the movement exceed 100% ROM (1/0)?
% -- moveReset = Did the movement come back to less than 20% ROM (1/0)?
% -- moveFail = Did the movement reach 80% of ROM but not 100% (1/0)?

% Movement types:
% (1) Forward reach = 'Forward Reach'
% (2) Side reach 
% (3) Vertical reach
% (4) Shoulder flexion
% (5) Shoulder abduction
% (6) Shoulder internal rotation 
% (7) Elbow flexion
% (8) Wrist flexion
% (9) Wrist deviation


%% PARAMETERS %%

% Set initial values
resetPercentage = 0.50;
failPercentage = 0.80;


%% FORWARD REACH %%

% Forward reach = Hand > Shoulder by ROM in Z-Direction
if strcmpi(side,'left') && strcmpi(s.type,'Forward Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Left - Shoulder_Left) in the Z-Direction
    % -- This will be a negative value (in negative z-direction)
    moveDist = joints(8,3) - joints(5,3);
    moveDist = -(moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist*100)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    % -- Sign for this movement adjusted above
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Forward Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Right - Shoulder_Right) in the Z-Direction
    % -- This value will be negative (in negative Z-direction)
    moveDist = joints(12,3) - joints(9,3);
    moveDist = -(moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist*100)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end  


%% SIDE REACH %%

% Side reach = Hand > Shoulder by ROM in X-Direction
if strcmpi(side,'left') && strcmpi(s.type,'Side Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Left - Shoulder_Left) in the X-Direction
    % - This value will be negative
    moveDist = joints(8,1) - joints(5,1);
    moveDist = -(moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist*100)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Side Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Right - Shoulder_Right) in the X-Direction
    % - This value should be positive
    moveDist = joints(12,1) - joints(9,1);
    moveDist = (moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist*100)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% VERTICAL REACH %%

% Vertical reach = Hand > Shoulder by ROM in X-Direction
if strcmpi(side,'left') && strcmpi(s.type,'Vertical Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Left - Shoulder_Left) in the Y-Direction
    % - This value should be positive 
    moveDist = joints(8,2) - joints(5,2);
    moveDist = (moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Vertical Reach')
    
    % Convert ROM from centimeters to meters
    s.rom = s.rom/100;
    
    % (Hand_Right - Shoulder_Right) in the Y-Direction
    % - This value should be positive 
    moveDist = joints(12,2) - joints(9,2);
    moveDist = abs(moveDist);
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% SHOULDER FLEXION %%

% Shoulder flexion
% -- Vector1 = humerus (elbow-shoulder)
% -- Vector2 = torso/neck (head-shoulderCenter)
% -- Vector2 (alt) = global y-axis
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Shoulder Flexion')
    
    % Humerus vector
    % (Elbow_Left - Shoulder_Left) 
    vector1 = [joints(6,1) joints(6,2) joints(6,3)] - [joints(5,1) joints(5,2) joints(5,3)];
    
    % Torso/neck vector
    % (ShoulderCenter - Head)
    % - Want this pointed downward for neutral position
    vector2 = [joints(3,1) joints(3,2) joints(3,3)] - [joints(4,1) joints(4,2) joints(4,3)];
  
    % Interested in XZ plane for flexion
    % -- Convert to unit vectors
    vector1(1) = 0;
    vector1 = vector1/norm(vector1);
    vector2(1) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Shoulder Flexion')
    
    % Humerus vector
    % (Elbow_Right - Shoulder_Right) 
    vector1 = [joints(10,1) joints(10,2) joints(10,3)] - [joints(9,1) joints(9,2) joints(9,3)];
    
    % Torso/neck vector
    % (ShoulderCenter - Head)
    % - Want this pointed downwards for neutral position
    vector2 = [joints(3,1) joints(3,2) joints(3,3)] - [joints(4,1) joints(4,2) joints(4,3)];
  
    % Interested in XZ plane for flexion
    % -- Convert to unit vectors
    vector1(1) = 0;
    vector1 = vector1/norm(vector1);
    vector2(1) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% SHOULDER ABDUCTION %%

% Shoulder abduction
% -- Vector1 = humerus (elbow-shoulder)
% -- Vector2 = shoulders (shoulderLeft - shoulderRight)
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Shoulder Abduction')
    
    % Humerus vector
    % (Elbow_Left - Shoulder_Left) 
    vector1 = [joints(6,1) joints(6,2) joints(6,3)] - [joints(5,1) joints(5,2) joints(5,3)];
    
    % Shoulders vector
    % (ShoulderLeft - ShoulderRight)
    % - Want this pointed downward for neutral position
    vector2 = [joints(5,1) joints(5,2) joints(5,3)] - [joints(9,1) joints(9,2) joints(9,3)];
  
    % Interested in XY plane for abduction
    % -- Convert to unit vectors
    vector1(3) = 0;
    vector1 = vector1/norm(vector1);
    vector2(3) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    % - 90 minus this angle is the actual angle
    % - If humerus points above shoulder, angle is > 90
    moveDist = acosd(dot(vector1,vector2));
    if vector1(2) > vector2(2)
        moveDist = 90 + moveDist;
    else
        moveDist = 90 - moveDist;
    end
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Shoulder Abduction')
    
    % Humerus vector
    % (Elbow_Right - Shoulder_Right) 
    vector1 = [joints(10,1) joints(10,2) joints(10,3)] - [joints(9,1) joints(9,2) joints(9,3)];
    
    % Shoulders vector
    % (ShoulderRight - ShoulderLeft)
    % - Want this pointed downward for neutral position
    vector2 = [joints(9,1) joints(9,2) joints(9,3)] - [joints(5,1) joints(5,2) joints(5,3)];
  
    % Interested in XY plane for abduction
    % -- Convert to unit vectors
    vector1(3) = 0;
    vector1 = vector1/norm(vector1);
    vector2(3) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    % - 90 minus this angle is the actual angle
    % - If humerus points above shoulder, angle is > 90
    moveDist = acosd(dot(vector1,vector2));
    if vector1(2) > vector2(2)
        moveDist = 90 + moveDist;
    else
        moveDist = 90 - moveDist;
    end
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% SHOULDER INTERNAL ROTATION %%

% Shoulder internal rotation
% -- Vector1 = forearm (wrist-elbow)
% -- Vector2 = shoulders (shoulderLeft - shoulderRight)
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Shoulder Internal Rotation')
    
    % Forearm vector
    % (Wrist_Left - Elbow_Left) 
    vector1 = [joints(7,1) joints(7,2) joints(7,3)] - [joints(6,1) joints(6,2) joints(6,3)];
    
    % Shoulders vector
    % (ShoulderRight - ShoulderLeft)
    % - Assuming forearm is horizontal (oriented in XZ plane)
    vector2 = [joints(9,1) joints(9,2) joints(9,3)] - [joints(5,1) joints(5,2) joints(5,3)];
  
    % Interested in XZ plane for internal rotation
    % -- Convert to unit vectors
    vector1(2) = 0;
    vector1 = vector1/norm(vector1);
    vector2(2) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    % - 90 minus this angle is the actual angle
    % - If humerus points above shoulder, angle is > 90
    moveDist = acosd(dot(vector1,vector2));
    moveDist = 90 - moveDist;
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Shoulder Internal Rotation')
    
    % Forearm vector
    % (Wrist_Right - Elbow_Right) 
    vector1 = [joints(11,1) joints(11,2) joints(11,3)] - [joints(10,1) joints(10,2) joints(10,3)];
    
    % Shoulders vector
    % (ShoulderLeft - ShoulderRight)
    % - Assuming forearm is horizontal (oriented in XZ plane)
    vector2 = [joints(5,1) joints(5,2) joints(5,3)] - [joints(9,1) joints(9,2) joints(9,3)];
  
    % Interested in XZ plane for internal rotation
    % -- Convert to unit vectors
    vector1(2) = 0;
    vector1 = vector1/norm(vector1);
    vector2(2) = 0;
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    % - 90 minus this angle is the actual angle
    moveDist = acosd(dot(vector1,vector2));
    moveDist = 90 - moveDist;
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% ELBOW FLEXION %%

% Elbow flexion
% -- Vector1 = forearm (wrist-elbow)
% -- Vector2 = humerus (elbow-shoulder)
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Elbow Flexion')
    
    % Forearm vector
    % (Wrist_Left - Elbow_Left) 
    vector1 = [joints(7,1) joints(7,2) joints(7,3)] - [joints(6,1) joints(6,2) joints(6,3)];
    
    % Humerus vector
    % (Elbow_Left - Shoulder_Left)
    % - Assuming forearm is 
    vector2 = [joints(6,1) joints(6,2) joints(6,3)] - [joints(5,1) joints(5,2) joints(5,3)];
  
    % Composite 3D angle for elbow flexion
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Elbow Flexion')
    
    % Forearm vector
    % (Wrist_Right - Elbow_Right) 
    vector1 = [joints(11,1) joints(11,2) joints(11,3)] - [joints(10,1) joints(10,2) joints(10,3)];
    
    % Humerus vector
    % (Elbow_Right - Shoulder_Right)
    vector2 = [joints(10,1) joints(10,2) joints(10,3)] - [joints(9,1) joints(9,2) joints(9,3)];
  
    % 3D composite angle for elbow flexion
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% WRIST FLEXION %%

% Wrist flexion
% -- Vector1 = hand (hand-wrist)
% -- Vector2 = forearm (wrist-elbow)
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Wrist Flexion')
    
    % Hand vector
    % (Hand_Left - Wrist_Left) 
    vector1 = [joints(8,1) joints(8,2) joints(8,3)] - [joints(7,1) joints(7,2) joints(7,3)];
    
    % Forearm vector
    % (Wrist_Left - Elbow_Left)
    vector2 = [joints(7,1) joints(7,2) joints(7,3)] - [joints(6,1) joints(6,2) joints(6,3)];
  
    % Composite 3D angle for wrist flexion and deviation (only way)
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Wrist Flexion')
    
    % Hand vector
    % (Hand_Right - Wrist_Right) 
    vector1 = [joints(12,1) joints(12,2) joints(12,3)] - [joints(11,1) joints(11,2) joints(11,3)];
    
    % Forearm vector
    % (Wrist_Right - Elbow_Right)
    vector2 = [joints(11,1) joints(11,2) joints(11,3)] - [joints(10,1) joints(10,2) joints(10,3)];
  
    % 3D composite angle for wrist flexion and deviation
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


%% WRIST DEVIATION %%

% Wrist deviation
% -- Vector1 = hand (hand-wrist)
% -- Vector2 = forearm (wrist-elbow)
% -- Angle between Vector 1 and Vector2
if strcmpi(side,'left') && strcmpi(s.type,'Wrist Deviation')
    
    % Hand vector
    % (Hand_Left - Wrist_Left) 
    vector1 = [joints(8,1) joints(8,2) joints(8,3)] - [joints(7,1) joints(7,2) joints(7,3)];
    
    % Forearm vector
    % (Wrist_Left - Elbow_Left)
    vector2 = [joints(7,1) joints(7,2) joints(7,3)] - [joints(6,1) joints(6,2) joints(6,3)];
  
    % Composite 3D angle for wrist flexion and deviation (only way)
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.leftRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.leftRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
elseif strcmpi(side,'right') && strcmpi(s.type,'Wrist Deviation')
    
    % Hand vector
    % (Hand_Right - Wrist_Right) 
    vector1 = [joints(12,1) joints(12,2) joints(12,3)] - [joints(11,1) joints(11,2) joints(11,3)];
    
    % Forearm vector
    % (Wrist_Right - Elbow_Right)
    vector2 = [joints(11,1) joints(11,2) joints(11,3)] - [joints(10,1) joints(10,2) joints(10,3)];
  
    % 3D composite angle for wrist flexion and deviation
    % - Convert to unit vectors
    vector1 = vector1/norm(vector1);
    vector2 = vector2/norm(vector2);
    
    % Angle between vector1 and vector2
    % - This will always be positive and between 0 and 180
    moveDist = acosd(dot(vector1,vector2));
    
    % Update ROM figure handle
    % -- This should probably be moved outside of this function
    set(figureHandles.rightRomEditDisplay,'String',num2str(round(moveDist)));
    guidata(figureHandles.rightRomEditDisplay);
    
    % ROM Threshold for comparison
    moveThresh = s.rom;
    
    % Determine if beyond ROM threshold
    if moveDist >= moveThresh  
        moveTrigger = 1;
        moveReset = 0;
    elseif moveDist <= (resetPercentage * moveThresh) 
        moveReset = 1;
        moveTrigger = 0;
    else
        moveTrigger = 0; 
        moveReset = [];
    end
    
    % Determine if in failure zone
    if (moveDist >= (failPercentage * moveThresh)) && (moveDist <= (moveThresh))
        moveFail = 1;
    else
        moveFail = 0;
    end
    
end 


