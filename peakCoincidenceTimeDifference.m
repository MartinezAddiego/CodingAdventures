function peakCoincidenceTimeDifference

%this function will expect files to be in a .csv format
% get path and files from this path ending in .csv

csvFiles = dir('C:\Users\Flo\Desktop\MiscellaneousCodingAdventures\forIsmary\here\*.csv'); % this holds all our CSV files

tableForColNames = readtable(fullfile(csvFiles(1).folder, csvFiles(1).name));

finalADLTable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);
positiveADLTable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);
negativeADLTable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);
finalBLATable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);
positiveBLATable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);
negativeBLATable = array2table(zeros(1,size(tableForColNames,2)),'VariableNames', tableForColNames.Properties.VariableNames);

for csvFileIndex = 1:length({csvFiles.name})
    %look to see if ch1 or ch2
    if contains(csvFiles(csvFileIndex).name , 'ch1' ,'IgnoreCase' ,true)
        holdCurrentADLTable = readtable(fullfile(csvFiles(csvFileIndex).folder, csvFiles(csvFileIndex).name));
        finalADLTable = [finalADLTable; holdCurrentADLTable];

        % loop through each row in the table
        for rowIndex = 1:size(holdCurrentADLTable,1)
            if holdCurrentADLTable.PeakDiff_ms(rowIndex) > 0
                positiveADLTable = [positiveADLTable; holdCurrentADLTable(rowIndex,:)];
            elseif holdCurrentADLTable.PeakDiff_ms(rowIndex) < 0
                negativeADLTable = [negativeADLTable; holdCurrentADLTable(rowIndex,:)];
            end % end if statement checking to see if you have a positive or negative value
        end % end loop going through each row in the table

    elseif contains(csvFiles(csvFileIndex).name , 'ch2' ,'IgnoreCase' ,true)
        holdCurrentBLATable = readtable(fullfile(csvFiles(csvFileIndex).folder, csvFiles(csvFileIndex).name));
        finalBLATable = [finalBLATable; holdCurrentBLATable];

        % loop through each row in the table
        for rowIndex = 1:size(holdCurrentBLATable,1)
            if holdCurrentBLATable.PeakDiff_ms(rowIndex) > 0
                positiveBLATable = [positiveBLATable; holdCurrentBLATable(rowIndex,:)];
            elseif holdCurrentBLATable.PeakDiff_ms(rowIndex) < 0
                negativeBLATable = [negativeBLATable; holdCurrentBLATable(rowIndex,:)];
            end % end if statement checking to see if you have a positive or negative value
        end % end loop going through each row in the table

    else
        disp("The file names do not have the expected channel demarcation...")
        %need to add a line that quits the code
        return
    end % end if statement separating the ch1 from ch2
end %end for loop going through each of the csv files

finalADLTable(1,:) = []; %deletes first row of zeros
finalBLATable(1,:) = []; %deletes first row of zeros
positiveADLTable(1,:) = [];
negativeADLTable(1,:) = [];
positiveBLATable(1,:) = [];
negativeBLATable(1,:) = [];

% take the absolute value of all the values in the negative tables
negativeADLTable.PeakDiff_ms = abs(negativeADLTable.PeakDiff_ms);
negativeBLATable.PeakDiff_ms = abs(negativeBLATable.PeakDiff_ms);

%save the ADL values
writetable(finalADLTable,[csvFiles(1).folder, '/','testADL.csv']) % you can change this so that you have a new name for your table
%save positive ADL values
writetable(positiveADLTable,[csvFiles(1).folder, '/','testPositiveADL.csv']) % you can change this so that you have a new name for your table
%save negative ADL values
writetable(negativeADLTable,[csvFiles(1).folder, '/','testNegativeADL.csv']) % you can change this so that you have a new name for your table

%save the BLA values
writetable(finalBLATable,[csvFiles(1).folder, '/','testBLA.csv']) % you can change this so that you have a new name for your table
%save positive BLA values
writetable(positiveBLATable,[csvFiles(1).folder, '/','testPositiveBLA.csv']) % you can change this so that you have a new name for your table
%save negative BLA values
writetable(negativeBLATable,[csvFiles(1).folder, '/','testNegativeBLA.csv']) % you can change this so that you have a new name for your table


