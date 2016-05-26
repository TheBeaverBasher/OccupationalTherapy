% Main function body for collecting, displaying, and running Kinect 
% This function is made specifically for the VRConnect GUI
% (1) Opens Kinect streams through IMAQ with color and depth data
% (2) Displays color, depth, skeleton data in VRConnect main axes (axes1)
% (3) Recognizes gestures from motion data (gestureDetectVRC) 
% (4) Uses gesture data to emulate keyboard ()
% (5) Saves movement data in useful format ()

% -- By Matt Foreman

% -- Last Updated 11/19/15 -- %


%% CHANGELOG %%

% Updated 11/19/15
% -- Added interrupt for while loop when EndSession button pressed

% Updated 11/17/15
% -- Added an axis rest for depthData to improve efficiency

% Updated 11/16/15
% -- Moved some loading/streaming commands to improve efficiency
% -- Clear data at certain points to improve efficiency
% -- Added an axis reset to improve efficiency for colorData

% Created 11/06/15


function [] = mainKinectVRC(figureHandles,s,mode,display)

% Function inputs:
% figureHandles = handles structure for VRConnect GUI (axes1 main)
% s = structure of movement and output values/types from VRC GUI
% mode = 'FullBody' or 'Seated'
% display = 'Depth' or 'Color' or 'None'


%% SENSOR SETUP %%

% Add utility functions to Matlab path
% utilpath = fullfile(matlabroot,'toolbox','imaq','imaqdemos', ...
%                     'html','KinectForWindows');
% addpath(utilpath);
                
% See Kinect Devices available
hwInfo = imaqhwinfo('kinect');

% Disable start button in main GUI
set(figureHandles.runButton,'Enable','off');


%% SET COLOR AND DEPTH OBJECTS %%

% Create object for color stream
colorVid = videoinput('kinect',1);

% Create object for depth stream
depthVid = videoinput('kinect',2);

% Set the triggering mode
triggerconfig([colorVid depthVid],'manual');

% Set trigger repeat to infinite
colorVid.triggerRepeat = inf;
depthVid.triggerRepeat = inf;

% Set frames per trigger
% -- Could change this frames per trigger to 1 and loop
colorVid.FramesPerTrigger = 1;
depthVid.FramesPerTrigger = 1;


%% CONFIGURE SKELETON TRACKING %%

% Get the videosource object from the depth device
depthSrc = getselectedsource(depthVid);

% Turn on skeleton tracking
% -- TrackingMode = Skeleton, Position, or Off
depthSrc.TrackingMode = 'Skeleton';

% Set to seated mode
% -- BodyPosture = Standing or Seated
depthSrc.BodyPosture = 'Seated';


%% MAIN LOOP SETUP %%

% Repetition reset parameters
j = 0;
leftTriggerMod = 0;
leftResetMod = 1;
leftFailMod = 0;
rightTriggerMod = 0;
rightResetMod = 1;
rightFailMod = 0;

% Tracker of previous zones traversed (see repFailVRC)
leftZones = [2 2 2];
rightZones = [2 2 2];

% Repetition counting variables
% -- leftReps = left repetitions completed
% -- rightReps = right repetitions completed
% -- leftFails = left reps attempted & failed
% -- rightFails = right reps attempted & failed
leftReps = 0;
rightReps = 0;
leftFails = 0;
rightFails = 0;


%% MAIN LOOP - TRACK, EMULATE, AND DISPLAY %%

% Start color and depth devices
start([colorVid depthVid]);

% Define skeleton map based on mode
% Skeleton connection map
skeletonConnections = skeletonConnectionMapper(mode);

% Set figure handles for skeleton and image display
himg = figureHandles.axes1;
axes(figureHandles.axes1);

% Wait 5 seconds to allow streams to start
pause(5);

% Start timer
tic();

% Loop until ENDSESSION is pressed
while get(figureHandles.endsession,'Value') <= 0
    
    % Check whether or not to stop
    endSession = get(figureHandles.endsession,'Value');
    if endSession == 1
        break
    end
    
    % TRACK
    % Start logging data
    trigger([colorVid depthVid]);
    
    % Display data
    % COLOR
    if strcmpi(display,'Color')
        
        % Count the number of frames
        j = j + 1;
        
        % Retrieve acquired data - both
     	[colorFrameData,colorTimeData,colorMetaData] = getdata(colorVid);
        [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
        
        cla reset;
        imshow(colorFrameData(:,:,:,1),'Parent',figureHandles.axes1);
            
    % DEPTH
    elseif strcmpi(display,'Depth')
        
        % Retreive required data - skip color data
        [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
        
        cla reset;
        imshow(depthFrameData(:,:,:,1),'Parent',figureHandles.axes1);
    
    % SKELETON ONLY
    else
        
        % Retreive required data - skip color data
        [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
        
        set(figureHandles.axes1,'Color',[0 0 0]);
        set(figureHandles.axes1,'xlim',[0 600]);
        set(figureHandles.axes1,'ylim',[-450 0]);
        set(figureHandles.axes1,'XtickLabel',[],'YtickLabel',[]);
%         get(figureHandles.axes1,'xlim')
%         get(figureHandles.axes1,'ylim')
        cla;
        
    end
         
    hold on;
    
    % Plot skeleton (if there is a skeleton being tracked)
    if any(depthMetaData.IsSkeletonTracked)
        
        % Find the indices of the tracked skeletons
        trackedSkeletons = find(depthMetaData.IsSkeletonTracked);
        
        % Number of skeletons tracked
        nSkeletons = length(trackedSkeletons);
        
        % Get joint coordinates
        jointCoordinates = depthMetaData.JointWorldCoordinates(:,:,trackedSkeletons);
        
        % DETECT 
        % Detect if a repetition was successful
        % -- movement.left has both TYPE and ROM
        clear leftTrigger leftReset rightTrigger rightReset leftFail rightFail
        [leftTrigger,leftReset,leftFail] = gestureDetectorVRC(jointCoordinates,s.left.movement,figureHandles,'left');
        [rightTrigger,rightReset,rightFail] = gestureDetectorVRC(jointCoordinates,s.right.movement,figureHandles,'right');
        
        % REPETITIONS RESET
        % Require movements to return a certain % to the zero point
        [leftRep,leftResetMod] = repResetVRC(leftReset,leftTrigger,leftResetMod,'left');
        [rightRep,rightResetMod] = repResetVRC(rightReset,rightTrigger,rightResetMod,'right');
        
        % FAILURES RESET
        % Find previous zone for movement
        % -- Rep vs. failure vs. reset
        [leftFailRep,leftZones] = repFailVRC(leftTrigger,leftReset,leftFail,leftZones,'left');
        [rightFailRep,rightZones] = repFailVRC(rightTrigger,rightReset,rightFail,rightZones,'right');
        
        % REPETITIONS COUNT
        % Left (repetition successful means leftRep == 1)
        if leftRep == 1
            leftReps = leftReps + 1; 
        end
        
        % Right (repetition successful means rightRep == 1)
        if rightRep == 1  
            rightReps = rightReps + 1;
        end
        
        % FAILURES COUNT
        % Left (repetition failed means leftFailRep == 1)
        if leftFailRep == 1
            leftFails = leftFails + 1;
        end
        
        % Right (repetition failed means rightFailRep == 1)
        if rightFailRep == 1
            rightFails = rightFails + 1;
        end
        
        % EMULATOR
        % Emulate keyboard given a successful/nonsuccesful rep
        outputEmulatorVRC(leftRep,s.left.output);
        outputEmulatorVRC(rightRep,s.right.output);
        
        % DISPLAY %
        % Get joint indices
        % COLOR
        if strcmpi(display,'color')
            
            jointIndices = depthMetaData.JointImageIndices(:,:,trackedSkeletons);
            
            % Save data in overall structure
            
            % Clear data for efficiency
            clear colorFrameData colorTimeData colorMetaData
            clear depthFrameData depthTimeData depthMetaData
        
        % DEPTH
        elseif strcmpi(display,'depth')
            
            jointIndices = depthMetaData.JointDepthIndices(:,:,trackedSkeletons);
            
            % Save data in overall structure
            
            % Clear data for efficiency
            clear depthFrameData depthTimeData depthMetaData
        
        % SKELETON ONLY
        else
            
            jointIndices = depthMetaData.JointImageIndices(:,:,trackedSkeletons);
            jointIndices(:,2,:) = -jointIndices(:,2,:);
            
            % Save data in overall structure
            
            % Clear data for efficiency
            clear depthFrameData depthTimeData depthMetaData
            
        end

        % Plot image or depth indices over 
        % -- Loop through each segment
        [m,n] = size(skeletonConnections);
        
        % -- Only one skeleton tracked
        if nSkeletons > 0
            
            for k = 1:m
            
                j1 = skeletonConnections(k,1);
                j2 = skeletonConnections(k,2);
                plot([jointIndices(j1,1,1) jointIndices(j2,1,1)],...
                     [jointIndices(j1,2,1) jointIndices(j2,2,1)],...
                     'LineWidth',1.5,'Marker','+','Color','g','LineStyle','-');
                 
            end
             
        end
        
        % -- Two skeletons tracked
        if nSkeletons > 1
            
            for k = 1:m
            
                j1 = skeletonConnections(k,1);
                j2 = skeletonConnections(k,2);
                plot([jointIndices(j1,1,2) jointIndices(j2,1,2)],...
                     [jointIndices(j1,2,2) jointIndices(j2,2,2)],...
                     'LineWidth',1.5,'Marker','+','Color','g','LineStyle','-');
                 
            end
             
        end
        
        % REP COMPLETIONS
        % -- Left rep completions
        if isfield(figureHandles,'leftRepCounter')
            
            % Set the rep count
            set(figureHandles.leftRepCounter,'String',num2str(leftReps));
            
        end
        
        % -- Right rep completions
        if isfield(figureHandles,'rightRepCounter')
            
            % Set the rep count
            set(figureHandles.rightRepCounter,'String',num2str(rightReps));
            
        end
        
        % Set timer value
        % -- tic started stopwatch earlier, toc pings the stopwatch
        elapsedTime = toc();
        
        % -- Format time and set handle
        if (elapsedTime/60) < 1 
            
            set(figureHandles.sessionTimer,'String',num2str(elapsedTime));
            
        else
   
            mins = floor(elapsedTime/60);
            elapsedTime = elapsedTime - (mins*60);
            secs = elapsedTime;
            formatTime = [num2str(mins),':',num2str(secs)];
            set(figureHandles.sessionTimer,'String',formatTime);
            
        end
            
    end
    
    drawnow;
    
    % Set external framerate at 30 frames/second
%     pause(1/30);

end


%% EXIT PROCEDURES %%

% Stop the devices
stop([colorVid depthVid]);

% Turn off hold function on axes
hold off;

% Turn on Start button availability
set(figureHandles.runButton,'Enable','on');


%% SAVE DATA IF NECESSARY %%

% There is probably a more efficient way to pass this, but for now...

% If this is a field
% -- If not, its the demo version!
if isfield(figureHandles,'p')
    
    % Set data structure
    p = figureHandles.p;
    
    % Find session number
    sessionNumber = length(p.session);
    
    % Time
    elapsedTime = toc();
    p.session{sessionNumber}.timePlayed = elapsedTime;
    
    % LEFT %
    % Total completed reps
    p.session{sessionNumber}.left.reps = leftReps;
    
    % Total reps failed
    p.session{sessionNumber}.left.repFails = leftFails;
    
    % RIGHT %
    % Total completed reps
    p.session{sessionNumber}.right.reps = rightReps;
    
    % Total reps failed
    p.session{sessionNumber}.right.repFails = rightFails;
    
    % Reset the figureHandle
    figureHandles.p = p;
    guidata(figureHandles.figure1,figureHandles);
    
end


%% TRACK AND DISPLAY UNTIL FIGURE CLOSED %%


%% TRACK AND DISPLAY FOR SET NUMBER OF FRAMES %%

% % Start color and depth devices
% start([colorVid depthVid]);
% 
% Number of frames to collect at once
% maxFrames = 100;
% 
% % Loop through a set number of frames
% for k = 1:maxFrames
% 
%     % Start logging data
%     trigger([colorVid depthVid]);
% 
%     % Retrieve acquired data
%     [colorFrameData,colorTimeData,colorMetaData] = getdata(colorVid);
%     [depthFrameData,depthTimeData,depthMetaData] = getdata(depthVid);
%     
%     % Display color data
%     imshow(colorFrameData(:,:,:,1));
%     
% %     pause(1/30);
% 
% end







