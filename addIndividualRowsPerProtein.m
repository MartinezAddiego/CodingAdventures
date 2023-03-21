function addIndividualRowsPerProtein

% Created 03.20.2023 by FMA
% The purpose of this function is to create a new excel file that has a
% unique row per unique protein name in the UniProtIds column.

% The input of this function is a table that must have a UniProtIds column
% The output of this function is a new table with a row per unique protein
% in the UniProtIds

% TO USE THIS FUNCTION MODIFY:
% Line 16: path for your excel file
% Line 39: output excel file name

% read in the excel file of interest
adultsProteomicsTable = readtable('INSERTPATHTOTABLE.xlsx'); % where the input is the path for the file 

finalMatrixForTable = array2table(zeros(1,size(adultsProteomicsTable,2)),'VariableNames', adultsProteomicsTable.Properties.VariableNames); % create a table with a row of zeros and the same variable names you had before

for rowIndex = 1:size(adultsProteomicsTable,1) %loop through all of the rows in the table
    namesOfUniqueProteins = strsplit(adultsProteomicsTable.UniProtIds{rowIndex},';'); % split the proteins by the semi-colon
    %create a matrix that replicates the information in that table row per
    %number of Unique Proteins
    newMatrixForTable = repmat(adultsProteomicsTable(rowIndex,1:end),length(namesOfUniqueProteins),1);
   
    %create a loop that goes in and replaces the protein name in the
    %UniProtIds column with one from the list of unique proteins in that
    %column
    for uniqueProteinIndex = 1:length(namesOfUniqueProteins)
        newMatrixForTable.UniProtIds{uniqueProteinIndex} = namesOfUniqueProteins{uniqueProteinIndex};
    end %end for loop going through each of the unique proteins you have in that row
    finalMatrixForTable = [finalMatrixForTable;newMatrixForTable]; %add this to the larger table we have going on

end %end for loop going through each of the rows in the table
%disp(finalMatrixForTable) %checks
%size(finalMatrixForTable) %checks
finalMatrixForTable(1,:) = []; %deletes first row of zeros

writetable(finalMatrixForTable, 'INSERTNAMEOFFINALTABLE.xlsx') % you can change this so that you have a new name for your table





