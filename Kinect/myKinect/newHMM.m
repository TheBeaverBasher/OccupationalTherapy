JoI = isolate('Right Arm');
imaqreset;

T = rand(2);                % Transition probabilities
T = spdiags(1./sum(T,2),0,2,2)*T;

E = rand(2,k) ;               % Emission probababilities
E = spdiags(1./sum(E,2),0,2,2)*E;

estT = zeros(size(T));
estE = zeros(size(E));

for i = 1:size(frames,2)
    if i == 1
        seq = idx(1:frames(i));
    else
        seq = idx(sum(frames(1:i-1))+1:sum(frames(1:i)));
    end;
    [estT(:,:,i),estE(:,:,i)] = hmmtrain(seq,T,E);
end;

emisProbs = mean(estE,3);
tranProbs = mean(estT,3);

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

trigger([colorVid depthVid]);
[frame1, ts1, metaData1] = getdata(colorVid);
[frame2, ts2, metaData2] = getdata(depthVid);

i = 1;

while i < max(frames);
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
        
        currentPos = normSkelCoord(metaData2.JointWorldCoordinates(:,...  
            :,metaData2.IsSkeletonTracked)).*JoI;
        currentPos = currentPos(find(currentPos));

        D = l2distance(C,currentPos);
        [~, I] = min(D);

        seq(i) = I;
    else
        seq(i) = 1;
        
    end;
    
    i = i + 1;
end;
j = i;
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
        currentPos = normSkelCoord(metaData2.JointWorldCoordinates(:,...  
            :,metaData2.IsSkeletonTracked)).*JoI;
        currentPos = currentPos(find(currentPos));

        D = l2distance(C,currentPos);
        [~, I] = min(D);
        seq(i) = I;    
    else
        seq(i) = seq(i-1);    
    end;
    
    if i - j > min(frames)
        SoI = seq(end-max(frames):end);
        PSTATES = hmmdecode(SoI, tranProbs, emisProbs);
        [~, ind] = max(PSTATES);
        if sum(abs(diff(ind))) == 2
            display('Found your gesture!');
            j = i;
        end;
    end;
    
    i = i+1;
end;

stop([colorVid depthVid]);