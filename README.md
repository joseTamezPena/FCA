# FCA and GDSTM

Feature Correlation Analysis (FCA) and the Goal Driven Spatial Transformation Matrices (GDSTM)

This document describes the use of the **FRESA.CAD::GDSTMDecorrelation()** and **filteredFit()** functions to run feature correlation analysis (**FCA**) algorithm for ML purposes.

-   **FCA_Options_testing.Rmd** runs a script of the Vehicle data set showcasing the use *GDSTMDecorrelation()* for decorrelation, feature analysis and ML (**NB**).

    -   Output at: <https://rpubs.com/J_Tamez/GDSTMDecorrelation_tutorial>

-   **FCA_Options_testing_mfeat.Rmd** runs a simpler script on the multiple feature dataset.

    -   Output at: <https://rpubs.com/J_Tamez/GDSTMDecorrelation_mfeat>

-   **FCA_ML_testing_sonar.Rmd** is an example of how to run *filteredFit()*: (**NB** and **KNN**) with decorrelation on the Sonar dataset

    -   Output at: <https://rpubs.com/J_Tamez/FilteredFit_Decorrelation>

-   **FCA_ML_testing_ARCENE.Rmd** is an example of *filteredFit()* (Logistic **LASSO**) and with decorrelation on the Arcene dataset. (Due to the large dimensions of the ARCENE dataset This script will take several minutes to run)

    -   output at: <https://rpubs.com/J_Tamez/Arcene_FilteredFit>
