% Define the GitHub repository URL
repoURL = 'https://github.com/Energy-Optimization-Lab/DC-Microgrid';

% Prompt the user to select the project folder
projectFolder = uigetdir('', 'Select the project folder');

% If the user cancels the folder selection, exit the script
if projectFolder == 0
    disp('Folder selection canceled. Script terminated.');
    return;
end

% Download the ZIP file using PowerShell
zipFile = fullfile(projectFolder, 'repository.zip');
system(sprintf('powershell -command "Invoke-WebRequest -Uri %s -OutFile %s"', [repoURL, '/archive/main.zip'], zipFile));

% Extract the ZIP file to a temporary folder
tempFolder = fullfile(projectFolder, 'temp');
if ~exist(tempFolder, 'dir')
    mkdir(tempFolder);
end
unzip(zipFile, tempFolder);

% Get the name of the extracted folder (usually 'repository-main')
extractedFolders = dir(fullfile(tempFolder, 'repository-*'));
extractedFolder = fullfile(tempFolder, extractedFolders(1).name);

% Update the MATLAB project with the new files
% Assuming you have a project object 'proj'
addPath(proj, extractedFolder);

% Optionally, delete the temporary folder and ZIP file
rmdir(tempFolder, 's');
delete(zipFile);

disp('Project updated.');
