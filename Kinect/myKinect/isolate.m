function jointsOfInterest = isolate(bodyPart)
%
% Call this function when you want to isolate body part(s) for a motion 
%
switch bodyPart
    case 'Right Arm'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest(9:12,:) = 1;
    case 'Left Arm'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest(5:8,:) = 1;
    case 'Hands'    
        jointsOfInterest = zeros(20,3);
        jointsOfInterest([8,12],:) = 1;
    case 'Both Arms'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest(5:12,:) = 1;
    case 'Right Leg'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest([1,17:20],:) = 1;
    case 'Left Leg'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest([1,13:16],:) = 1;
    case 'Both Legs'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest([1,13:20],:) = 1;
    case 'Head and Neck'
        jointsOfInterest = zeros(20,3);
        jointsOfInterest([3:5,9],:) = 1;
    case 'Whole Body'
        jointsOfInterest = ones(20,3);
    otherwise
        jointsOfInterest = zeros(20,3);
end