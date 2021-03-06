


# ESM Methods

## Equations for outcomes

The equations for calculating the outcome variables are listed below. HOMA2-%S was 
calculated using the Excel found at https://www.dtu.ox.ac.uk/homacalculator/.

$$\text{ISI}_{\text{OGTT}} = \frac{10000}{\sqrt{(\mathrm{G_{0min}} \times \mathrm{I_{0min}}) \times (\mathrm{G_{mean}} \times \mathrm{I_{mean}} )}}$$

$$\text{HOMA-IR} = \frac{\mathrm{G_{0min}} \times \mathrm{I_{0min}}}{22.5}$$

$$\text{IGI/IR} = \frac{\frac{\mathrm{I_{30min}} - \mathrm{I_{0min}}}{\mathrm{G_{30min}} - \mathrm{G_{0min}}}}{\text{HOMA-IR}}$$

$$\text{ISSI-2} = \left(\frac{\mathrm{Insulin\: AUC}}{\mathrm{Glucose\: AUC}}\right) \times \mathrm{ISI}$$

Area under the curve (AUC) for both glucose (G) and insulin (I) was computed
using the trapezoidal rule. ISI~OGTT~ (ISI) uses all the glucose and insulin
values from the oral glucose tolerance (the overall mean).

## Further description of statistical methods

Generalized estimating equations (GEE) is a technique similar to mixed effects 
modelling, except it calculates the marginal population estimates compared to the
subject-specific estimates in mixed effects models. GEE is well suited to and
commonly used in longitudinal cohort studies, especially given its capacity to
handle missed visits and for the correlation of variables across time. 
GEE is able to handle the correlation of longitudinal data due to the
estimating of a working correlation matrix, which was chosen based on
quasi-likelihood information criteria (QIC; more detail on QIC below). The auto-regressive of order 1
(AR1) matrix was chosen for the GEE models as it had the best model fit accessed
using QIC, though other matrices (eg. exchangeable) had similar fit (data not
shown). While the choice of the correlation matrix is important, it should be noted
that even with misspecification GEE still computes robust estimates and standard errors.
One main advantage of using methods such as GEE is the inclusion of the
working correlation matrix that takes into account the inherent covariance
between values measured at different time points when computing model estimates
and standard errors. AR1 is the most appropriate correlation matrix for
longitudinal data since the correlation matrix assumes lower intercorrelation of
values within an individual as time passes. For example, BMI measured at the
baseline visit would be more highly correlated to BMI measured at the 3rd year
visit than compared to the 6th year visit.

For the covariates, they were chosen based on previous literature, from directed
acyclic graph (DAG) recommendations, and from QIC. The DAG recommendations were
obtained from using the DAGitty software, http://dagitty.net/. DAG is a
technique that allows for identifying potential confounding causal pathways and
to limit potential bias. DAGs are composed on nodes (variables) connected by
edges (arrows; causal pathway between two variables). Using DAGs to identify
variables to adjust for done algorithmically, as implemented in the DAGitty
software. DAGitty calculates possible sets of variables to include in a model to
adjust for potential confounding in the causal network. Use of DAGs in this
manner can identify potential sources of bias, such as from inclusion of
colliding variables. A collider variable is a variable that has two (or more)
'parent' nodes/variables (connected causally by DAG edges pointing into the
'child' node, which is the collider). The collider variable and parent variables
are directed linked to the exposure and the outcome. Including all variables
involved with the collider could introduce bias as it does not generate an
unconditional association between all involved variables in the model.

QIC is a technique that balances the goodness of fit of the model with its
relative complexity (i.e. number of covariates) against other models being
compared. QIC, more so then the more common AIC, penalizes the inclusion of more
variables in the model. This technique is used to compare multiple models to
identify the model with the highest fit and with the lowest complexity (variables),
*of the models compared*. QIC is similar to AIC, except AIC is based on maximum
likelihood of models such as mixed effects models. Since GEE does not use
maximum likelihood, AIC can not be used. QIC and other information
criterion methods are used in conjunction with other techniques such as
literature and DAG based. The final GEE model selected as best fitting was
negligibly different when using insulin sensitivity or beta-cell function as an
outcome and as such the same covariates were chosen for models with each of the
outcomes. The covariates medication use, WC, ALT, and MET would be considered
classical confounders while TAG would be considered a mediating variable.

Partial least squares (PLS) regression is a technique similar to principal
component analysis (PCA) that is designed to extract meaningful information from
multivariate, high dimensionality data (e.g. as in metabolomic and other -omic type 
analyses). These types of methods try to extract as much of the variance in the 
data into a smaller number of components or factors. The difference between PCA 
and PLS is that PLS is a supervised method, while PCA is not. This means that
PLS uses a response variable(s), i.e. an outcome or **Y**, to 'supervise' (or
constrain) the variation inherent in the predictors (**X**) while PCA only
describes the variation inherent in **X**. Because of this, PLS can be better at
predicting the contributions of predictor variables against an outcome variable.
In this analysis, PLS was computed on the NEFA as a proportion due to the
inherent interdependence of the values (all must equal 100%). This 
interdependence allows PLS to identify patterns in the composition, since
the concentration data is all highly positively correlated with each other.

# ESM Tables




| Model           |     QIC | Delta |
|:----------------|--------:|------:|
| **log(ISI)**    |         |       |
| M9              | -1490.9 |   0.0 |
| M12             | -1490.5 |   0.4 |
| M4              | -1485.4 |   5.4 |
| M10             | -1465.9 |  24.9 |
| M5              | -1459.2 |  31.6 |
| M6              | -1457.4 |  33.5 |
| M3              | -1455.2 |  35.7 |
| M11             | -1454.6 |  36.3 |
| M7              | -1453.4 |  37.5 |
| M8              | -1452.3 |  38.6 |
| M0              | -1040.0 | 450.9 |
| M1              | -1039.5 | 451.4 |
| M2              | -1037.9 | 452.9 |
| **log(ISSI-2)** |         |       |
| M4              | -2473.4 |   0.0 |
| M12             | -2472.1 |   1.4 |
| M9              | -2471.1 |   2.3 |
| M7              | -2470.4 |   3.0 |
| M11             | -2465.6 |   7.9 |
| M6              | -2465.3 |   8.2 |
| M3              | -2464.9 |   8.5 |
| M8              | -2464.0 |   9.4 |
| M5              | -2462.7 |  10.8 |
| M10             | -2462.5 |  11.0 |
| M2              | -2229.5 | 243.9 |
| M1              | -2171.5 | 302.0 |
| M0              | -2170.9 | 302.6 |

Table: ESM Table  1: Comparing generalized estimating equation models adjusting for different covariates using Quasi-Likelihood Information Criterion.

Given the number of possible combinations of outcome and predictor variables,
only ISI and ISSI-2 with total non-esterified fatty acids (nmol/mL) were used to
compare various GEE models and to select a final model.  Baseline age was used
as including both the original age and the time variable would result in
collinearity.  Column names are: QIC is the quasi-likelihood information criteria
(smaller values, eg. larger negative values, indicate a better fit compared to
other models), Delta is the QIC minus the lowest QIC (models that have a delta <10 
between them are considered equivalent).  Models were:

- M0: log(ISSI-2) or log(ISI) = total non-esterified fatty acids (nmol/mL) + years from baseline
- M1: M0 + NEFA by time interaction
- M2: M0 + sex + ethnicity + baseline age
- M3: M2 + waist
- M4: M3 + ALT
- M5: M3 + physical activity
- M6: M3 + alcohol intake
- M7: M3 + family history of diabetes
- M8: M3 + smoking status
- M9: M3 + ALT + physical activity
- M10: M3 + medication use for lipid and cholesterol control
- M11: M3 + NEFA by time interaction
- M12: M9 + NEFA by time interaction


| NEFA    | Concentrations (nmol/mL) | Proportion (mol%) |
|:--------|:------------------------:|:-----------------:|
| 22:6n-3 |       1.73 (1.17)        |    0.47 (0.31)    |
| 22:5n-3 |       0.66 (0.43)        |    0.18 (0.13)    |
| 20:5n-3 |       0.71 (0.55)        |    0.19 (0.16)    |
| 18:3n-3 |       4.71 (2.15)        |    1.23 (0.44)    |
| 22:4n-6 |       0.45 (0.34)        |    0.12 (0.10)    |
| 20:4n-6 |       3.06 (1.39)        |    0.83 (0.38)    |
| 20:3n-6 |       1.45 (1.41)        |    0.40 (0.40)    |
| 20:2n-6 |       0.89 (0.37)        |    0.23 (0.07)    |
| 18:3n-6 |       0.66 (0.57)        |    0.18 (0.18)    |
| 18:2n-6 |      54.09 (19.40)       |   14.05 (2.46)    |
| 18:1n-7 |       10.09 (4.04)       |    2.60 (0.52)    |
| 16:1n-7 |       10.31 (6.88)       |    2.54 (1.14)    |
| 14:1n-7 |       0.33 (0.34)        |    0.08 (0.07)    |
| 24:1n-9 |       0.60 (0.78)        |    0.16 (0.22)    |
| 22:1n-9 |       0.33 (0.30)        |    0.10 (0.11)    |
| 20:1n-9 |       1.68 (1.49)        |    0.44 (0.37)    |
| 18:1n-9 |      142.39 (52.48)      |   36.56 (4.86)    |
| 22:0    |       0.15 (0.25)        |    0.04 (0.07)    |
| 20:0    |       0.67 (0.32)        |    0.19 (0.12)    |
| 18:0    |      55.15 (14.06)       |   15.16 (4.10)    |
| 16:0    |      89.81 (33.66)       |   23.45 (5.07)    |
| 14:0    |       3.16 (2.90)        |    0.80 (0.64)    |
| Total   |     383.07 (116.29)      |                   |

Table: ESM Table  2: Raw concentration values of each non-esterified fatty acid in the PROMISE cohort at the baseline visit (2004-2006). Values are presented as mean (SD).


| Fatty acid  | log(HOMA2-%S)        | log(ISI)             | log(IGI/IR)           | log(ISSI-2)         |
|:------------|:---------------------|:---------------------|:----------------------|:--------------------|
| **Total**   |                      |                      |                       |                     |
| Total       | -2.9 (-8.0, 2.5)     | -5.3 (-10.4, 0.1)    | -8.4 (-13.8, -2.7)\*  | -4.9 (-7.7, -2.0)\* |
| **nmol/mL** |                      |                      |                       |                     |
| 14:0        | 4.5 (-1.2, 10.6)     | 4.2 (-1.5, 10.2)     | 0.7 (-6.1, 8.0)       | 0.8 (-2.5, 4.2)     |
| 16:0        | -4.1 (-9.0, 1.1)     | -5.9 (-10.8, -0.8)   | -7.6 (-13.3, -1.5)    | -4.3 (-7.1, -1.4)\* |
| 18:0        | -1.9 (-6.5, 3.0)     | -2.9 (-7.7, 2.2)     | -5.1 (-10.5, 0.7)     | -2.6 (-5.5, 0.3)    |
| 20:0        | 2.4 (-2.7, 7.8)      | 2.5 (-2.9, 8.3)      | -0.6 (-7.0, 6.2)      | 0.1 (-3.0, 3.3)     |
| 22:0        | 0.4 (-4.4, 5.4)      | -1.0 (-5.7, 3.9)     | 3.1 (-2.5, 9.1)       | 0.6 (-2.5, 3.8)     |
| 18:1n-9     | -2.3 (-7.3, 3.0)     | -4.6 (-9.7, 0.8)     | -8.1 (-13.3, -2.5)\*  | -4.8 (-7.6, -1.8)\* |
| 20:1n-9     | -0.8 (-5.6, 4.2)     | -0.9 (-6.0, 4.4)     | -4.7 (-11.2, 2.2)     | -2.3 (-5.6, 1.0)    |
| 22:1n-9     | -6.3 (-10.4, -2.1)\* | -5.2 (-9.4, -0.7)    | -2.2 (-8.0, 4.0)      | -1.8 (-4.7, 1.1)    |
| 24:1n-9     | 1.9 (-2.3, 6.3)      | 1.2 (-3.3, 5.9)      | 2.5 (-2.4, 7.6)       | 0.4 (-1.9, 2.7)     |
| 14:1n-7     | 3.8 (-2.2, 10.2)     | 3.6 (-2.2, 9.7)      | 0.6 (-7.2, 8.9)       | 0.4 (-3.0, 3.9)     |
| 16:1n-7     | -0.8 (-6.2, 4.8)     | -1.6 (-6.8, 3.9)     | -6.0 (-12.2, 0.8)     | -3.4 (-6.5, -0.2)   |
| 18:1n-7     | -6.8 (-11.3, -2.0)\* | -8.4 (-13.2, -3.4)\* | -11.2 (-16.5, -5.7)\* | -6.4 (-9.2, -3.6)\* |
| 18:2n-6     | -1.2 (-6.7, 4.6)     | -3.9 (-9.4, 1.9)     | -6.1 (-11.5, -0.5)    | -3.8 (-6.7, -0.7)   |
| 18:3n-6     | -0.1 (-5.4, 5.6)     | -0.7 (-6.1, 5.0)     | -1.2 (-7.5, 5.5)      | -1.8 (-5.0, 1.6)    |
| 20:2n-6     | -2.6 (-7.4, 2.5)     | -4.8 (-9.7, 0.4)     | -7.5 (-13.1, -1.5)    | -4.3 (-7.3, -1.3)\* |
| 20:3n-6     | -1.0 (-5.1, 3.2)     | -2.2 (-6.6, 2.3)     | -0.7 (-5.2, 4.1)      | -1.0 (-3.2, 1.3)    |
| 20:4n-6     | -4.9 (-9.1, -0.4)    | -6.7 (-11.1, -2.1)\* | -6.7 (-13.2, 0.3)     | -3.8 (-7.3, -0.2)   |
| 22:4n-6     | -7.6 (-11.9, -3.2)\* | -8.4 (-12.9, -3.7)\* | 1.7 (-4.6, 8.5)       | 0.2 (-3.1, 3.6)     |
| 18:3n-3     | 1.1 (-4.6, 7.1)      | -1.9 (-7.5, 4.0)     | -3.9 (-9.4, 1.9)      | -2.6 (-5.6, 0.5)    |
| 20:5n-3     | 11.8 (5.5, 18.5)\*   | 8.1 (1.9, 14.8)      | 3.6 (-2.4, 10.0)      | 1.2 (-1.7, 4.1)     |
| 22:5n-3     | -3.0 (-7.5, 1.8)     | -4.3 (-9.2, 0.9)     | -5.2 (-10.8, 0.7)     | -3.1 (-6.1, -0.1)   |
| 22:6n-3     | 0.0 (-4.2, 4.5)      | -3.2 (-7.9, 1.7)     | -0.2 (-4.9, 4.8)      | -0.8 (-3.2, 1.7)    |
| **mol%**    |                      |                      |                       |                     |
| 14:0        | 6.9 (1.5, 12.5)      | 7.0 (1.5, 12.9)      | 3.5 (-2.9, 10.4)      | 2.3 (-0.9, 5.7)     |
| 16:0        | -2.4 (-7.0, 2.5)     | -2.8 (-7.6, 2.3)     | 0.6 (-5.1, 6.6)       | 0.2 (-2.5, 3.0)     |
| 18:0        | 2.2 (-2.6, 7.3)      | 4.9 (-0.3, 10.4)     | 5.0 (-1.2, 11.6)      | 3.3 (0.3, 6.4)      |
| 20:0        | 4.9 (0.0, 10.1)      | 6.6 (1.3, 12.2)      | 4.6 (-1.9, 11.5)      | 3.1 (0.2, 6.1)      |
| 22:0        | 0.1 (-4.0, 4.5)      | -0.1 (-4.4, 4.4)     | 3.5 (-1.7, 9.0)       | 1.0 (-1.8, 3.8)     |
| 18:1n-9     | -1.1 (-5.6, 3.8)     | -2.0 (-6.8, 3.0)     | -4.8 (-10.3, 1.0)     | -2.8 (-5.6, 0.2)    |
| 20:1n-9     | 0.1 (-4.3, 4.7)      | 0.8 (-4.2, 6.1)      | -2.4 (-8.6, 4.2)      | -1.0 (-4.3, 2.5)    |
| 22:1n-9     | -3.3 (-7.6, 1.3)     | -1.1 (-5.5, 3.6)     | 2.2 (-3.5, 8.3)       | 0.9 (-2.2, 4.0)     |
| 24:1n-9     | 3.6 (-0.7, 8.1)      | 3.3 (-1.4, 8.1)      | 4.7 (-0.7, 10.4)      | 1.6 (-1.0, 4.2)     |
| 14:1n-7     | 5.8 (-0.2, 12.2)     | 5.7 (-0.3, 12.2)     | 2.9 (-4.2, 10.6)      | 1.5 (-1.9, 5.0)     |
| 16:1n-7     | 1.3 (-3.8, 6.6)      | 0.8 (-4.4, 6.2)      | -1.6 (-7.7, 4.9)      | -1.3 (-4.3, 1.7)    |
| 18:1n-7     | -7.9 (-12.3, -3.2)\* | -7.0 (-12.1, -1.7)   | -8.5 (-13.7, -3.0)    | -4.5 (-7.3, -1.6)   |
| 18:2n-6     | 1.1 (-4.6, 7.1)      | 0.0 (-5.9, 6.2)      | -0.2 (-6.3, 6.3)      | -0.3 (-3.5, 3.0)    |
| 18:3n-6     | 2.1 (-3.0, 7.5)      | 2.3 (-3.0, 7.8)      | 3.2 (-2.8, 9.5)       | 0.9 (-2.5, 4.4)     |
| 20:2n-6     | -1.7 (-6.1, 2.9)     | -2.0 (-6.9, 3.2)     | -3.9 (-9.3, 1.8)      | -2.0 (-4.8, 0.9)    |
| 20:3n-6     | 1.6 (-2.6, 6.1)      | 1.1 (-3.5, 6.0)      | 2.8 (-2.2, 7.9)       | 1.1 (-1.3, 3.6)     |
| 20:4n-6     | -2.2 (-6.8, 2.5)     | -2.0 (-7.0, 3.2)     | -0.3 (-6.3, 6.0)      | 0.1 (-3.0, 3.3)     |
| 22:4n-6     | -5.9 (-10.1, -1.6)   | -5.5 (-9.8, -0.9)    | 7.2 (1.6, 13.1)       | 3.1 (0.3, 6.0)      |
| 18:3n-3     | 3.0 (-2.4, 8.7)      | 1.3 (-4.1, 7.1)      | 1.5 (-4.6, 8.0)       | 0.6 (-2.5, 3.8)     |
| 20:5n-3     | 13.1 (6.7, 20.0)\*   | 10.3 (3.8, 17.3)\*   | 6.4 (-0.1, 13.2)      | 2.8 (-0.3, 5.9)     |
| 22:5n-3     | -0.7 (-5.1, 3.9)     | 0.0 (-5.6, 6.0)      | -1.2 (-6.7, 4.7)      | -0.4 (-3.4, 2.7)    |
| 22:6n-3     | 1.7 (-3.1, 6.6)      | -0.5 (-6.0, 5.4)     | 3.8 (-1.0, 8.8)       | 1.6 (-0.8, 4.1)     |

Table: ESM Table  3: Unadjusted generalized estimating equation models of the longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort.  GEE models are only adjusted for time. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid.  P-values were adjusted for the BH false discovery rate, with significant (p<0.05) associations indicated by asterisk.



| Fatty acid  | log(HOMA2-%S)     | log(ISI)          | log(IGI/IR)          | log(ISSI-2)         |
|:------------|:------------------|:------------------|:---------------------|:--------------------|
| **Total**   |                   |                   |                      |                     |
| Total       | -0.6 (-4.3, 3.2)  | -2.7 (-6.6, 1.4)  | -7.9 (-12.8, -2.7)\* | -4.2 (-6.8, -1.7)\* |
| **nmol/mL** |                   |                   |                      |                     |
| 14:0        | 1.0 (-3.0, 5.3)   | 1.7 (-2.7, 6.4)   | -3.8 (-10.0, 2.9)    | -1.7 (-4.6, 1.4)    |
| 16:0        | -1.8 (-5.3, 1.9)  | -3.0 (-6.7, 1.0)  | -7.6 (-12.8, -2.1)   | -3.9 (-6.4, -1.4)\* |
| 18:0        | -0.3 (-3.8, 3.4)  | -1.5 (-5.4, 2.5)  | -3.8 (-9.1, 1.8)     | -1.9 (-4.7, 0.9)    |
| 20:0        | 2.2 (-2.1, 6.6)   | 1.8 (-3.1, 6.8)   | -1.0 (-7.3, 5.8)     | -0.2 (-3.4, 3.0)    |
| 22:0        | -1.7 (-5.6, 2.3)  | -2.9 (-6.8, 1.3)  | 0.6 (-4.0, 5.3)      | -0.9 (-3.2, 1.5)    |
| 18:1n-9     | -0.1 (-3.8, 3.7)  | -2.3 (-6.3, 1.9)  | -6.8 (-11.6, -1.7)   | -3.7 (-6.2, -1.2)\* |
| 20:1n-9     | 2.4 (-1.4, 6.3)   | 2.2 (-1.9, 6.6)   | -2.3 (-9.0, 5.0)     | -0.7 (-3.9, 2.6)    |
| 22:1n-9     | -3.2 (-6.4, 0.1)  | -2.9 (-6.5, 0.8)  | 1.2 (-3.8, 6.4)      | 0.2 (-2.4, 3.0)     |
| 24:1n-9     | 3.1 (0.0, 6.3)    | 2.2 (-1.5, 6.0)   | 1.9 (-3.0, 7.2)      | 0.1 (-2.3, 2.6)     |
| 14:1n-7     | 1.2 (-3.3, 5.9)   | 1.7 (-2.9, 6.6)   | -3.5 (-10.7, 4.2)    | -1.7 (-4.8, 1.5)    |
| 16:1n-7     | 1.9 (-2.1, 6.0)   | 1.6 (-2.5, 6.0)   | -5.4 (-11.3, 1.0)    | -2.5 (-5.3, 0.3)    |
| 18:1n-7     | 0.2 (-3.6, 4.1)   | -1.7 (-5.8, 2.7)  | -6.4 (-12.0, -0.6)   | -3.1 (-5.9, -0.2)   |
| 18:2n-6     | -1.2 (-4.9, 2.8)  | -3.2 (-7.2, 1.0)  | -8.0 (-12.7, -3.2)\* | -4.6 (-7.0, -2.0)\* |
| 18:3n-6     | -0.1 (-3.9, 3.8)  | -0.8 (-5.2, 3.7)  | -1.5 (-6.3, 3.6)     | -2.0 (-4.4, 0.5)    |
| 20:2n-6     | -0.1 (-3.5, 3.5)  | -2.3 (-6.2, 1.8)  | -5.5 (-11.2, 0.6)    | -2.9 (-5.8, 0.0)    |
| 20:3n-6     | 0.0 (-3.1, 3.3)   | -1.5 (-5.1, 2.3)  | -0.3 (-4.9, 4.5)     | -0.8 (-3.1, 1.6)    |
| 20:4n-6     | -0.5 (-4.0, 3.0)  | -2.9 (-6.8, 1.0)  | -1.8 (-8.7, 5.5)     | -0.8 (-4.4, 2.8)    |
| 22:4n-6     | -4.0 (-7.4, -0.5) | -4.6 (-8.4, -0.7) | 0.9 (-4.7, 6.8)      | -0.1 (-3.0, 2.8)    |
| 18:3n-3     | 0.2 (-3.4, 4.0)   | -2.2 (-6.1, 1.9)  | -6.2 (-10.9, -1.3)   | -3.7 (-6.3, -1.0)   |
| 20:5n-3     | 6.7 (2.4, 11.2)   | 3.6 (-1.0, 8.5)   | -0.6 (-6.4, 5.5)     | -1.4 (-3.9, 1.3)    |
| 22:5n-3     | -0.4 (-4.0, 3.3)  | -2.2 (-6.4, 2.2)  | -2.3 (-7.6, 3.4)     | -1.3 (-4.1, 1.6)    |
| 22:6n-3     | -0.9 (-4.0, 2.4)  | -3.7 (-7.6, 0.3)  | -0.6 (-4.7, 3.7)     | -1.1 (-3.2, 1.0)    |
| **mol%**    |                   |                   |                      |                     |
| 14:0        | 2.0 (-1.9, 6.2)   | 3.4 (-1.2, 8.1)   | -2.0 (-7.5, 3.9)     | -0.8 (-3.6, 2.1)    |
| 16:0        | -2.2 (-5.4, 1.1)  | -1.9 (-5.7, 2.0)  | -0.5 (-5.5, 4.8)     | -0.3 (-2.6, 2.0)    |
| 18:0        | 0.3 (-3.4, 4.3)   | 2.2 (-2.1, 6.8)   | 4.9 (-0.9, 11.1)     | 2.8 (0.0, 5.7)      |
| 20:0        | 2.8 (-1.5, 7.3)   | 3.9 (-1.0, 9.0)   | 3.0 (-2.7, 9.0)      | 1.9 (-0.7, 4.6)     |
| 22:0        | -1.8 (-5.4, 1.9)  | -2.0 (-5.7, 1.9)  | 1.6 (-2.9, 6.3)      | -0.2 (-2.5, 2.2)    |
| 18:1n-9     | 1.2 (-2.3, 4.9)   | -0.3 (-4.4, 3.9)  | -1.6 (-6.4, 3.5)     | -0.8 (-3.2, 1.7)    |
| 20:1n-9     | 2.5 (-1.2, 6.4)   | 3.1 (-1.3, 7.7)   | 0.0 (-6.2, 6.7)      | 0.5 (-2.7, 3.9)     |
| 22:1n-9     | -2.2 (-5.5, 1.1)  | -0.9 (-4.5, 2.8)  | 4.2 (-0.8, 9.5)      | 2.0 (-0.9, 5.0)     |
| 24:1n-9     | 4.4 (1.1, 7.8)    | 3.8 (-0.1, 7.8)   | 4.1 (-1.4, 9.9)      | 1.2 (-1.5, 4.1)     |
| 14:1n-7     | 2.1 (-2.6, 7.0)   | 2.8 (-2.2, 8.0)   | -2.2 (-8.5, 4.6)     | -1.2 (-4.2, 1.9)    |
| 16:1n-7     | 3.3 (-0.8, 7.4)   | 3.3 (-1.1, 7.9)   | -1.3 (-7.0, 4.9)     | -0.6 (-3.3, 2.1)    |
| 18:1n-7     | 1.1 (-2.9, 5.3)   | 1.2 (-3.4, 6.0)   | 0.2 (-5.4, 6.2)      | 1.0 (-1.8, 3.9)     |
| 18:2n-6     | -1.6 (-5.7, 2.6)  | -2.0 (-6.5, 2.7)  | -4.4 (-9.7, 1.1)     | -2.7 (-5.3, 0.0)    |
| 18:3n-6     | 0.6 (-3.1, 4.5)   | 0.6 (-3.6, 4.9)   | 2.1 (-3.0, 7.5)      | 0.0 (-3.0, 3.2)     |
| 20:2n-6     | 0.0 (-3.4, 3.5)   | -0.7 (-4.9, 3.7)  | -1.3 (-6.7, 4.4)     | -0.5 (-3.3, 2.3)    |
| 20:3n-6     | 1.7 (-1.6, 5.2)   | 0.9 (-3.0, 4.9)   | 2.6 (-2.4, 7.9)      | 0.9 (-1.7, 3.6)     |
| 20:4n-6     | -0.2 (-3.8, 3.6)  | -0.8 (-5.0, 3.6)  | 3.9 (-1.9, 10.1)     | 2.4 (-0.7, 5.5)     |
| 22:4n-6     | -4.0 (-7.3, -0.6) | -3.4 (-7.0, 0.2)  | 6.0 (0.6, 11.8)      | 2.4 (-0.4, 5.2)     |
| 18:3n-3     | 0.8 (-2.7, 4.4)   | -0.2 (-4.2, 3.9)  | -1.3 (-6.3, 4.0)     | -0.9 (-3.4, 1.8)    |
| 20:5n-3     | 7.7 (3.3, 12.3)\* | 5.3 (0.5, 10.3)   | 1.9 (-4.4, 8.6)      | 0.0 (-2.9, 3.0)     |
| 22:5n-3     | -0.6 (-3.7, 2.7)  | -0.5 (-4.6, 3.7)  | 0.7 (-5.0, 6.6)      | 0.5 (-2.4, 3.6)     |
| 22:6n-3     | -0.6 (-3.7, 2.6)  | -2.3 (-6.4, 1.9)  | 3.2 (-1.2, 7.8)      | 1.0 (-1.2, 3.3)     |

Table: ESM Table  4: Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort. GEE models were adjusted for time, sex, ethnicity, baseline age, WC, ALT, and family history of diabetes. Outcome variables were log-transformed, predictor variables were scaled, and x-axis values were exponentiated to represent percent difference per SD increase in the fatty acid.  P-values were adjusted for the BH false discovery rate, with significant (p<0.05) associations indicated by asterisk (*).

# ESM Figures



![ESM Fig.  1: CONSORT diagram of sample size at each examination visit for the main PROMISE cohort in addition of the sample size determination for the present analysis.](../img/flowDiagramSample.png)

![ESM Fig.  2: Directed acyclic graph taken from DAGitty (DAGitty.net) for the potential causal pathway between NEFA and ISI. Node and arrow description: Green with a triangle is the exposure; blue with a line/I is the outcome; empty blue is an ancestor of the outcome; empty green is an ancestor of the exposure; and empty red is an ancestor of both the outcome and the exposure; green arrow is on causal pathway; red arrow is a biasing pathway; black arrow is not along the pathway from the exposure to the outcome. DAGitty recommended a minimal adjustment of waist, sex, and MET (physical activity).](../img/dagitty-isi.png)

![ESM Fig.  3: Directed acyclic graph taken from DAGitty (DAGitty.net) for the potential causal pathway between NEFA and ISSI-2. Node and arrow description: Green with a triangle is the exposure; blue with a line/I is the outcome; empty blue is an ancestor of the outcome; empty green is an ancestor of the exposure; and empty red is an ancestor of both the outcome and the exposure; green arrow is on causal pathway; red arrow is a biasing pathway; black arrow is not along the pathway from the exposure to the outcome. DAGitty recommended a minimal adjustment of waist, ethnicity, and MET (physical activity).](../img/dagitty-issi2.png)

![ESM Fig.  4: Pearson correlation heatmap of non-esterified fatty acids (*nmol/mL*) and basic PROMISE participant characteristics for the baseline visit (2004-2006). Darkness of the colour indicates the magnitude of the correlation, with orange indicating positive and blue indicating negative correlations.](esm_files/figure-docx/ESM_Fig4-1.eps)

![ESM Fig.  5: Pearson correlation heatmap of non-esterified fatty acids (*mol%*) and basic PROMISE participant characteristics for the baseline visit (2004-2006). Darkness of the colour indicates the magnitude of the correlation, with orange indicating positive and blue indicating negative correlations.](esm_files/figure-docx/ESM_Fig5-1.eps)

![ESM Fig.  6: Longitudinal associations of individual non-esterified fatty acids (mol% and nmol/mL) with insulin sensitivity and beta-cell function over the 6 years in the PROMISE cohort. Generalized estimating equation models were fully adjusted, *excluding waist circumference*. X-axis values represent a percent difference in the outcome per SD increase in the fatty acid. P-values were adjusted for the BH false discovery rate, with each increase in dot size and blackness representing a p-value significance of p>0.05, p<0.05, p<0.01, and p<0.001.](esm_files/figure-docx/ESM_Fig6-1.eps)
