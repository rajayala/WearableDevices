---
title       : Wearable Devices
subtitle    : Modeling and Prediction of Human Activity
author      : Raj Ayala
job         : Coursera - Johns Hopkins School of Public Health
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Human Activity Recognition

1. Wearable devices are becoming increasing popular as they find applications in personal fitness, healthcare, security, and other areas
2. Jawbone and Fitbit are examples of personal fitness devices.
3. Caring for recovering surgery patients and administer certain medications are healthcare applications.
4. The underlying technology behind these applications is the ability to predict human activity (e.g., light sleep, deep sleep, walking, running, etc.), based on the data collected from the wearable devices.
5. Typical devices built into wearables are the gyroscope and the accelerometer.
6. These devices collect data pertaining variaous parameters, such as, x,y,z directional movements of a gyro band; x,y,z angular velocity measurements, etc.
7. Once the data is collected, these parameters becomes predictors for recognizing human activity.

---

## Building Data Models

1. First, you partition the collected data into training and test sets. Keep the test set aside and don't touch it until you have completed building the models and are ready for predictions on test data set.
2. Explore the data to clean up any missing values, eliminate any "near-zero-variance" variables, and reduce dimensionality by looking at closely correlated variables.
3. Then you can further partition the training data into training and test subsets. 
4. Choose some models to try out - we have chosen three
  - Random Forest (rf)
  - Support Vector Machines (svm)
  - kNearest Neighbors (kNN)
5. We then use these models to make predictions against test data.

---

## Predictions Against Test Data
From the shiny application (http://rajayala.shinyapps.io/WearableDevices), we see that the predictions of the three models against 20 test cases are:

```r
## build data frame of predictions .. use out put of shiny apps, so that
## we don't have to run th emodels here
test.pred.rf <- c("SITTING",  "STANDING", "SITTING",  "STANDING", "STANDING", "RUNNING",
                  "SLEEPING", "SITTING",  "STANDING", "STANDING", "SITTING",  "WALKING",
                  "SITTING", "STANDING", "RUNNING",  "RUNNING",  "STANDING", "SITTING", 
                  "SITTING",  "SITTING")
test.pred.rf <- as.factor(test.pred.rf)
test.pred.svm <- c("WALKING", "STANDING", "STANDING", "STANDING", "STANDING", "SITTING",
                   "SLEEPING", "SITTING",  "STANDING", "STANDING", "STANDING", "WALKING",
                   "SITTING", "STANDING", "RUNNING",  "RUNNING",  "STANDING", "SITTING",
                   "SITTING",  "SITTING")
test.pred.svm <- as.factor(test.pred.svm)
test.pred.knn <- c("WALKING", "STANDING", "SITTING",  "STANDING", "STANDING", "RUNNING",
                   "SLEEPING", "RUNNING", "STANDING", "STANDING", "SITTING",  "WALKING",
                   "WALKING", "STANDING", "STANDING", "RUNNING",  "STANDING", "SITTING",
                   "SITTING",  "SITTING")
test.pred.knn <- as.factor(test.pred.knn)
```

---

## How the Predictions of different Models Compare to True Outcomes
The right outcomes for the test set and how they compare with predictions from models are

```r
right_pred <- c("SITTING",  "STANDING", "SITTING",  "STANDING", "STANDING", "RUNNING",
                "SLEEPING", "SITTING",  "STANDING", "STANDING", "SITTING",  "WALKING",
                "SITTING", "STANDING", "RUNNING",  "RUNNING",  "STANDING", "SITTING", 
                "SITTING",  "SITTING")
right_pred <- as.factor(right_pred)
pred.df <- data.frame(rf.p = test.pred.rf, svm.p = test.pred.svm, knn.p = test.pred.knn)
pred.df$right <- with(pred.df, right_pred)
head(pred.df, 4)
```

```
##       rf.p    svm.p    knn.p    right
## 1  SITTING  WALKING  WALKING  SITTING
## 2 STANDING STANDING STANDING STANDING
## 3  SITTING STANDING  SITTING  SITTING
## 4 STANDING STANDING STANDING STANDING
```

---

## Accuracy of Predictions of Different Models

From the results, we see that the accuracy of the predictions of the three models is as follows:


```r
acc <- data.frame(Model=c("Random Forest", "SVM (radial)", "KNN"),
          Accuracy = c(sum(test.pred.rf == right_pred)/20,
                      sum(test.pred.svm == right_pred)/20,
                      sum(test.pred.knn == right_pred)/20))
acc
```

```
##           Model Accuracy
## 1 Random Forest      1.0
## 2  SVM (radial)      0.8
## 3           KNN      0.8
```

We see that Random Forest model yields almost 100% accuracy whereas SVM and kNN are runners-up at 80% performance.

---

## SUMMARY

1. Model-building takes time and effort.
2. Once you have the right model, predictions are fast. This is what makes the wearables a consumer hit.
3. More consumers using wearables implies that there will be more data available for analysis.
4. Data begets data, which leads to better future applications as we understand the big data.








