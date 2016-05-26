function gesture = findGesture(bodyPart)
%
% This function will look for a gesture being acted out. The user will
% pause their motion for 3 seconds to initiate the recording of the
% gesture. The user will perform the gesture, then pause for another 3
% seconds to indicate that their motion is complete. 
%
try
    colorVid = videoinput('kinect',1);
    depthVid = videoinput('kinect',2);
catch
    warning('Device is previewing or acquiring. Restarting the camera.');
    imaqreset;
    colorVid = videoinput('kinect',1);
    depthVid = videoinput('kinect',2);
end;

triggerconfig([colorVid depthVid],'manual');

colorVid.triggerRepeat = inf;       %
depthVid.triggerRepeat = inf;       % Initialize triggers and frame rates
                                    % for both color and depth videos. 
colorVid.FramesPerTrigger = 1;      % 
depthVid.FramesPerTrigger = 1; 

set(getselectedsource(depthVid), 'TrackingMode','Skeleton');

viewer = vision.DeployableVideoPlayer();

start([colorVid depthVid]);

gestureExamples = cell(1,20); % 20 was chosen arbitrarily, test later for optimal number

for example = 1:20
    gestureNotFound = true;

    while gestureNotFound                               %
        trigger([colorVid depthVid]);                   % Outer loop, framework
        [frame1, ts1, metaData1] = getdata(colorVid);   % for other inner loops
        [frame2, ts2, metaData2] = getdata(depthVid);   %

        JoI = isolate(bodyPart);        % Joints of Interest

        i = 1;
        foundSkel = true;   %
        time1 = true;       % Switches and counters for 
        time2 = true;       % display messages and what not
        time3 = true;       %
        tryAgain = false;

        imshow(frame1);
        display('Looking for a skeleton, please hold still');
        startTime = metaData2.AbsTime(end);         %
        time = metaData2.AbsTime(end);              % Initialize time  
        timeDif = time - startTime;                 % contraint letting user 
        if timeDif < 0                              % have time to get to a 
            timeDif = timeDif + 60;                 % starting position
        end;                                        %
        while timeDif < 3
            trigger([colorVid depthVid]);                   %
            [frame1, ts1, metaData1] = getdata(colorVid);   % Common framework
            [frame2, ts2, metaData2] = getdata(depthVid);   % for framerate
            time = metaData2.AbsTime(end);                  %
            timeDif = time - startTime;
            if timeDif < 0
                timeDif = timeDif + 60;
            end;
            imshow(frame1);
        end;
        
        startPos = normSkelCoord(metaData2.JointWorldCoordinates(:,...  %
                    :,metaData2.IsSkeletonTracked)).*JoI;               % Start position before going into loop, 
                                                                        % just in case next frame doesn't capture 
                                                                        %                                                                         

        while sum(metaData2.IsSkeletonTracked) > 0
            trigger([colorVid depthVid]);                   %
            [frame1, ts1, metaData1] = getdata(colorVid);   % Similar framework 
            [frame2, ts2, metaData2] = getdata(depthVid);   % for getting data,
                                                            % used again
            if foundSkel                                    % throughout
                startTime = metaData2.AbsTime(end);         % code
                currentPos = zeros(20,3);                   %                         
                display('Skeleton found! Hold still to initialize a gesture recognition!');
                foundSkel = false;
            end;
            
            if sum(metaData2.IsSkeletonTracked) > 0
                curentPos(:,:,i) = normSkelCoord(metaData2.JointWorldCoordinates(:,...
                    :,metaData2.IsSkeletonTracked)).*JoI;
            else
                try
                    currentPos(:,:,i) = currentPos(:,:,i-1);
                catch
                    currentPos(:,:,i) = startPos;
                end;
            end;

%           currentPos(:,:,i) = normSkelCoord(metaData2.JointWorldCoordinates(:,...
%               :,metaData2.IsSkeletonTracked)).*JoI; %
                                                      % keep track of position
            imshow(frame1);                           %
            skeletonJoints = metaData2.JointDepthIndices(:,...
                :,metaData2.IsSkeletonTracked);
            hold on; 
            try                                                     %
                plot(skeletonJoints(:,1),skeletonJoints(:,2), '*'); % Drawing
            catch                                                   %
            end;                                                    
            hold off;                                              
                                            %
            time = metaData2.AbsTime(end);  % find the current time and 
            timeDif = time - startTime;     % calculate the difference
            if timeDif < 0                  %
                timeDif = timeDif + 60;
            end;

            if timeDif > 0 && time1
                display('3!');          %
                time1 = false;          % Count down for the user while holding 
            end;                        % still to prepare for the gesture 
            if timeDif > 1 && time2     % training. This will be shown right 
                display('2!');          % before every time we look for a 
                time2 = false;          % gesture. User must hold joints of 
            end;                        % interest still during this time.
            if timeDif > 2 && time3     %
                display('1!');
                time3 = false;
            end;

            if timeDif > 3
                display('GO!');
                myVar = var(currentPos,0,3); % calculate the variation,
                if all(myVar < .0001)        % look for small value  
                    gestureNotFound = false;    %
                    j = 1;                      % Initialize the search for
                    gesturePos = zeros(20,3);   % a gesture.
                    gestureInProg = true;       %
                    while gestureInProg % Same framework as before
                        trigger([colorVid depthVid]);
                        [frame1, ts1, metaData1] = getdata(colorVid);
                        [frame2, ts2, metaData2] = getdata(depthVid);
                        if sum(metaData2.IsSkeletonTracked) > 0
                            gesturePos(:,:,j) = normSkelCoord(metaData2.JointWorldCoordinates(:,...
                                :,metaData2.IsSkeletonTracked)).*JoI;
                        else
                            try
                                gesturePos(:,:,j) = gesturePos(:,:,j-1);
                            catch
                                gesturePos(:,:,j) = currentPos(:,:,i);
                            end;
                        end;
                        imshow(frame1);
                        skeletonJoints = metaData2.JointDepthIndices(:,...
                            :,metaData2.IsSkeletonTracked);
                        hold on;
                        try
                            plot(skeletonJoints(:,1),skeletonJoints(:,2), '*');
                        catch
                        end;
                        hold off;
                        if j > i    % the gesture is longer thn 3 sec 
                            last3sec = gesturePos(:,:,end-i:end);
                            newVar = var(last3sec,0,3); % Is that variation low?
                            if all(newVar < .0001)      % if so, gesture complete
                                break;
                            end; % otherwise the gesture is still in progress
                        end;
                        j = j + 1;
                    end;
                    break;
                else
                    tryAgain = true; % Looks like there was movement from the  
                end;                 % user during the 3 seconds, start over
            end;

            if tryAgain
                break
            end;

            i = i+1;
        end;
        
%         ges = gesturePos(:,:,1:end-i-1);
%         
%         if any(sum(var(ges,0,3) > .01) == 0)
%             gestureNotFound = true;
%         end;

        if gestureNotFound
            display('Whoops! I did not quite get that, please hold still and try again!');
        end;

    end;
    
%     if example == 1
%         gestureExamples = zeros([size(gesturePos), 10]);
%         gestureExamples = gesturePos;
%     else
%         if size(gesturePos,3) > size(gestureExamples,3)
%             dummyVar = gestureExamples;
%             gestureExamples = zeros([size(gesturePos), 10]);
%             gestureExamples(:, :, 1:size(dummyVar,3), :) = dummyVar;
%             gestureExamples(:,:,:,example) = gesturePos;
%         else
%             gestureExamples(:,:,1:size(gesturePos,3),example) = gesturePos;
%         end;
%     end;
    
    gestureExamples{example} = gesturePos(:,:,1:end-i-1);

    display('Great! Done with an example!');
end;
stop([colorVid depthVid]);

display(gestureExamples);

save('testvar.mat', 'gestureExamples');