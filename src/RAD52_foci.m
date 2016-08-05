% Script to perform RAD52 analysis
% for full screen use 'for i = 1:dataBlocks', otherwise specify the list
% 'files'

% add libsvm directory to the search path
path('./libsvm-mat-3.0-1-savesvm',path);

% load the foci classifier 
curr_dir = cd();
cd('../models/');
load model_foci.mat;
cd(curr_dir);

% Go to file directory that contains the data, store all the relevant directories
%%% make sure to change the data, output directories to where your input, outputs are located %%%
curr_dir = cd();
cd('/path/to/input/data/');
data_dir = cd();
cd('/write/the/output/here/');
output_dir = cd();

% Get the filenames
cd(data_dir);
files = dir('*object.CSV');

% Return to current directory
cd(curr_dir);

for i=1:numel(files)
  
    % read in the next data block
    cd(data_dir);
    data = dlmread(files(i).name,',');
    [rows,~] = size(data);
    cd(curr_dir);
    
    % pre process the data.  
    imobj = data(:,1:2);    % keep the image and object numbers.
    imobj_AS_features = data(:,1:14);    % keep the first 14 features, the image,object numbers and areashape features
    data = data(:,3:615);   % remove imobj, remove cells features.
    data = data(:,feature_index); % keep only the features we trained on.
    randomLabels = rand(rows,1);
    randomLabels = Scale(randomLabels,-1,1);
   
    % perform the predictions
    [predictions,~,~] = svmpredict(randomLabels,data,foci_model);
     
    % write the predictions out with the image & object numbers
    output = [predictions,imobj_AS_features];
    
    cd(output_dir);
    dlmwrite([files(i).name '.out'],output);
    cd(curr_dir);
    
    % clear out the loop variables to save storage
    clear data randomLabels predictions acc prob output rows cols imobj;
end   

% clear other intermediate variables
clear i files;
