---
output: fost::default_manuscript
---

# Responses to reviewers

## Referee: 1

- *"First, I would like to congratulate you for the exhaustive and complete
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
appropriate and clear manner."*

    We thank the reviewer for these comments. {{not sure about comment on
    pre-diabetes}}. In the PROMISE cohort, we collected medication data from
    all participants. While most participants took some form of medication over
    the 6 years, during the times of data collection, few ({{get number}}) were
    on medications. However, for those who were taking medications that could
    influence the results, sensitivity analyses revealed they did not
    substantially influence NEFA concentrations, the outcome measures, nor the
    GEE model results {{need to run/confirm this}}. These results have been
    appended to the ESM {{yes?}}.

## Referee: 2

- *"The present paper addresses an important and yet unresolved research question
regarding the role of non-esterified fatty acids on the trajectories of
metabolic traits of diabetes (insulin sensitivity and beta-cell function). The
analysis is based on a cohort study with repeated measures (up to 3 times per
individual) over 6 years of follow-up using generalized estimating equations
(GEE). This is a well-established method to analyse longitudinal data. The
authors in general did a thorough analysis however some major questions related
to methods and interpretation remains."*

    We appreciated the reviewer's positive comments and detailed suggestions. In
    the responses below we try to address each of the comments raised by the
    reviewer. 

- *"After the trajectory analysis they run partial least-squares discriminant
analyses (PLS-DA) with groups defined by beta-cell trajectories (latent class
analysis) and defined by glycemic status as outcomes. While the primary analysis
is well-described and easy to follow, **these additional analyses are described
mostly in the online appendix and much harder to interpret for the general
reader. In my opinion, these do not add substantial information to the paper and
the conclusion, and I would move these to the online appendix or drop them from
the paper.** I think that the paper needs a major revision however both the
dataset and the study questions are adequate and important thus conditional
acceptance is reasonable."*

    Given that GEE models do not take into account the high dimensionality of
    the NEFA composition data, we ran the PLS analyses in order to confirm the
    GEE results when using a multivariate approach. Use of the LCMM analysis
    allowed us to take include the longitudinal data in the PLS analysis.
    However, we agree with the reviewer that these analyses, while interesting
    in their confirmation of the GEE findings, do not contribute to the overall
    manuscript. In light of this reviewer's comments, we decided to move {{or
    drop?}} the analyses into the ESM, including the description of the methods
    and results.

1. *"Title of the paper: it is a statement of the results. I would prefer to leave
it open ended without an interpretation of the results, as with different levels
of adjustments the results and conclusion will change substantially. See also
comments on the results section."*

    As suggested, we've made the title results agnostic.

2. *"Methods in the abstract: a) Please give some information on the cohort
characteristics: age, sex, high risk of diabetes but no prevalent disease at
baseline; b) incident diabetes cases (how were these handled? what about treated
patients? - these should go in the main methods section); c) adjustment for time
– I would prefer to state that time since baseline was used as the underlying
time variable instead of adjusting for time"*

    We have made the requested changes to the methods and stated the exact
    analyses used more explicitly. Incident diabetes cases are presented only
    for descriptive purposes and were not included in any further analysis. We
    thank the reviewer for the suggestion and agree that using time since
    baseline is a better variable to adjust for; the time variable has been
    replaced in GEE models, though the change does not substantially impact the
    final results. {{confirm}}

3. *"Results in the abstract: a major problem in my view with the
interpretation of the results is that all characteristics are taken as
confounders although a considerable proportion of time-varying covariates are
taken after the NEFA measurements. Furthermore, it is not clear whether these
measures are confounders, mediators or NEFAs are mediators of these variables. I
think that unadjusted results are as interesting and require discussion as the
fully adjusted and selected models. Regarding the abstract, I would show both
the unadjusted and the fully adjusted results here."*

    The specifics of the covariates are expanded upon in the methods section. We
    have included the unadjusted results in the main manuscript and have 
    described it in the results and discussion sections, in addition to making
    the changes to the abstract.

4. *"Conclusions in abstract: I have a different interpretation of the results,
particularly because adjustment waist may be an over-adjustment."*

    We have included a sensitivity analysis identifying which exact covariate
    attenuates the results between the unadjusted and adjusted models. {{briefly
    describe the results here}}.

5. *"INTRODUCTION: a clear and well-written introduction with a clear objective
and hypothesis"*

6. *"MATERIALS & METHODS:"*
    - *"ESM Figure 1 is not clear to me: a) Prevalent diabetes cases were excluded
    at baseline (n=XX); b) the lines suggest that everyone had to have a year 6
    visit, ehile in the main text, the authors state that any follow-up visit
    was enough for being included (this corresponds well with the GEE
    requirements); c) what happened with incident diabetes cases? Were treated
    diabetes cases included in the analysis? How does that effect measures of
    insulin sensitivity and beta-cell function? I suggest to exclude those
    visits where diabetes was treated."*
    
        We have clarified how we dealt with incident diabetes cases. Briefly, we
        only report incident diabetes and dysglycemia cases in the text, but in
        the modeling these were excluded. {{not sure how to address a) and b)...}}
    
    - *"I would prefer to see the equations for the outcome measures. Why not use
    HOMA2-IS instead of 1/HOMA-IR?"*
    
        We have included the equations for the outcome measures as requested. In
        addition, we replaced HOMA-IR with HOMA2-%S from the HOMA2 Calculator.
        The results were not substantially different after the replacement of
        HOMA-IR. {{confirm}}
        
    - *"In the statistical analysis you state that co-variates were
    time-dependent. This is not true for age at baseline, family history, sex,
    ethnicity. Please clarify in the text."* ... *"misspelling: 'statistically
    significance'"*
    
        These have been corrected.
    
    - *"I am not an expert of PLS-DA but it is not clear to me, why does this
    analysis reflect more the role of relative NEFA (mole%) analysis than the
    concentration analysis? As I can see, it depends on what variables you feed
    in the model."*
    
        {{bit confused about this one. Will need to look into the wording in the
        manuscript.}}

7. *"RESULTS:"*
    - *"Please give ns in Table 1."* ... *"It would be also nice to see, how
    many participants had 1, 2 or 3 time points in the analysis."*
    
        These have been added as requested.
    
    - *"How were the changes calculated (GEE?) in the basic characteristics of
    the PROMISE cohort section?"*
    
        {{not completely sure what is meant here}} The changes over time as
        reported in the results of the outcome variables are simple median
        differences between the baseline and 6-year visit. The p-value {{confirm
        this is added}} representing the difference was computed using an
        unadjusted GEE model.
    
    - *"I suggest to include the unadjusted data to the main paper (ESM Figure 3)
    and describe these findings as we do not know the exact model where
    over-adjustment start to happen."*
    
        The unadjusted results and figure has been added to the main paper and
        described in the results section. We've also added a sensitivity
        analysis confirming which covariate(s) attenuates the associations.
    
    - *"In a trajectory analysis, the interaction between time and the main
    predictor (NEFA in this case) is of major interest. The authors check for
    this interaction only as the last step of their model building (see ESM). I
    would suggest to perform this as the first step of the analysis (M0), and
    drop this term, if it is non-significant or does not improve model fit.
    Furthermore, given that this interaction was dropped from the model, it is
    hard to except the major conclusion that NEFA predicts progression of
    beat-cell dysfunction. Actually what is found here is that NEFA are related
    to beta-cell function in repeated cross-sectional analyses and NEFA related
    differences in beta-cell function remain constant over time."*
    
        The reviewer makes an excellent point regarding the interaction check in
        model building. We have incorporated this change in the analysis and
        report on the results in the paper. In simple terms, the reviewer is
        correct that without an interaction term the model is essentially
        "repeated cross-sectional analyses", however, GEE handles the analysis
        in a slightly more nuanced approach. GEE calculates the estimates of the
        association of NEFA on the outcomes at any given time point, taking into
        consideration the inherent multivariate structure of the repeated
        measurements of the outcome variables. As such, inherent similarities in
        the outcome measurements over time within a subject are included in the
        computation of the GEE estimates. This nuance provides substantially
        more power to the model and the proceeding results.
    
    - *"The model building is based on literature data which is the right way to
    build the models but a more detailed discussion on over-adjustment is
    required before interpretation."*
    
        We have included further mention of potential over-adjustment to the
        paper. {{where would this go exactly? throughout the results and
        discussion?}}
    
    - *"Latent classes. Although this is a very attractive method, based on ESM
    figure 4, there are 3 parallel declining group trajectories that is mostly
    affected by the baseline values. Groups based on baseline (last follow-up)
    tertiles would be easier to interpret."* ... *"The PLS-DA analysis needs
    further description. I would expect variables with the highest loadings to
    be the variables in the unadjusted GEE analysis. I am probably wrong given
    the results."* ... *"Do we really expect good discrimination? The
    associations are week to nul between NEFAs and the outcomes. I do not really
    see the point the extensive supplementary analysis on PLS-DA. Furthermore
    dysglycemia is an outcome that is not directly related to beta-cell function
    only. Dysglycemia requires both insulin resistance and beta-cell
    dysfunction."*
    
        Given this reviewer's previous comments and suggestions, we have decided
        to focus on the GEE analysis in the main paper and move the PLS-DA to
        the ESM and expand on {{or remove? it seems this reviewer prefers if we
        remove it. I could simplify it by doing what I did in the TAG as a
        confirmation, and include it in the ESM}} it there.
    
    - *"The authors mention in the Discussion the external validity is mostly
    limited to white females. I suggest to run a sensitivity analysis on this
    group."*
    
        We agree with the reviewer's suggestion and ran additional sensitivity
        analyses stratified by sex and ethnicity. We mention the results of this
        analysis in the results.

8. *"DISCUSSION"*
    - *"I would like to see more on the DAGs that underlies the selected
    variables in the models. That would either confirm the way the analysis is
    currently performed, or would show that some of the adjustments are
    over-adjustment."*
    
        As requested, we have included the DAG underlying that hypothesized
        associations in the ESM.
    
    - *"In the time-varying analysis some covariates are measured after NEFAs,
    thus adjustment for them could be over-adjustment just because they are
    measured closer to the outcome of interest."*
    
        In order to confirm the impact the comment made by the reviewer has on
        the reported associations, we ran sensitivity analyses where we had all
        covariates as time-independent, to match the NEFA variables in the GEE
        model. We found {{state findings}}.

# Associate Editor

- *"Many thanks for submitting this potentially interesting paper. The second
reviewer comes with some very helpful comments that will need to be addressed in
detail. There is need to consider the results from the Paris Prospective study:
Charles MA et al.  The role of non-esterified fatty acids in the deterioration
of glucose tolerance in Caucasian subjects: results of the Paris Prospective
Study. Diabetologia 1997;40:1101-6"*

    {{do I need to include this?}} We thank the associate editor for the kind
    comments. We have included and discussed the cited paper in the discussion
    section.
