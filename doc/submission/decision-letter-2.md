
22-Sep-2017

Dear Dr Hanley:

Diab-17-1242
Association of non-esterified fatty acid composition with insulin sensitivity and beta-cell dysfunction in the Prospective Metabolism and Islet Cell Evaluation (PROMISE) cohort

Many thanks for resubmitting this manuscript to Diabetologia. Firstly, my apologies that it has taken us so long to reach a decision. However, your paper has now been reviewed by three experts in the field, an expert statistician and by one of our Associate Editors. Their comments are given below. You will see that our referees were interested in your study, but you will also see that they have identified a number of important concerns that you would need to address before we could give your manuscript further consideration.

In the light of all this I would like to offer you the opportunity to submit a revised version of your paper that takes account of all these points. I would ask you to highlight in colour all changes and new material in your paper – please ensure that your changes will be clear if referees print your manuscript in black and white. Do not show deletions or use the ‘track changes’ function of Word. We request that you also include a detailed response to the referees’ comments in your covering letter. In addition, please make the changes suggested by our editorial staff to bring your manuscript into line with house style – this will speed subsequent processing of your paper if it is accepted.

Please submit an electronic version of your revised paper within 28 days of receipt of this letter (see attached instructions). If new experiments have been requested which will be impossible to complete within this time we will consider an appeal to extend this deadline. Please contact the Editorial Office (diabetologia-j@bristol.ac.uk) if you have any queries.

As I am sure you will appreciate, I am unable at this stage to make any commitment regarding eventual acceptance of this manuscript, which will be seen again by our referees in the light of your response.

Yours sincerely,


Sally Marshall
Editor, Diabetologia
www.diabetologia-journal.org

Comments to the Author

Referee: 1
This paper presents an investigation of the relationship between NEFAs measured at baseline and subsequent development of markers of insulin sensitivity. The analysis is very thorough and the conclusions, in particular the interpretation of results with biological considerations is excellent. I am not an expert on this subject area and although I am a statistician, GEE is not an approach that I am familiar with, so my comments are from the perspective of a technically-minded but non-expert reader. Therefore some of my comments may not be wholly relevant and are given more as possible considerations; or areas that may require clarification for other non-experts.

A key question for me is the choice of using the GEE approach, which is of course an established and appropriate method for many research questions, but I think could be better justified here. The main advantages I am aware of are:

- Richer correlation structures
- Easily handles missing data
- Robust standard errors

Here, the number of follow up visits is not large and the amount of missing data is relatively small. My first thought when approaching the analysis would therefore be to consider a standard linear regression analysis with robust/clustered standard errors to incorporate repeated measures, and potential multiple imputation of missing values and a comparison with complete case analysis. So it would be nice to briefly spell out the things that GEE offers here over other approaches to make this clear (in the ESM if need be so as not to add to the word count). Currently the main statement is the ease of handling missing data – which is handy but perhaps not essential – and some comments on the working correlation matrix, which are not terribly informative. So some statements about the improvement in estimates under a specific correlation structure that is not easily handled otherwise, for instance, might be helpful. Of note is that in the ESM it is stated that “other … matrices had similar fit” – it may be worth noting that the model fit may be similar, but estimates may be more efficient under a particular correlation structure.

Another thing that might be commented on briefly is the different nature of estimates from GEE models, which are population averaged and have a slightly different interpretation. This difference might be seen as a disadvantage to GEE modelling – or do the authors feel this is more appropriate for this particular question? This is something I do not have a thorough understanding of, but I do note that the authors comment in the methods “…the interpretation of the GEE results is as an expected percent difference in the outcome variable for every standard deviation (SD) increase in the predictor variable given the covariates are held constant” does not appear to be consistent with what I have read in terms of keeping other factors constant, e.g.: “However, because the GEE approach does not contain explicit terms for the between-cluster variation, the resulting parameter estimates for the contrast of interest do not have the usual “keeping other factors constant” interpretation.” (Hanley et al, Am J Epidemiol 2003;157:364–375).

Another area that is unclear is the exact model specification. The unadjusted results I can assume are the outcome variables regressed via GEE against each NEFA measure. Then adjusted results include age, gender, WC and so on. Now, for the proportion of NEFA results, the approach seems to be that adjusted models were fitted with each NEFA as a predictor in turn while adjusting for the anthropomorphic and other covariates, as a PLS approach was used to examine all the NEFA components together as proportions. Was this approach the same for the analysis of NEFA as a concentration, or in this analysis were all NEFA components included in a single multivariable model? I think that this should be spelled out: if each NEFA component was considered in turn, and the variables adjusted for, for the concentration/proportion analysis. At present the assumption might be that multivariable models include all of the NEFA components in one model.

If so, I do not fully understand why there is not a model that includes the joint effect of all NEFA components together. Could this not be done for the concentration analysis? Also, it could perhaps be done for the proportion too, if one of the components is set as the baseline – similar to how categorical variables are handled in regression analyses, but allowing percentages for each indicator rather than the usual 0/1 dichotomy, vs. a “baseline” component. Such an analysis could also adjust for total NEFA, with the interpretation that proportion of each NEFA component is assessed while accounting for other NEFA components, and also the total NEFA. This is also something I struggled to understand a little in general – why should *proportions* of NEFA components be important? There may be a relatively high proportion of a particular NEFA but if the patient has a generally low overall NEFA, is there any reason to think a relatively high proportion of something will increase insulin sensitivity? These ideas may be wholly implausible of course and I may have missed the point – as I said my background knowledge of the biology is not ideal.

I do also wonder somewhat whether there may be over-adjustment with some of the covariates included, and agree with another reviewer who pointed out the importance of the unadjusted results. A potential issue is confounders that may be on the causal pathway, which is a judgement that must be based on expert knowledge. The authors note for instance that adjusting for WC improved the fit of the model, and was indicated for inclusion by the DAG. Neither in my mind is reason alone for its inclusion, and there is no guarantee on this basis that adjustment for this is necessarily appropriate – this must be based on subject-specific knowledge of whether adjustment is appropriate to determine the independent effect of the variable of interest.

Which brings me to the DAGs. “Directed acyclic graphs” just means a collection of boxes representing different bits of information with arrows between them that do not form loops; DAGs are used in Bayesian analysis for instance to represent how data and parameters in a model are linked. A DAG therefore is a representation for how information in linked, not a process to in itself to determine appropriate model building or make a “recommendation”. I think that if the approach employed is to be used as justification of the model building process, it needs to be better described: presumably there is some algorithm being used that determines interrelationships of variables in the data, of which I would like to see at least a brief outline – a link to a website is not really sufficient here. Further, the graphs provided give no indication of what the different arrows and colours are.

Last of all, the analysis excluded diabetes cases, which is justified. However, could incident cases be included with follow up time included to the last visit prior to developing diabetes? This may not be so straightforward in practice of course. It’s not really clear if any of any pre-incident follow up time is included at present, or if all data on incident cases is discarded “incident diabetes cases were excluded from further GEE analysis” – does the “further” bit mean post-incidence here?

MINOR COMMENTS

Abstract and elsewhere: OGTT not spelled out, even if this is obvious to most readers.

List of abbreviations: if this is to be an exhaustive list many are not given, OGTT, HOMA, NEFA…

QIC – presumably this is quite like the AIC and other information criteria – maybe mention this, and how the calculation differs? Is the QIC specifically for GEE models? Also in the ESM: “This identifies a specific model from a number of models that is the 'best' fit and least complex of all the models” – it can’t be the best fit AND least complex, as mentioned in the previous sentence it’s a trade-off – so maybe omit this sentence.

ESM – collider variables. As mentioned in main comments this is all a bit vague – “arrows appearing to collide” and so on doesn’t really convey what is going on here. This is a technical description so please be a little more precise!


Referee: 2
In this manuscript, the authors investigated the link between total and several fractions of serum NEFA and the clinical indexes of insulin secretion and sensitivity by using GEE model in a diabetes risk group over 6-years longitudinal follow-up.

General comments:
Overall, this study is interesting and novel to show the long-term exposures to some specific NEFA fractions are negatively associated with mainly beta-cell function in human, which convincingly confirms and advances the previous basic and clinical studies in this field.  

1.	Serum insulin and/or NEFA levels could be affected by several factors: I would suggest excluding the participants who have endocrine, hepatic or renal disorders. Also, I suggest mentioning the detail of medications, which could affect insulin/glucose/NEFA measurement; page 24, line 7, “Medication use did not influence NEFA composition, the outcomes, or the GEE models (data not shown)” is not clear enough.
2.	Glucose clamp test is the standard to evaluate insulin sensitivity instead of the indexes used in this study. I know it is very hard to perform it in a large number of participants, but it may be one of the reasons why the effect of NEFAs on insulin sensitivity was limited. I would suggest discussing the limitation of these indexes.
3.	Most of the indexes in this study are based on glucose and insulin levels. I think the reader would know the data of baseline and follow-up glucose and insulin levels as well as indexes (in Table 1).
4.	I understand several NEFA fractions are statistically related to indexes of beta-cell function; however, does each individual show the same trend? For example, the graph which shows NEFA concentrations and the individual decline ratio of beta-cell function over 6-years (value of slope, if compatible) may convince the reader more, at least for the representative NEFA fractions. 
5.	Referring previous longitudinal studies showing the link between NEFA level and beta cell deterioration, even which were investigated in the diabetic patients, could confirm the results of this study. 


Referee: 3
The authors addressed all major concerns related to the manuscript. I feel that the paper improved by the changes and became more focused by omitting the PLS-DA analysis. By adding a detailed explanation to the discussion on the potential importance of potential confounders and mediators, the interpretation of the findings became much clearer.

Some minor comments regarding the wording of the conclusions and missing information on the DAGs  remain but I only have the following comments:

Minor comments
1.	Introduction: 
„Therefore, our objective was to examine the association of serum NEFA composition on changes over time in insulin sensitivity and beta-cell function in a longitudinal cohort. We hypothesized that higher palmitic acid and lower PUFA such as eicosapentaenoic acid in the NEFA fraction would associate with declining insulin sensitivity and beta-cell function over 6 years.” 
I would prefer to use the word differences instead of changes, as the main focus of the paper is not on the time interaction but on the main effects.
2.	Conclusions:
“In a Canadian population of adults who were at-risk for diabetes, we found that higher total NEFA concentrations independently predicted lower beta-cell function after 6 years.”
I would prefer to use over 6 years instead of after 6 years, as the difference was present from the measurement point to the end of follow-up.
3.	Please add the number of observations for each clinic visit in Table 1.
4.	Please add the number of incident and prevalent diabetes cases to the respective exclusions in ESM Figure 1. For example: n=736 had baseline data collected, n=XX diabetes cases were excluded; n=619 had 3-year data, n=XX incident diabetes cases were excluded…
5.	Please add the colour codes for DAGs (i.e.: exposure, outcome, ancestor of exposure, ancestor of outcome, ancestor of both, causal path, biasing path).


Referee: 4
This is an interesting analysis on NEFA ,insulin sensitivity and beta cell function.

My major concern is that with the current approach the complexity of metabolic regulation may be lost to some extent. This makes it hard to interpret these findings with respect to biological significance:

- with respect to peripheral insulin sensitivity (referred to in the discussion) the effects of saturated fatty acids may strongly depend on metabolic phenotype, ie more pronounced in insulin resistant subjects, was initial metabolic phenotype taken into account in the present analysis?
-it is a pity that the analysis of fatty acids composition in phospholipids and serum cholesteryl esters have been published in a separate paper, altogether this would add very much to the total interpretation.
- some discussion on what determines plasma fatty acid profile may be useful, beside spillover also (selective) release by endogenous lipolysis. To what extent does it reflect dietary composition, was habitual fat intake taken into account?

Altogether, this paper would gain strength by addressing the limitations in interpretation in more detail.


Associate Editor
The reviewers provide numerous minor and major comments, for example regarding motivation of the statistical approach, which require revision or careful response.


Essential journal requirements

Author signed statement:
Please arrange for all authors to sign the attached author statement and conflict of interest declaration. Please note that every author needs to sign a separate form (i.e. there should be one form per author) and that we can only accept handwritten (not typed) signatures. Once you have the signatures of all your coauthors please either (1) upload a single (merged) pdf or zipped file onto ScholarOne with your amended paper; or (2) return the forms to the Editorial Office by fax [+44 (0)8450582542] or email. Please ensure that your manuscript number is clearly marked on the form. 

Format
Please supply text and tables in a single Word document (please do not provide tables in a separate document). Figures should be provided in separate files and not pasted into the main text, figure legends (but not ESM figure legends) at the end of the main text, after the references.

Word count: 
Please ensure that your revised article does not exceed our permitted word counts: 
Original articles - 4000 words in the main text and up to 50 references (please note that figure legends were previously included in the word count but, as of 23rd February 2017, they will be excluded).

Affiliations: 
Please use superscript numerals, in ascending order, to indicate author affiliations

Corresponding author
Please ensure that the full postal address (including street address and postal code) and an email address are given.

Abstract
Please consider including numerical data in your abstract to support the main findings of your paper. (Our word limit for abstracts is flexible.)

If data have been deposited in a public repository authors should include the dataset name and repository name and number at the end of the abstract.

Keywords: 
Please be aware that some databases e.g. PubMed and Medline will search only on words found in the title or abstract and not on author-assigned keywords. You may therefore wish to ensure that all keywords also appear in the title or abstract. Please list keywords in alphabetical order.

Abbreviations: 
Please list and define all abbreviations in alphabetical order of the abbreviation.
To improve readability please do not abbreviate the term ‘insulin sensitivity’

References in the text: 
Please check that references are cited in numerical order in the text

Spelling: 
Please note that British English (not American) spellings should be adopted throughout, including in the figures (e.g. labelled, not labeled; glycaemia not glycemia)

Materials and Methods
Sufficient information should be given to allow a knowledgeable reader to understand what was done, and how, and to assess the biological relevance of the study and the reliability and validity of the findings.

Materials: 
Please ensure that the name, city, state (for USA, Canada, Australia) and country are given for every manufacturer/supplier on first mention

SI Units: 
All units in the text, tables, figures and ESM should be SI only. Please pay particular attention to plasma insulin (pmol/l) and blood glucose (mmol/l). Please redraw figures (including any ESM  figures) to include SI values.
NB An exception is made for administered doses of insulin, which can be given in U.
Please use ‘mol/l’ not ‘ M’ in all text, tables and figures

House style:
Please note that house style is to use a lowercase ‘l’ for litre Please note that house style is to use the term beta cell not beta-cell

URLs: please give the date of access for all websites in the paper in the format www.xxx accessed 1 January 2012

Acknowledgements
Please name all individuals who were associated with the manuscript or study but who do not qualify for authorship, reporting their brief affiliation (department, institute, country) and contribution. If an agency, company or individual was involved in the preparation/writing of the manuscript please give details. If the list of people to be acknowledged is long (e.g. members of a study group) this will be published as supplementary material.
Please give names in the format of initials + surname, followed by a brief affiliation (department, institute, country)

Funding
Please check with your coauthors that all funding sources have been acknowledged, and that all relevant grant numbers are included. Please note that certain funding agencies have specific requirements regarding the acknowledgement of funding.  

Duality of interest
Authors are responsible for recognising and disclosing conflicts of interest that might bias their work. They should acknowledge in the manuscript all financial support for the work and other personal connections.
If there is no duality of interest please insert the following statement: ‘The authors declare that there is no duality of interest associated with this manuscript.’

Contribution statement
The ICMJE uniform requirements for manuscripts submitted to medical journals state that authorship credit should be based on
(1) substantial contributions to conception and design, acquisition of data, or analysis and interpretation of data;
(2) drafting the article or revising it critically for important intellectual content; and (3) final approval of the version to be published. 

Please update your contribution statement as all the persons listed as authors must fulfil all three criteria. Participation solely in the acquisition of funding, collection of data, or general supervision of the research group alone does not constitute authorship. Please use the wording specified by the ICMJE, where possible. If you have to remove someone from the author list because they do not meet all three conditions, please provide written confirmation that this person is aware that they have been removed.

Guarantor
In accordance with the Recommendations for the Conduct, Reporting, Editing, and Publication of Scholarly Work in Medical Journals (ICMJE Recommendations 2013; http://www.icmje.org/recommendations/), Diabetologia now identifies who is responsible for the integrity of the work as a whole. The guarantor accepts full responsibility for the work and/or the conduct of the study, had access to the data, and controlled the decision to publish. Please identify the author(s) who is guarantor of this paper by stating at the end of your Contribution Statement e.g. 'XX is responsible for the integrity of the work as a whole' or 'XX is the guarantor of this work'.

Research data policy
Diabetologia strongly encourages authors to make available to readers all datasets on which the conclusions of the paper rely, preferably by depositing datasets in publicly available repositories or as part of the supplementary material (see http://www.diabetologia-journal.org/instructionstoauthors.html#datapolicy). Persistent identifiers (such as DOIs and accession numbers) for relevant datasets must be provided in the paper. Datasets that are assigned digital object identifiers (DOIs) by a data repository may be cited in the reference list. Data citations should include: authors, year, title, repository name, identifier.

Data availability
Please include a statement of data availability. This should include information on where data supporting the results reported in the article can be found (including, where applicable, hyperlinks to publicly archived datasets analysed or generated during the study), or whether the data are available on request from the authors or if no data are available. For examples of data availability statements, including examples of openly available and restricted access datasets, see http://www.springernature.com/gp/group/data-policy/data-availability-statements

Text recycling
Your paper has been run through software to check for similarities with previously published articles. No significant overlap was detected, and no action is required on your part.

References: 
If page numbers are known, please do not include the doi.

Citations to Abstracts: 
Citations are only permissible to abstracts published in the current year or preceding year. Please update, replace or delete references to abstracts dated 2015 or earlier.

Figures and Tables
Please ensure that figures and tables are cited in numerical order in the text.

Tables
Check in Table properties (not individual cells) that text wrapping is switched off

Image forensics
In line with journal policy, images in potentially acceptable papers will be screened using image editing software and investigative techniques to check for manipulation. Please see http://www.diabetologia-journal.org/instructionstoauthors.html#manipulation for Diabetologia’s policy regarding image manipulation. 

Figures:
Please use Ariel or Helvetica font
Please increase font size of labels so that they will be legible even after the image is reduced for publication.
Try to use a consistent font size for different figure parts so that the figure will look balanced on the page in the print version Please ensure that the font size of the x- and y-axis labels is consistent Please decrease the weight of the axis lines and bar outlines (we find that ¾ or 0.75 point works well) Please use lower case ‘l’ to litre Please use the abbreviation ‘NEFA’
Please use lower case, italic p for p values

Fig. 2/3: Please move titles under x-axis, adding a horizontal line to show corresponding data

Fig. 3: Please move units to outside of the y-axis and rotate so they read vertically (as the y-axis label). 

Figure format
If your figures were created (not imported or resaved) in Excel, PowerPoint, SigmaPlot or Adobe Illustrator please send these files. Alternatively please send eps vector files. If this is not possible, please supply TIF files saved at a resolution of 1200 dpi for black and white graphs and 600 dpi for other (greyscale or colour) graphs, composite images (mixture of line graphs and halftones) or halftones (gels and micrographs). If the files are too large to send by email please ask us for a link to enable you to upload them directly to our server.

Electronic supplementary material (ESM)
Please supply your ESM as a single pdf file, with parts arranged in this order:
ESM text (methods and results), tables, figures Please ensure that the ESM tables and figures are cited in order in the main text (i.e. ESM Table 1 should be cited before ESM Table 2, but call outs to ESM tables can be interspersed with call outs to ESM methods and/or ESM figures.) ESM will not undergo any copyediting and will be published online exactly as supplied by the author so please do not include highlighting.
