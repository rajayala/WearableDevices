# WearableDevices
Models for preiction of human activity based on data from wearables

Wearable devices are becoming increasing popular as they find applications in personal fitness, healthcare, security,
and other areas. Jawbone and Fitbit are examples of personal fitness devices. Healthcare industry is deploying novel
applications in caring for recovering surgery patients, administer certain medications, and even discounting health
insurance premiums if one has healthy habits.

The underlying technology behind these applications is the ability to predict whether an individual is light sleep, deep
sleep, walking, running, etc., based on the data collected from the wearable devices. Of course, in order to predict human
activity, it is necessary to collect large amounts of data and build models on training data. In this repository, we provide
a Shiny application and some sample training data and test data for human activity recognition. We build three models - 
Random Forest (RF), Support Vector Machines (SVM), and k-Nearest neighbors (kNN). 

As these models take several minutes to compute, to minimize user interaction delays, we store the R-objects that contain
these models as .RDS files in the repository. In the server.R, instead of computing the models from the training data, we
just read the stored .RDS model objects and use them for predictions on chosen test data, which consists of 20 test cases.
The outcome of the test cases is not available in the testing.csv file as it is masked in the problem_id columns. The correct
outcomes are listed in the "right_pred" variable in server.R code.

The UI.R gives the user the ability choose a specific test case (1 to 20) and one of the three models. When the user hits the
"submit" button, the app displays the chosen model's prediction for the test case vs the right prediction, and also displays
the "confusion matrix" for the model. The accuracy of the models on training and test data is also displayed at the bottom.

So, play with interactive inputs and see the responsive outputs and enjoy!

