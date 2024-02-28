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

% Create or open the MATLAB project in the selected folder
if ~exist(fullfile(projectFolder, 'project.prj'), 'file')
    proj = matlab.project.createProject(projectFolder);
else
    proj = simulinkproject(projectFolder);
end

% Define the GitHub repository URL
repoURL = 'https://github.com/Energy-Optimization-Lab/DC-Microgrid/archive/main.zip';


% Download the ZIP file using system commands (e.g., curl for macOS/Linux, PowerShell for Windows)
zipFile = fullfile(projectFolder, 'repository.zip');
if ispc
    system(sprintf('powershell -command "Invoke-WebRequest -Uri %s -OutFile %s"', [repoURL, '/archive/main.zip'], zipFile));
else
    system(sprintf('curl -L %s -o %s', [repoURL, '/archive/main.zip'], zipFile));
end

% Extract the ZIP file
unzip(zipFile, projectFolder);

% Add the extracted folder to the MATLAB project
extractedFolder = fullfile(projectFolder, 'repository-main');
addPath(proj, extractedFolder);

disp('Project setup complete.');
