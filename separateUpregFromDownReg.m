function separateUpregFromDownReg

% Created 03.30.2023 by FMA
% The purpose of this function is to create two new excel files that
% separate the proteins that are upregulated from those that are
% downregulated

% The input of this function is a table that must have an AVGLog2Ratio
% column with positive or negative values

% The outputs of this function are TWO new tables each containing all the
% columns from the parent excel file; except one has positive AVGLog2Ratio
% values and the other has negative AVGLog2Ratio values

% TO USE THIS FUNCTION MODIFY:
% Line 21: path for your excel file
% Lines 43/45: output excel file names for positive and negative
% respectively

% load in the excel file of interest

juvProtSB3CTTreated = readtable('/PATH/Adults-proteomics-SB3CT-treated.xlsx'); % where the input is the path for the file 

positiveMatrixForTable = array2table(zeros(1,size(juvProtSB3CTTreated,2)),'VariableNames', juvProtSB3CTTreated.Properties.VariableNames); % create a table with a row of zeros and the same variable names you had before
negativeMatrixForTable = array2table(zeros(1,size(juvProtSB3CTTreated,2)),'VariableNames', juvProtSB3CTTreated.Properties.VariableNames); % create a table with a row of zeros and the same variable names you had before

for rowIndex = 1:size(juvProtSB3CTTreated,1) %loop through all of the rows in the table

    %split the positive and the negative values in the AVGLog2Ratio column
    if juvProtSB3CTTreated.AVGLog2Ratio(rowIndex) > 0
        positiveMatrixForTable = [positiveMatrixForTable; juvProtSB3CTTreated(rowIndex, :)];
    elseif juvProtSB3CTTreated.AVGLog2Ratio(rowIndex) <0
        negativeMatrixForTable = [negativeMatrixForTable; juvProtSB3CTTreated(rowIndex, :)];
    end % end if statement separating the two 

end %end for loop going through each of the rows in the table

%delete first row of zeros in each of the final matrices
positiveMatrixForTable(1,:) = []; %deletes first row of zeros
negativeMatrixForTable(1,:) = []; %deletes first row of zeros

%save the positive values
writetable(positiveMatrixForTable,'/PATH/positive_AdultProtSB3CTTreated_aftercode.xlsx') % you can change this so that you have a new name for your table
%save the negative values
writetable(negativeMatrixForTable,'/PATH/negative_AdultProtSB3CTTreated_aftercode.xlsx') % you can change this so that you have a new name for your table
