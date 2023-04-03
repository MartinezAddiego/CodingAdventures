function keepUniqueHumanSpeciesIDs

% Created 03.30.2023 by FMA
% The purpose of this function is to create a new excel file that removes
% all repeat values of the human gene ID

% The input of this function is a table created from the flyrnai.org
% website that MUST HAVE a human GeneID column

% The output of this function is a new table with only unique Human GeneID
% values

% TO USE THIS FUNCTION MODIFY:
% Line 21: path for your excel file
% Line 31: output excel file name

%load in and read the excel file of interest

%humanGeneIDResults = readtable('/PATH/test-flo.xlsx'); % where the input is the path for the file; THIS IS A TEST FILE!!! 

humanGeneIDResults = sortrows(readtable('/PATH/positive_Juvenile_HUMANID_RAW_diopt_results_2023-03-31 143551.xlsx'), 'HumanGeneID'); % where the input is the path for the file AND we sort all rows by the HumanGeneID column

% we want to remove duplicates of values in the human species gene id
% column; if there is a duplicate, simply delete the row

% select the index of the rows where there is a duplicate :)
rowIndexToKeep = [find(diff(humanGeneIDResults.HumanGeneID)~=0)];
% actually index the results
finalGeneResults = humanGeneIDResults(rowIndexToKeep,:);
% save the table as something meaningful
writetable(finalGeneResults,'/PATH/positive_Juvenile_HUMANID_EDITED_diopt_results_2023-03-31 143551.xlsx') % you can change this so that you have a new name for your table


