% Define the GitHub repository URL
repoURL = 'https://github.com/Energy-Optimization-Lab/DC-Microgrid';

% Prompt the user to select a folder for the project
projectFolder = uigetdir('', 'Select a folder for the project');

% If the user cancels the folder selection, exit the script
if projectFolder == 0
    disp('Folder selection canceled. Script terminated.');
    return;
end

% Create the project folder if it doesn't exist
if ~exist(projectFolder, 'dir')
    mkdir(projectFolder);
end

% Download the ZIP file using system commands (e.g., PowerShell)
zipFile = fullfile(projectFolder, 'repository.zip');
system(sprintf('powershell -command "Invoke-WebRequest -Uri %s -OutFile %s"', [repoURL, '/archive/main.zip'], zipFile));

% Extract the ZIP file
unzip(zipFile, projectFolder);

% Add the extracted folder to the MATLAB project
% Assuming you have a project object 'proj'
extractedFolder = fullfile(projectFolder, 'repository-main');
addFolderIncludingChildFiles(proj, extractedFolder);

disp('Project setup complete.');
