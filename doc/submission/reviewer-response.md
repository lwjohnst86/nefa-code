
# Responses to reviewers

## Referee: 1

First, I would like to congratulate you for the exhaustive and complete
research work that has been done for this paper. I think the statistical study
is very successful and useful for researchers who have accumulated a large
database and need a method with the ability to handle a large number of
variables and their interactions. I really liked read in the discussion the
negative points of the study, with which I fully agree, and not an attempt to
hide the limitations of any scientific work. In retrospect, perhaps it will miss
data that clarify the pre-diabetic state, or not, of the patients (HbA1c or
C-peptide). I think it would be good for the study know if some patients were
taking any medication that could affect the results. Although it is a
complicated scientific work to understand for researchers who do not usually use
this kind of statistical studies, I believe that is described in a very
appropriate and clear manner.

## Referee: 2

The present paper addresses an important and yet unresolved research question
regarding the role of non-esterified fatty acids on the trajectories of
metabolic traits of diabetes (insulin sensitivity and beta-cell function). The
analysis is based on a cohort study with repeated measures (up to 3 times per
individual) over 6 years of follow-up using generalized estimating equations
(GEE). This is a well-established method to analyse longitudinal data. The
authors in general did a thorough analysis however some major questions related
to methods and interpretation remains. After the trajectory analysis they run
partial least-squares discriminant analyses (PLS-DA) with groups defined by
beta-cell trajectories (latent class analysis) and defined by glycemic status as
outcomes. While the primary analysis is well-described and easy to follow, **these
additional analyses are described mostly in the online appendix and much harder
to interpret for the general reader. In my opinion, these do not add substantial
information to the paper and the conclusion, and I would move these to the
online appendix or drop them from the paper.** I think that the paper needs a
major revision however both the dataset and the study questions are adequate and
important thus conditional acceptance is reasonable.

1. Title of the paper: it is a statement of the results. I would prefer to leave
it open ended without an interpretation of the results, as with different levels
of adjustments the results and conclusion will change substantially. See also
comments on the results section.

2. Methods in the abstract:
    - Please give some information on the cohort characteristics:
        - age, sex
        - high risk of diabetes but no prevalent disease at baseline
    - incident diabetes cases (how were these handled? what about treated
    patients? – these should go in the main methods section)
    - adjustment for time – I would prefer to state that time since baseline was
    used as the underlying time variable instead of adjusting for time

3. Results in the abstract:
    - a major problem in my view with the interpretation of the results is that
    all characteristics are taken as confounders although a considerable
    proportion of time-varying covariates are taken after the NEFA measurements.
    Furthermore, it is not clear whether these measures are confounders,
    mediators or NEFAs are mediators of these variables. I think that unadjusted
    results are as interesting and require discussion as the fully adjusted and
    selected models. Regarding the abstract, I would show both the unadjusted
    and the fully adjusted results here.

4. Conclusions in abstract: I have a different interpretation of the results,
particularly because adjustment waist may be an over-adjustment.

5. INTRODUCTION
    - a clear and well-written introduction with a clear objective and
    hypothesis

6. MATERIALS & METHODS:
    - ESM Figure 1 is not clear to me.
        - Prevalent diabetes cases were excluded at baseline (n=XX)
        - the lines suggest that everyone had to have a year 6 visit, ehile in
        the main text, the authors state that any follow-up visit was enough for
        being included (this corresponds well with the GEE requirements).
        - what happened with incident diabetes cases? Were treated diabetes
        cases included in the analysis? How does that effect measures of insulin
        sensitivity and beta-cell function? I suggest to exclude those visits
        where diabetes was treated.
    - I would prefer to see the equations for the outcome measures. Why not use
    HOMA2-IS instead of 1/HOMA-IR?
    - In the statistical analysis you state that co-variates were
    time-dependent. This is not true for age at baseline, family history, sex,
    ethnicity. Please clarify in the text.
    - misspelling: “statistically significance”
    - I am not an expert of PLS-DA but it is not clear to me, why does this
    analysis reflect more the role of relative NEFA (mole%) analysis than the
    concentration analysis? As I can see, it depends on what variables you feed
    in the model.

7. RESULTS:
    - Please give ns in Table 1.
    - It would be also nice to see, how many participants had 1, 2 or 3 time
    points in the analysis.
    - How were the changes calculated (GEE?) in the basic characteristics of
    the PROMISE cohort section?
    - I suggest to include the unadjusted data to the main paper (ESM Figure 3)
    and describe these findings as we do not know the exact model where
    over-adjustment start to happen.
    - In a trajectory analysis, the interaction between time and the main
    predictor (NEFA in this case) is of major interest. The authors check for
    this interaction only as the last step of their model building (see ESM). I
    would suggest to perform this as the first step of the analysis (M0), and
    drop this term, if it is non-significant or does not improve model fit.
    Furthermore, given that this interaction was dropped from the model, it is
    hard to except the major conclusion that NEFA predicts progression of
    beat-cell dysfunction. Actually what is found here is that NEFA are related
    to beta-cell function in repeated cross-sectional analyses and NEFA related
    differences in beta-cell function remain constant over time.
    - The model building is based on literature data which is the right way to
    build the models but a more detailed discussion on over-adjustment is
    required before interpretation.
    - Latent classes. Although this is a very attractive method, based on ESM
    figure 4, there are 3 parallel declining group trajectories that is mostly
    affected by the baseline values. Groups based on baseline (last follow-up)
    tertiles would be easier to interpret.
    - The PLS-DA analysis needs further description. I would expect variables
    with the highest loadings to be the variables in the unadjusted GEE
    analysis. I am probably wrong given the results.
    - Do we really expect good discrimination? The associations are week to nul
    between NEFAs and the outcomes. I do not really see the point the extensive
    supplementary analysis on PLS-DA. Furthermore dysglycemia is an outcome that
    is not directly related to beta-cell function only. Dysglycemia requires
    both insulin resistance and beta-cell dysfunction.
    - The authors mention in the Discussion the external validity is mostly
    limited to white females. I suggest to run a sensitivity analysis on this
    group.

8. DISCUSSION
    - I would like to see more on the DAGs that underlies the selected
    variables in the models. That would either confirm the way the analysis is
    currently performed, or would show that some of the adjustments are
    over-adjustment.
    - In the time-varying analysis some covariates are measured after NEFAs,
    thus adjustment for them could be over-adjustment just because they are
    measured closer to the outcome of interest.

# Associate Editor

Many thanks for submitting this potentially interesting paper. The second
reviewer comes with some very helpful comments that will need to be addressed in
detail. There is need to consider the results from the Paris Prospective study:
Charles MA et al.  The role of non-esterified fatty acids in the deterioration
of glucose tolerance in Caucasian subjects: results of the Paris Prospective
Study. Diabetologia 1997;40:1101-6
