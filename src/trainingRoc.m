% Script to reproduce the ROC curve for the foci classifier.

% add libsvm directory to the search path.
path(path,'./libsvm-mat-3.0-1');

% Load the training set.
training_data = dlmread('../data/training_set.csv',',');

% Extract the training data, labels.
data_set = training_data(:,2:917);
classes = training_data(:,1);

% Split the training data into a training set and a test set.
% The random split should produce about 80% training, 20% test.
split_set = 0.75 + randn(size(data_set,1),1); 
split = split_set > 0;
training_set = data_set(split,:);
training_classes = classes(split,:);
test_set = data_set(~split,:);
test_classes = classes(~split,:);

% train the model using svmtrain.
model_repro = svmtrain(training_classes, training_set, '-t 1 -d 1 -e 0.001');

% get the predicted values for the test set.
[predictions] = svmpredict(test_classes, test_set, model_repro);

% produce and plot the ROC curve.
[X,Y,T,AUC] = perfcurve(test_classes,predictions,'1')
plot(X,Y)

% clean up everything produced in the script.
clear data_set classes split_set split training_set training_classes test_set test_classes model_repro predictions X Y T AUC;
