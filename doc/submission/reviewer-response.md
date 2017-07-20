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
    influence the results, additional analyses revealed that medication use did
    not substantially influence the predictor or outcome measures, nor did 
    medication use substantially contribute to GEE model fit compared to models 
    without it (see QIC table). 

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
is well-described and easy to follow, these additional analyses are described
mostly in the online appendix and much harder to interpret for the general
reader. In my opinion, these do not add substantial information to the paper and
the conclusion, and I would move these to the online appendix or drop them from
the paper. I think that the paper needs a major revision however both the
dataset and the study questions are adequate and important thus conditional
acceptance is reasonable."*

    We'd like to thank the reviewer for this suggestion. Given that GEE models
    do not take into account the high dimensionality (i.e. intercorrelation) of
    the NEFA composition data, we ran the PLS analyses in order to confirm the
    GEE results when using a multivariate approach. Use of the LCMM analysis
    allowed us to include the longitudinal data in the PLS analysis.
    However, we agree with the reviewer that these analyses, while interesting
    in their confirmation of the GEE findings, do not contribute substantially
    to the overall manuscript. In light of this reviewer's comments, we decided
    to drop these analyses from the paper to keep the overall message of the
    manuscript clearer and more focused.

1. *"Title of the paper: it is a statement of the results. I would prefer to leave
it open ended without an interpretation of the results, as with different levels
of adjustments the results and conclusion will change substantially. See also
comments on the results section."*

    As suggested, we've made the title agnostic.

2. *"Methods in the abstract: a) Please give some information on the cohort
characteristics: age, sex, high risk of diabetes but no prevalent disease at
baseline; b) incident diabetes cases (how were these handled? what about treated
patients? - these should go in the main methods section); c) adjustment for time
– I would prefer to state that time since baseline was used as the underlying
time variable instead of adjusting for time"*

    We have made as many of the requested changes to the methods as the reviewer
    suggested without going over the word limit. Incident diabetes cases are
    presented for descriptive purposes though were not included in any GEE
    analysis. We thank the reviewer for the suggestion regarding time adjustment
    and agree that using time since baseline is a better variable to adjust for
    in the GEE models; the time variable has been replaced in GEE models, though
    the change does not substantially impact the final results.

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
    described it in the results and discussion sections, in addition to briefly
    describing them in the abstract (keeping within the word limit).

4. *"Conclusions in abstract: I have a different interpretation of the results,
particularly because adjustment waist may be an over-adjustment."*

    We have included a sensitivity analysis identifying which exact covariate
    attenuates the results between the unadjusted and adjusted models; the
    covariate is waist circumference. While inclusion of this variable
    attenuates most of the associations, we believe that adjustment of this
    variable is necessary given that biologically NEFA come from the adipose
    tissue during fasting and hypothetically more adipose tissue would indicate
    higher NEFA. Since other aspects of adipose tissue (e.g. role in
    inflammation and appetite regulation) could also impact insulin sensitivity
    and beta-cell function, we believe it is an important confounder to adjust
    for. We have included in the conclusions a discussion on how adjustment of
    waist circumference influences the model and the interpretation.

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
        only report incident diabetes and dysglycemia cases in the text to
        describe the cohort, but in statistical analyses and modeling, these
        cases were excluded. Regarding a) within the main PROMISE cohort,
        prevalent diabetes cases were not excluded from the study as they
        continued to be followed; prevalent diabetes cases did not have fatty
        acids measured. For b) any participant is followed until they request to
        be removed from the study; some participants missed the 3-yr visit, but
        came in for the 6-yr visit. We have included wording within the results
        on the sample and percentage who attended at least two visits andLastly,
        c) because diabetes can effect the values of the OGTT-derived indices
        due to medication the patient is taking and due to diabetes itself
        impacting beta-cell function and insulin resistance, we excluded them
        from all analyses; often, these participants did not even complete an
        OGTT since it is discouraged that these patients consume that much
        glucose. To restate, diabetes cases were not included in GEE or other
        analyses.
    
    - *"I would prefer to see the equations for the outcome measures. Why not use
    HOMA2-IS instead of 1/HOMA-IR?"*
    
        Thank you for this suggestion. We have included the equations for the
        outcome measures as requested. In addition, we replaced HOMA-IR with
        HOMA2-%S from the HOMA2 Calculator. The results were not substantially
        different after the replacement of HOMA-IR.
        
    - *"In the statistical analysis you state that co-variates were
    time-dependent. This is not true for age at baseline, family history, sex,
    ethnicity. Please clarify in the text."* ... *"misspelling: 'statistically
    significance'"*
    
        Thanks for catching these issues. They have been corrected in the
        revised manuscript.
    
    - *"I am not an expert of PLS-DA but it is not clear to me, why does this
    analysis reflect more the role of relative NEFA (mole%) analysis than the
    concentration analysis? As I can see, it depends on what variables you feed
    in the model."*
    
        We are not entirely clear on the reviewer's comment. PLS extracts from
        high dimensional data (multiple predictor variables, i.e. the fatty
        acids) underlying correlations, constrained by a outcome variable (i.e.
        beta-cell function). In this context, because mol% data is by definition
        restricted to sums of 100% (all fatty acid values add up to 100%), the
        underlying correlations between fatty acids is dependent on the relative
        contributions those fatty acids have to the total and as such can
        reflect correlations of specific fatty acids or groups of fatty acids
        that increase or decrease in proportion together. The concentration data
        is not contrained by this inherent correlation and thus underlying groups 
        or clusters may not be identified using PLS.

7. *"RESULTS:"*
    - *"Please give ns in Table 1."* ... *"It would be also nice to see, how
    many participants had 1, 2 or 3 time points in the analysis."*
    
        These have been added as requested.
    
    - *"How were the changes calculated (GEE?) in the basic characteristics of
    the PROMISE cohort section?"*
    
        The changes over time as reported in the results of the outcome
        variables are simple median differences between the baseline and 6-year
        visit. The p-value representing the difference was computed using an
        unadjusted (time only) GEE model.
    
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
    
        The reviewer makes an excellent point regarding the importance of
        conducting an interaction check in the early stages of
        model building. We have incorporated this new approach in the analysis and
        report on the results in the paper. In simple terms, the reviewer is
        correct that without an interaction term the model is essentially
        "repeated cross-sectional analyses", however, GEE handles the analysis
        in a slightly more nuanced approach. GEE calculates the estimates of the
        association of NEFA on the outcomes at any given time point, taking into
        consideration the inherent multivariate structure of the repeated
        measurements of the outcome variables. As such, inherent similarities in
        the outcome measurements over time within a subject are included in the
        computation of the GEE estimates. This nuance provides substantially
        more power to the model and the proceeding results. See ref {{num}} in
        the manuscript for more detail on this statistical technique. Within
        the manuscript we have expanded on this nuance to clarify the interpretation.
    
    - *"The model building is based on literature data which is the right way to
    build the models but a more detailed discussion on over-adjustment is
    required before interpretation."*
    
        To clarify, the model building processes used two additional techniques:
        quasi-likelihood information criteria (QIC) and directed acyclic graphs.
        The results and output of these techniques can be found in the ESM.
        Combining all of these processes in building the model ensures that
        adjustment is empirically based and reduces (but not eliminates) the
        potential for over-adjustment. However, we have added additional
        sensitivity analyses to identify covariates that strongly influence the
        results and discuss the results in light of these findings.
    
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
        to: focus on the GEE analysis in the main paper; remove the LCMM
        analysis; perform the PLS analysis on the baseline (cross-sectional)
        data using the outcomes as continuous variables; and, briefly describe
        the findings in the Results section. To keep the ESM material
        streamlined, we have contained the PLS results and other additional
        analyses conducted within the code (accessible via the DOI) for the
        interested reader. We believe this simplifies the results and primary
        findings of this paper without sacrificing a loss in the potential use
        these additional analyses may provide for the interested researcher.
    
    - *"The authors mention in the Discussion the external validity is mostly
    limited to white females. I suggest to run a sensitivity analysis on this
    group."*
    
        We agree with the reviewer's comment and ran stratified models by either
        sex or ethnicity. In both cases, all significant associations from the
        non-stratified analyses were attenuated, likely due to the reduction in
        sample size in the stratified models. Stratifying analyses has the
        limitation of substantially reducing sample size and is the reason why
        interaction testing is prefered. We ran interaction tests by sex and
        ethnicity and found no significant interactive associations. While
        these results internally suggest no differences between sex or ethnicity,
        our cohort was not designed to answer these research questions and the
        results presented in the paper may still not be generalizable to other
        populations. {{yea?}}

8. *"DISCUSSION"*
    - *"I would like to see more on the DAGs that underlies the selected
    variables in the models. That would either confirm the way the analysis is
    currently performed, or would show that some of the adjustments are
    over-adjustment."*
    
        As requested, we have included the DAGs underlying the hypothesized
        associations in the ESM.
    
    - *"In the time-varying analysis some covariates are measured after NEFAs,
    thus adjustment for them could be over-adjustment just because they are
    measured closer to the outcome of interest."*
    
        In order to confirm the impact the comment made by the reviewer has on
        the reported associations, we ran sensitivity analyses where we had all
        covariates as time-independent, to match the NEFA variables in the GEE
        model. We found that there were negligible differences in the results
        between models with covariates as either time-dependent and
        time-independent and models with all covariates as time-independent.

# Associate Editor

- *"Many thanks for submitting this potentially interesting paper. The second
reviewer comes with some very helpful comments that will need to be addressed in
detail. There is need to consider the results from the Paris Prospective study:
Charles MA et al.  The role of non-esterified fatty acids in the deterioration
of glucose tolerance in Caucasian subjects: results of the Paris Prospective
Study. Diabetologia 1997;40:1101-6"*

    We thank the associate editor for the kind comments. We have included the
    cited paper in the discussion section.
