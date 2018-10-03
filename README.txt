README FILE for submission Project 1
====================================

* CISC 810 - Quantitative Foundation
  Rochester Institute of Technology
  September 25, 2018

* Project 1:  Linear Feature Engineering
  Students:   Valdecantos Hector - Wagh Gaurav
  Instructor: Linwei Wang

This is a Matlab project on linear feature engineering.

CONTENT:

  [main.m]
  Main script file that implements the K-fold cross-validation procedure to
  estimate the goodness of a model.

  [cv_k_fold_features.m]
  Matlab script file that implements the K-fold cross-validation procedure for
  all possible combination of features (2^8 - 1 = 255) and select the variable
  arrangement which produced the least test error.
 
  [back_subtitute.m]
  Function that implements the back substitution method given an
  upper-triangular system, i.e. the A matrix and the right-hand side vector b.

  [expand.m]
  Function that implements the expansion of X into Z matrix depending on the
  function terms given.

  [get_fold_sizes.m]
  Function that returns a vector of sizes depending on the size of the X data
  set and number of folds to implement.
 
  [get_folds.m]
  Function that returns the training and test sets given a current k iteration
  on a k-fold method.

  [get_polynomial.m]
  Function that given the order and the variables involved in a general multi
  variable polynomial form will return the polynomial written as separate
  anonymous functions for each of its term along with an index designating the
  variable that applies to that term.

  [least_squares.m]
  Function that uses the Gaussian elimination method by reducing a linear
  system into an upper-triangular and then solve the system by
  back-substitution. It returns the sum of square error (R) and the weights
  coefficients.

  [plot_errors.m]
  Function to plot a series of points with a mark (*) link with a line, used to
  graph the Sum of Squared Errors (R) of training and test sets.

  [testinputs.txt]
  Data with 103 rows, each with 8 numbers representing the test input from
  which the response variable the project predicts.

  [traindata.txt]
  Data with 926 rows, each with 8 numbers representing the real-valued
  predictors along together with a 9th number for a real-valued response value.

  [triangularize.m]
  Function that given a linear system Ax=b in the form of a matrix (A|b), will
  return an upper-triangular system (A'|b').

INSTRUCTIONS:

  1. Open Matlab and set the project path to the folder containing the above
     mentioned files.
  2. Doble-click the main file 'main.m' to open it on the editor area.
  3. Execute or run the file by clicking on the run button or pressing F5 key.
  4. Get the output of the execution, that consists of:
     - A figure with the averaged R of train and test sets for each polynomial
       order considered.
     - The output answers (ans) in the command windows will show the 
       polynomial order and the minimun test error with its corresponding
       train error.
     - A file named 'predicted_values.txt' will be written in the same project
       directory with the 103 predictions values based on the proposed model.

