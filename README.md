# Styles 2016 foci classifier scripts

Software used to classify and score screens for Styles 2016.

To run the classifier, you will need:
- a working version of Matlab installed and accessible in your path.  
- `gunzip` installed to uncompress the training_set.csv.gz file.

Unzip the training set by running `gunzip data/training_set.csv.gz` 
To train the classifier, run `src/RAD52_train.m`
To train the model and produce a ROC figure on held out training data, run `src/trainingRoc.m`

N.B: If you cannot get the libsvm bindings to work, you may need to follow the instructions in `libsvm-mat-3.0-1/README`

## Project layout

    styles2016
    |
    |- data/          # contains the training set for the foci classifier.
    |
    |- src/           # source code for the foci classifier, B-score normalization.
    |
    |- models/        # .mat model file of the classifier used to score screens.
