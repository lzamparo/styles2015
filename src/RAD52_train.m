% Trains the foci classification model.  Meant to be run from
% morphology/RAD52
% Make sure the path includes libsvm
% add libsvm directory to the search path
path('./libsvm-mat-3.0-1-savesvm',path);

% Load the data, as well as the training set.
training_set = dlmread('../data/training_set.csv',',');

% Extracts the training data, labels.
training_data = training_set(:,2:917);
training_classes = training_set(:,1);

% Perform the feature selection
features = rankFeatures(training_data,training_classes,0.001);

% Select only those features that do not include:
%   ImageNumber, ObjectNumber, columns (1,2)
%   Cells features, columns (612:)

relevant_features = features(3:611,:);
feature_index = relevant_features(:,2) == 1;

% Finally, get the relevant parts of the training data
training_data = training_data(:,3:611);
training_data = training_data(:,feature_index);

% Scale the data 
scaled_training_data = Scale(training_data,0,1);

% construct the model
foci_model = svmtrain(training_classes,training_data,'-s 0 -t 1 -d 1 -e 0.001');

% save the model to the models dir
save('../models/my_model_foci.mat','foci_model','feature_index');
