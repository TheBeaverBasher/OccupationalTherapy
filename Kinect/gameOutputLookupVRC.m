% Lookup table for games that have been vetted for VRConnect.
% -- Input game name
% -- Output the keyboard/mouse button type required (value in list)
% -- This function can be updated with new games when required

% By: Matt Foreman

% -- Last Updated 01/04/16 -- %

%% CHANGELOG %%

% Created 01/04/16 -- MHF


function [outputVal,outputString] = gameOutputLookupVRC(gameType)

% Input
% -- gameType == string for game name

% Output
% -- outputVal == value for required output from output array
% -- outputVal == [leftOutputVal,rightOutputVal]
% -- outputString == string corresponding to the movement type
% -- outputString == {leftOutputString; rightOutputString}

% Current output list (01/04/16)...

%     outputList = {'Choose output...'; 
%                   'Space'; ...
%                   'Left click'; ...
%                   'x'; ...
%                   'y'; ...
%                   'z'; ...
%                   'Up arrow'; ...
%                   'Down arrow'; ...
%                   'Left arrow'; ...
%                   'Right arrow'; ...
%                   };


%% LOOKUP TABLE %%

% Sets keyboard output possibilities based on game selection

% (1) Basketball_Game.swf
if strcmpi(gameType,'Basketball_Game.swf')
    
    % Left click
    leftOutputVal = 3;
    rightOutputVal = 3;
    leftOutputString = 'Left click';
    rightOutputString = 'Left click';

% (2) Basketball_Shot.swf
elseif strcmpi(gameType,'Basketball_Shot.swf')
    
    % Left click
    leftOutputVal = 3;
    rightOutputVal = 3;
    leftOutputString = 'Left click';
    rightOutputString = 'Left click';
    
% (3) Canabalt.swf
elseif strcmpi(gameType,'Canabalt.swf')
    
    % X button
    leftOutputVal = 4;
    rightOutputVal = 4;
    leftOutputString = 'x';
    rightOutputString = 'x';
   
% (4) FlabbyPhysics.swf
elseif strcmpi(gameType,'FlabbyPhysics.swf')
    
    % Space bar
    leftOutputVal = 2;
    rightOutputVal = 2;
    leftOutputString = 'Space';
    rightOutputString = 'Space';
    
% (5) HorseGo.swf
elseif strcmpi(gameType,'HorseGo.swf')
    
    % Left click
    leftOutputVal = 3;
    rightOutputVal = 3;
    leftOutputString = 'Left click';
    rightOutputString = 'Left click';
 
% (6) Pinball_Mania.swf
elseif strcmpi(gameType,'Pinball_Mania.swf')
    
    % Left and Right arrow keys
    % -- Add spacebar to pinball games?
    leftOutputVal = 9;
    rightOutputVal = 10;
    leftOutputString = 'Left arrow';
    rightOutputString = 'Right arrow';
    
% (7) Pinball_MrBump.swf
elseif strcmpi(gameType,'Pinall_MrBump.swf')
    
    % Left and Right arrow keys
    % -- Add spacebar to pinball games?
    leftOutputVal = 9;
    rightOutputVal = 10;
    leftOutputString = 'Left arrow';
    rightOutputString = 'Right arrow';
 
% (8) Pinball_ShortCircuit.swf
elseif strcmpi(gameType,'Pinball_ShortCircuit.swf')
    
    % Left and Right arrow keys
    % -- Add spacebar to pinball games?
    leftOutputVal = 9;
    rightOutputVal = 10;
    leftOutputString = 'Left arrow';
    rightOutputString = 'Right arrow';
 
% (9) Pinball_Soccer.swf
elseif strcmpi(gameType,'Pinball_Soccer.swf')
    
    % Left and Right arrow keys
    % -- Add spacebar to pinball games?
    leftOutputVal = 9;
    rightOutputVal = 10;
    leftOutputString = 'Left arrow';
    rightOutputString = 'Right arrow';
   
% (10) Pinball_WallE.swf
elseif strcmpi(gameType,'Pinball_WallE.swf')
    
    % Left and Right arrow keys
    % -- Add spacebar to pinball games?
    leftOutputVal = 9;
    rightOutputVal = 10;
    leftOutputString = 'Left arrow';
    rightOutputString = 'Right arrow';
    
% (11) RobotUnicornAttack.swf
elseif strcmpi(gameType,'RobotUnicornAttack.swf')
    
    % X and Z buttons
    leftOutputVal = 4;
    rightOutputVal = 6;
    leftOutputString = 'x';
    rightOutputString = 'z';
    
% (12) SoccerPenaltyShootout.swf
elseif strcmpi(gameType,'SoccerPenaltyShootout.swf')
    
    % Left click
    leftOutputVal = 3;
    rightOutputVal = 3;
    leftOutputString = 'Left click';
    rightOutputString = 'Left click';
    
% (13) TomAndJerry_RefrigerRaiders.swf
elseif strcmpi(gameType,'TomAndJerry_RefrigerRaiders.swf')
    
    % Space bar
    leftOutputVal = 2;
    rightOutputVal = 2;
    leftOutputString = 'Space';
    rightOutputString = 'Space';
    
% (14) TomAndJerry_RunJerryRun.swf
elseif strcmpi(gameType,'TomAndJerry_RunJerryRun.swf')
    
    % Space bar
    leftOutputVal = 2;
    rightOutputVal = 2;
    leftOutputString = 'Space';
    rightOutputString = 'Space';
    
% (15) TomAndJerry_WhatsTheCatch.swf
elseif strcmpi(GameType1, 'Run_Jerry_Run.lnk')
    
    % Left click
    leftOutputVal = 3;
    rightOutputVal = 3;
    leftOutputString = 'Left click';
    rightOutputString = 'Left click';
    
else
    
    % "Choose game..."
    % Unknown game!
    leftOutputVal = 1;
    rightOutputVal = 1;
    leftOutputString = 'Choose output...';
    rightOutputString = 'Choose output...';

end

outputVal = {leftOutputVal; rightOutputVal};
outputString = {leftOutputString; rightOutputString};


