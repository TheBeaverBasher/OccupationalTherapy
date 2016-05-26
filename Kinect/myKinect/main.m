% For use with Kinect for Xbox 360
% Download and install: 
%       1.) KinectSDK-v1.8-Setup
%       2.) KinectDeveloperToolkit-v1.8.0-Setup
%       3.) MatLab R2015a
%       
% 
% 

%% SET COLOR AND DEPTH OBJECTS %%

colorVid = videoinput('kinect',1);
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

%% DEV. PURPOSES  (comment out later) %%

preview(colorVid)
preview(depthVid)

%% START VIDEO %%
start(colorVid);
start(DepthVid);



