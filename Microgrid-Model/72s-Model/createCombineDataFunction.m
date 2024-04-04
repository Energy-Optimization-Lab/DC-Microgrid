function createCombineDataFunction(numScores)
    % Open a new file for writing
    fid = fopen('CombineData.m', 'w');
    
    % Write the function signature with a variable number of inputs
    fprintf(fid, 'function combinedData = CombineData(');
    for i = 1:numScores
        fprintf(fid, 'BatteryAllocScore%d', i);
        if i < numScores
            fprintf(fid, ', ');
        end
    end
    fprintf(fid, ')\n\n');
    
    % Write the body of the function to combine the scores into a single array
    fprintf(fid, '    combinedData = [');
    for i = 1:numScores
        fprintf(fid, 'BatteryAllocScore%d', i);
        if i < numScores
            fprintf(fid, ', ');
        end
    end
    fprintf(fid, '];\n\n');
    
    % End the function
    fprintf(fid, 'end\n');
    
    % Close the file
    fclose(fid);
end
