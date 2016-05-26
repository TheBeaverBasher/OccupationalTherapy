function press = pixConvCube(x1, y1, w1, h1, x2, y2, w2, h2, imw, imh, dist, fl, sensorH, sensorW, units)
%  input params : x, y, w, h, imw, imh, dist, fl, sensor, units
%       x, y    : pixel coordinates of object 1 and 2
%       w, h    : dimensions of bounding boxes
%       imw, imh: dimensions of your video feed
%       dist    : distance threshold needing to cross
%       fl      : focal length of your video feed
%       sensor  : dimensions of you sensor behind your camera (find a
%                   matlab function?)
%       units   : desired unit conversion for practitioner
%
%   output params: press
%       This is a boolean statement, assessing distance btween two cubes
%       are greater than the input distance 'dist'
switch units
    case 'cm'
        fl = fl/10;                 %   
        sensorH = sensorH/10;       %   Convert the units, assuming sensor is 
        sensorW = sensorW/10;       %   given in mm. 'real' is the average real 
        real = (2.54+2.54*2^.5)/2;  %   distance the camera will see. 'imageS' is 
        imageS1 = (w1+h1)/2;        %   the distance in pixels that the camera 
        imageS2 = (w2+h2)/2;        %   sees
                                    %
        midX = round(imw/2);
        midY = round(imh/2);
        
        x1 = (x1 - midX)*real/imageS1;      %
        y1 = (y1 - midY)*real/imageS1;      % Convert our x and y pixel 
                                            % coordinates to actual 
        x2 = (x2 - midX)*real/imageS2;      % euclidean space metrics
        y2 = (y2 - midY)*real/imageS2;      %
        
        z1 = ((fl*real*imh)/(imageS1*sensorH)+(fl*real*imw)/(imageS1*sensorW))/2;   %
        z2 = ((fl*real*imh)/(imageS2*sensorH)+(fl*real*imw)/(imageS2*sensorW))/2;   % calculate depth (average)
                                                                                    %
        press = eucDist(x1,y1,z1,x2,y2,z2) > dist; % output
        
    case 'in'
        fl = fl/25.4;               %   
        sensorH = sensorH/25.4;     %   Convert the units, assuming sensor is 
        sensorW = sensorW/25.4;     %   given in mm. 'real' is the average real 
        real = (1+2^.5)/2;          %   distance the camera will see. 'imageS' is 
        imageS1 = (w1+h1)/2;        %   the distance in pixels that the camera 
        imageS2 = (w2+h2)/2;        %   sees
                                    %
        
        midX = round(imw/2);
        midY = round(imh/2);
        
        x1 = (x1 - midX)*real/imageS1;      %
        y1 = (y1 - midY)*real/imageS1;      % Convert our x and y pixel 
                                            % coordinates to actual 
        x2 = (x2 - midX)*real/imageS2;      % euclidean space metrics
        y2 = (y2 - midY)*real/imageS2;      %
        
        z1 = ((fl*real*imh)/(imageS1*sensorH)+(fl*real*imw)/(imageS1*sensorW))/2;   %
        z2 = ((fl*real*imh)/(imageS2*sensorH)+(fl*real*imw)/(imageS2*sensorW))/2;   % calculate depth (average)
                                                                                    %
        press = eucDist(x1,y1,z1,x2,y2,z2) > dist; % output
        
    otherwise      
end

function dist = eucDist(x1,y1,z1,x2,y2,z2)
    dist = ((x1-x2)^2+(y1-y2)^2+(z1-z2)^2)^.5;
