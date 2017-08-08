


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
modeling, except it calculates the marginal population estimates compared to the
subject-specific estimates in mixed effects models. GEE is well suited to and
commonly used in longitudinal cohort studies, especially given its capacity to
handle missed visits. GEE is able to handle longitudinal data due to the
estimating of a working correlation matrix, which was chosen based on
quasi-likelihood information criteria (QIC). The auto-regressive of order 1
(AR1) matrix was chosen for the GEE models as it had the best model fit accessed
using QIC, though other matrices (eg. exchangeable) had similar fit (data not
shown).

For the covariates, they were chosen based on previous literature, from 
directed acyclic graph (DAG) recommendations, and from QIC. The DAG
recommendations were obtained from using the DAGitty software,
http://dagitty.net/. DAG is a technique that allows for identifying potential
confounding causal pathways and to limit potential bias introduced from
adjusting for colliding variables. A collider variable is a variable that is
determined from two or more other variables, such that in causal graph modeling,
the arrows from the other variables appear to 'collide' into the variable. QIC 
is a technique that balances the goodness of fit of the model with its relative
complexity (i.e. number of covariates) against other models being compared. This
identifies a specific model from a number of models that is the 'best' fit and
least complex of all the models. QIC and other information criterion methods are
used in conjunction with other techniques such as literature and DAG based. The 
final GEE model selected as best fitting was negligibly different when using 
insulin sensitivity or beta-cell function as an outcome and as such the same 
covariates were chosen for models with each of the outcomes. The covariates
medication use, WC, ALT, and MET would be considered classical confounders while
TAG would be considered a mediating variable.

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