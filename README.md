# Practical-Machine-Learning
##Coursera:Practical Machine Learning Project
### by R. Ashley


##Summary
This project is for the Coaursera - Practical Machine Learning class and focusses on building a model to predict the quality of exerzise for a Dumbell Bicep Curl. Using data collected from Human Activity Recognition - [HAR](http://groupware.les.inf.puc-rio.br/har#ixzz3sKQFQCKD) project, a Random Forrest learning model was created with 10 fold cross validation. This model produced an accuracy of 99% with the hold out set from the training data and correctly identified 20 out of 20 for the test data set.   

##Experiment and Data
The Human Activity Recognition - [HAR](http://groupware.les.inf.puc-rio.br/har#ixzz3sKQFQCKD) project used six young healthy participants were asked to perform one set of 10 repetitions of the Unilateral Dumbbell Biceps Curl in five different fashions or execize quality types: exactly according to the specification (Class A), throwing the elbows to the front (Class B), lifting the dumbbell only halfway (Class C), lowering the dumbbell only halfway (Class D) and throwing the hips to the front (Class E).

Inertial measurement units (IMU), which provide three-axes acceleration, gyroscope and magnetometer data, were mounted in the users’ glove, armband, lumbar belt and dumbbell.  All IMU data was recorded and loged for each participant and during all different exercize types. The excersize quality type was loged in the column `classe`.

Please see [link](http://brashley.github.io/Practical-Machine-Learning/Practical-Machine-Learning) for the HTML report.

####References
Velloso, E.; Bulling, A.; Gellersen, H.; Ugulino, W.; Fuks, H. **Qualitative Activity Recognition of Weight Lifting Exercises.** *Proceedings of 4th International Conference in Cooperation with SIGCHI (Augmented Human '13)* . Stuttgart, Germany: ACM SIGCHI, 2013.

Read more: http://groupware.les.inf.puc-rio.br/har#ixzz3sKVwnGFq
