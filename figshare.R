library(rfigshare)

# Steps to take:
# 1. make new orphan branch
# 2. keep only R files and purl(manuscript.Rmd)
# 3. git commit the files
# 4. git archive --format=zip --output=git-nefa-code.zip manuscript-code #(branch name)
# 5. then run the below code
id <- fs_new_article("Analysis code for study on non-esterified fatty acids and the pathogenesis of diabetes",
                     "R code used for the analysis in the NEFA manuscript.",
                     type = "fileset",
                     # there was a problem with the authors...
                     # authors = c("Luke Johnston", "Stewart Harris", "Ravi Retnakaran",
                     #             "Adria Giacca", "Zhen Liu", "Richard P. Bazinet",
                     #             "Anthony J. Hanley"),
                     tags = c("insulin sensitivity", "beta-cell function", "fatty acids",
                              "non-esterified fatty acids", "free fatty acids",
                              "cohort", "longitudinal"),
                     categories = c("Diseases", "Pathogenesis", "Epidemiology"),
                     #links = "link to github",
                     files = "git-nefa-code.zip",
                     visibility = "draft")
