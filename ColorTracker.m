function varargout = ColorTracker(varargin)
% COLORTRACKER MATLAB code for ColorTracker.fig
%      COLORTRACKER, by itself, creates a new COLORTRACKER or raises the existing
%      singleton*.
%
%      H = COLORTRACKER returns the handle to a new COLORTRACKER or the handle to
%      the existing singleton*.
%
%      COLORTRACKER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLORTRACKER.M with the given input arguments.
%
%      COLORTRACKER('Property','Value',...) creates a new COLORTRACKER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ColorTracker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ColorTracker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ColorTracker

% Last Modified by GUIDE v2.5 18-Apr-2016 11:11:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ColorTracker_OpeningFcn, ...
                   'gui_OutputFcn',  @ColorTracker_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ColorTracker is made visible.
function ColorTracker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ColorTracker (see VARARGIN)

% Choose default command line output for ColorTracker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ColorTracker wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Populate Color 1 menu (colorMenu1)
colorList = {'None';
             'Red'; 
             'Green'; 
             'Blue'};
         
set(handles.colorMenu1,'String',colorList);

% Populate Color 2 menu (colorMenu2)
set(handles.colorMenu2,'String',colorList);

% Populate Relation menu (relationMenu)
relationList = {'Lateral distance'; 'Vertical distance'};
set(handles.relationMenu,'String',relationList);

% Set inital value for Distance number (distanceEdit)
defaultDistance = 0;
set(handles.distanceEdit,'String',num2str(defaultDistance));

% Populate Output menu (outputMenu)
outputList =  {'Space'; ...
               'Left click'; ...
               'x'; ...
               'y'; ...
               'z'; ...
               'Up arrow'; ...
               'Down arrow'; ...
               'Left arrow'; ...
               'Right arrow'; ...
               };
           
set(handles.outputMenu,'String',outputList);

% Set initial value for stop button (stopButton)
set(handles.stopButton,'UserData',0);


% --- Outputs from this function are returned to the command line.
function varargout = ColorTracker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in colorMenu1.
function colorMenu1_Callback(hObject, eventdata, handles)
% hObject    handle to colorMenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns colorMenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from colorMenu1


% --- Executes during object creation, after setting all properties.
function colorMenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorMenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in colorMenu2.
function colorMenu2_Callback(hObject, eventdata, handles)
% hObject    handle to colorMenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns colorMenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from colorMenu2


% --- Executes during object creation, after setting all properties.
function colorMenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorMenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in relationMenu.
function relationMenu_Callback(hObject, eventdata, handles)
% hObject    handle to relationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns relationMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from relationMenu


% --- Executes during object creation, after setting all properties.
function relationMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to relationMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distanceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to distanceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of distanceEdit as text
%        str2double(get(hObject,'String')) returns contents of distanceEdit as a double


% --- Executes during object creation, after setting all properties.
function distanceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to distanceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in startButton.
function startButton_Callback(hObject, eventdata, handles)
% hObject    handle to startButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set initial value for stopButton
set(handles.stopButton,'UserData',0);

% Get info for the designated camera
% -- First have to download the support package, link below
% -- http://www.mathworks.com/help/imaq/image-acquisition-support-packages-for-hardware-adaptors.html
a = imaqhwinfo;
[camera_name, camera_id, format] = getCameraInfo(a);

% Capture the video frames using the videoinput function
% You have to replace the resolution & your installed adaptor name.
vid = videoinput(camera_name, camera_id, format);

% Set the properties of the video object
set(vid, 'FramesPerTrigger', Inf);
set(vid, 'ReturnedColorspace', 'rgb')
vid.FrameGrabInterval = 5;

% Get color choice
% -- Color 1 and Color 2
% -- Use Color 1 for now
colorList = get(handles.colorMenu1,'String');
colorVal1 = get(handles.colorMenu1,'Value');
colorVal2 = get(handles.colorMenu2,'Value');
color1 = colorList{colorVal1};
color2 = colorList{colorVal2};

% Set empty color vectors
colorX1 = 0;
colorY1 = 0;
colorX2 = 0;
colorY2 = 0;

% Get relation
relationList = get(handles.relationMenu,'String');
relationVal = get(handles.relationMenu,'Value');
relation = relationList{relationVal};

% Get distance
relDist = str2double(get(handles.distanceEdit,'String'));

% Get chosen output
outputList = get(handles.outputMenu,'String');
outputVal = get(handles.outputMenu,'Value');
outputType = outputList{outputVal};

% Set correct inputs for inputemu function
if strcmpi(outputType,'Space')
    otpt = ' ';
elseif strcmpi(outputType,'Up arrow');
    otpt = '\UP';
elseif strcmpi(outputType,'Down arrow');
    otpt = '\DOWN';
elseif strcmpi(outputType,'Left arrow');
    otpt = '\LEFT';
elseif strcmpi(outputType,'Right arrow');
    otpt = '\RIGHT';
elseif strcmpi(outputType,'x');
    otpt = 'x';
elseif strcmpi(outputType,'y');
    otpt = 'y';
elseif strcmpi(outputType,'z');
    otpt = 'z';
end

% Choose the color to be tracked for Color 1
if strcmpi(color1,'Red')
    colorRef1 = 1;
    colorString1 = 'r';
elseif strcmpi(color1,'Green')  
    colorRef1 = 2;
    colorString1 = 'g';
elseif strcmpi(color1,'Blue')   
    colorRef1 = 3;   
    colorString1 = 'b';
else  
    % Throw an error if no Color 1 is chosen
    % -- Choosing a color 1 is necessary
    colorRef1 = [];
    error('No color chosen for Color 1!');   
end

% Choose the color to be tracked for Color 2
if strcmpi(color2,'Red')
    colorRef2 = 1;
    colorString2 = 'r';
elseif strcmpi(color2,'Green')
    colorRef2 = 2;
    colorString2 = 'g';
elseif strcmpi(color2,'Blue')
    colorRef2 = 3;
    colorString2 = 'b';
else
    % Set the second color as an empty matrix
    colorRef2 = [];
end

% Set initial key status (keyStatus)
% -- This is required later to let key up/down
keyStatus = 'up';

% Start the video aquisition here
start(vid)

% Set current axes
axes(handles.axes1);

% Loop through a number of frames
while get(handles.stopButton,'Value') <= 0
    
    % COLOR 1
    if ~isempty(colorRef1)
        
        % Get the snapshot of the current frame
        data = getsnapshot(vid);
    
        % Track colored objects in real time
        % -- Subtract color component from the grayscale image
        % -- colorRef1 = 1 (red), 2 (green), or 3 (blue)
        diff_im = imsubtract(data(:,:,colorRef1),rgb2gray(data));
    
        % Use a median filter to filter out noise
        diff_im = medfilt2(diff_im,[3,3]);
    
        % Convert the resulting grayscale image into a binary image
        diff_im = im2bw(diff_im,0.18);
    
        % Remove all those pixels less than 300px
        diff_im = bwareaopen(diff_im,300);
    
        % Label all the connected components in the image
        bw = bwlabel(diff_im,8);
    
        % Blob analysis
        stats = regionprops(bw,'BoundingBox','Centroid');
        stats1 = stats;
        
    end
    
    % COLOR 2
    if ~isempty(colorRef2)
    
        % Track colored objects in real time
        % -- Subtract color component from the grayscale image
        % -- colorRef1 = 1 (red), 2 (green), or 3 (blue)
        diff_im = imsubtract(data(:,:,colorRef2),rgb2gray(data));
    
        % Use a median filter to filter out noise
        diff_im = medfilt2(diff_im,[3,3]);
    
        % Convert the resulting grayscale image into a binary image
        diff_im = im2bw(diff_im,0.18);
    
        % Remove all those pixels less than 300px
        diff_im = bwareaopen(diff_im,300);
    
        % Label all the connected components in the image
        bw = bwlabel(diff_im,8);
    
        % Blob analysis
        stats = regionprops(bw,'BoundingBox','Centroid');
        stats2 = stats;
        
    end
    
    % Plot snapshot of current image
    cla reset
    imshow(data,'Parent',handles.axes1)
    hold on;
    
    % Plot COLOR1 bounding box and centroid
    % This is a loop to bound the COLOR1 objects in a rectangular box
    bc = [];
    bc1 = [];
    if ~isempty(colorRef1)
        
        for object = 1:length(stats1)
        
            bb1 = stats1(object).BoundingBox;
            display(stats1(object).BoundingBox);
            bc1 = stats1(object).Centroid;
            rectangle('Position',bb1,'EdgeColor',colorString1,'LineWidth',2)
            plot(bc1(1),bc1(2), '-m+')
            a1 = text(bc1(1)+15,bc1(2), strcat('X: ',num2str(round(bc1(1))), '    Y: ',num2str(round(bc1(2)))));
            set(a1, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    
        end
        
    end
    
    % Plot COLOR2 bounding box and centroid
    % This is a loop to bound the COLOR1 objects in a rectangular box
    bc = [];
    bc2 = [];
    if ~isempty(colorRef2)
        
        for object = 1:length(stats2)
        
            bb2 = stats2(object).BoundingBox;
            bc2 = stats2(object).Centroid;
            rectangle('Position',bb2,'EdgeColor',colorString2,'LineWidth',2)
            plot(bc2(1),bc2(2), '-m+')
            a2 = text(bc2(1)+15,bc2(2), strcat('X: ', num2str(round(bc2(1))), '    Y: ',num2str(round(bc2(2)))));
            set(a2, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
    
        end
        
    end
    
    hold off
    
    % Work with Centroid data
    % -- Color 1 X and Y (always)
    % -- Color 2 X and Y (if chosen)
    % -- Emulate keyboard
    if ~isempty(bc1)
        
        % Set X and Y edit boxes for COLOR1
        set(handles.colorX1,'String',num2str(bc1(1)));
        set(handles.colorY1,'String',num2str(bc1(2)));
        
        % Save X and Y frame data for COLOR1
        colorX1 = [colorX1 bc1(1)];
        colorY1 = [colorY1 bc1(2)];
        
        % Set values for COLOR2 (if chosen)
        if ~isempty(bc2)
            
            % Set X and Y edit boxes for COLOR1
            set(handles.colorX2,'String',num2str(bc2(1)));
            set(handles.colorY2,'String',num2str(bc2(2)));
            
            % Save X and Y frame data for COLOR2
            colorX2 = [colorX2 bc2(1)];
            colorY2 = [colorY2 bc2(2)];
            
        end
        
        % Emulate keyboard
        pauseTime = 0;
        
        % If "Lateral distance"
        if strcmpi(relation,'Lateral distance')
            
            % If Color2 is empty
            % -- Use relative distance for Color1 relative to prev frame
            if isempty(bc2)
            
                % If moves more than "Distance" relative to previous frame
                if (colorX1(end) > (colorX1(end-1)+relDist)) || (colorX1(end) < (colorX1(end-1)-relDist))
    
                    % Left click has a different syntax than the keys
                    if strcmpi(outputType,'Left click')
        
                        % Press/hold key down
                        % -- If they key is up, press it down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'left_down',[]});
                            pause(pauseTime);
                            inputemu({'left_up',[]});
                            keyStatus = 'down';
                            
                        end
    
                    % All key presses have the same syntax
                    else
                        
                        if strcmpi(keyStatus,'up')
           
                            % Press/hold key down
                            inputemu({'key_down',otpt})
                            pause(pauseTime)
                            inputemu({'key_up',otpt});
                            keyStatus = 'down';
    
                        end
                       
                    end
                        
                else
                        
                    % Set the keyStatus to 'up'
                    keyStatus = 'up';
                   
                end
                
            % If Color2 is not empty
            % -- Use distance between Color1 and Color2 centroids
            elseif ~isempty(bc2)
                
                % If moves more than "Distance" relative to previous frame
                % -- ColorX1-ColorX2 > relDist
                if (abs((colorX1(end)-colorX2(end))) > relDist)
    
                    % Left click has a different syntax than the keys
                    if strcmpi(outputType,'Left click')
        
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'left_down',[]});
                            pause(pauseTime);
                            inputemu({'left_up',[]});
                            keyStatus = 'down';
                            
                        end
    
                    % All key presses have the same syntax
                    else
                                                    
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')

                            inputemu({'key_down',otpt})
                            pause(pauseTime)
                            inputemu({'key_up',otpt});
                            keyStatus = 'down';
                            
                        end
    
                    end
        
                else
                    
                    % Set keyStatus to 'up'
                    keyStatus = 'up';
                    
                end
                
            end
        
        % If "Vertical distance"
        elseif strcmpi(relation,'Vertical distance')
            
            % If Color2 is empty
            % -- Use distance of Color1 relative to previous frame
            if isempty(bc2)
            
            	% If moves more than "Distance" relative to previous frame
                if (colorY1(end) > (colorY1(end-1)+relDist)) || (colorY1(end) < (colorY1(end-1)-relDist))
    
                    % Left click has a different syntax than the keys
                    if strcmpi(outputType,'Left click')
            
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'left_down',[]});
                            pause(pauseTime);
                            inputemu({'left_up',[]});
                            keyStatus = 'down';
                            
                        end
    
                    % All key presses have the same syntax
                    else
           
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'key_down',otpt})
                            pause(pauseTime)
                            inputemu({'key_up',otpt});
                            keyStatus = 'down';
                        
                        end
                        
                    end
                    
                else
                    
                    % Set keyStatus to 'up'
                    keyStatus = 'up';
    
                end
                
            % If Color2 is not empty
            % -- Use distance between Color1 and Color2 centroids   
            elseif ~isempty(bc2)
                
                % If moves more than "Distance" relative to previous frame
                % -- ColorY1-ColorY2 > relDist
                if (abs((colorY1(end)-colorY2(end))) > relDist)
    
                    % Left click has a different syntax than the keys
                    if strcmpi(outputType,'Left click')
        
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'left_down',[]});
                            pause(pauseTime);
                            inputemu({'left_up',[]});
                            keyStatus = 'down';
                            
                        end
    
                    % All key presses have the same syntax
                    else
           
                        % Press/hold key down
                        if strcmpi(keyStatus,'up')
                            
                            inputemu({'key_down',otpt})
                            pause(pauseTime)
                            inputemu({'key_up',otpt});
                            keyStatus = 'down';
                        
                        end
    
                    end
                    
                else
                    
                    % Set keyStatus to 'up'
                    keyStatus = 'up';
        
                end
                
            end
            
        end
        
    end
    
    % Check stop button
    stopVal = get(handles.stopButton,'UserData');
    if stopVal == 1
        
        break
        
    end

    % Update axes
    drawnow;
    
    % Update GUI
    guidata(hObject,handles); 
    
end

% Stop the video aquisition.
stop(vid);

% Flush all the image data stored in the memory buffer.
flushdata(vid);


% --- Executes on button press in stopButton.
function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Set stop status == 1
set(handles.stopButton,'UserData',1);

drawnow;
guidata(hObject,handles);


% --- Executes on selection change in outputMenu.
function outputMenu_Callback(hObject, eventdata, handles)
% hObject    handle to outputMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns outputMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from outputMenu


% --- Executes during object creation, after setting all properties.
function outputMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorX1_Callback(hObject, eventdata, handles)
% hObject    handle to colorX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorX1 as text
%        str2double(get(hObject,'String')) returns contents of colorX1 as a double


% --- Executes during object creation, after setting all properties.
function colorX1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorX1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorX2_Callback(hObject, eventdata, handles)
% hObject    handle to colorX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorX2 as text
%        str2double(get(hObject,'String')) returns contents of colorX2 as a double


% --- Executes during object creation, after setting all properties.
function colorX2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorX2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorY1_Callback(hObject, eventdata, handles)
% hObject    handle to colorY1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorY1 as text
%        str2double(get(hObject,'String')) returns contents of colorY1 as a double


% --- Executes during object creation, after setting all properties.
function colorY1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorY1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function colorY2_Callback(hObject, eventdata, handles)
% hObject    handle to colorY2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of colorY2 as text
%        str2double(get(hObject,'String')) returns contents of colorY2 as a double


% --- Executes during object creation, after setting all properties.
function colorY2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colorY2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
