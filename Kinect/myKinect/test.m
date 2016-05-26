clc; clear all; close all;
imaqreset;

colorVid = videoinput('kinect',1);
depthVid = videoinput('kinect',2);

triggerconfig([colorVid depthVid],'manual');

colorVid.triggerRepeat = inf;
depthVid.triggerRepeat = inf;

colorVid.FramesPerTrigger = 1;
depthVid.FramesPerTrigger = 1;

set(getselectedsource(depthVid), 'TrackingMode','Skeleton');

viewer = vision.DeployableVideoPlayer();

start([colorVid depthVid]);

himg = figure;

while ishandle(himg)
    trigger([colorVid depthVid]);
    [frame1, ts1, metaData1] = getdata(colorVid);
    [frame2, ts2, metaData2] = getdata(depthVid);
    
    imshow(frame1);
    
    if sum(metaData2.IsSkeletonTracked) > 0
        skeletonJoints = metaData2.JointDepthIndices(:,:,metaData2.IsSkeletonTracked);
        worldCoor = metaData2.JointWorldCoordinates(:,:,metaData2.IsSkeletonTracked);
        hold on;
        plot(skeletonJoints(:,1),skeletonJoints(:,2), '*');
        hold off;
    end;
    
    
end;

stop([colorVid depthVid]);

