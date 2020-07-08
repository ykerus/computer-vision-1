Run main.m to read in the pre-trained and the fine-tuned models.
This will also train the SVM, give the accuracies, and 
visualise the features for each model.

A couple of notes:
- Make sure you have 'liblinear' and 'matconvnet' up and running and make 
sure their folders are placed in the Matlab path.
- In 'finetune_cnn', edit line 4 if your matconvnet folder is NOT named
'MatConvNet'.
- The program is based on the data set 'stl10', make sure you have the 
folder 'stl10_matlab' in your Matlab path, since this is not included in 
this folder (its size is too large).