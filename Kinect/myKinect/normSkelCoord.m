function skelCoord = normSkelCoord(skelCoord)

%
% Find the location of the spine joint and normalize the
% rest of coordinates to that location
%
if size(skelCoord,1) ~= 20
    display('Somethin aint right');
    display(size(skelCoord));
end;
spine = skelCoord(2,:);
try
    skelCoord = skelCoord - repmat(spine, [20,1]);
catch
    size(skelCoord)
    size(spine)
    skelCoord = skelCoord - repmat(spine, [20,1]);
end;