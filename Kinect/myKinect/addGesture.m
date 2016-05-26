function addGesture(gesture)

global gestureList;

if ~isempty(gestureList)
    s = size(gestureList,2);
    gestureList{s+1} = gesture;    
else
    gestureList{1} = gesture;
end