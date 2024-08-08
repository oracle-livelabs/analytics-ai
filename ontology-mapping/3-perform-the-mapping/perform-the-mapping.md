# Perform the mapping

## Introduction

This lab will walk you through the process of leveraging the generative AI model to perform mapping of radiology protocol names to a standardized lexicon.

Estimated Time: 15 minutes

### Objectives

In this lab, you will:

* Create the necessary prompt that includes instructions for the model, the lexicon terms, and term to be mapped to the lexicon.
* Receive and evaluate a response from the model.
* Further test the model using variants that are in another language.
* Provide your own variant to be mapped or evaluated.
* Explore the performance of other models.

### Prerequisites

This lab assumes you have:

* An Oracle Cloud account
* All previous labs successfully completed

## Task 1: Create the prompt

1. There are three components to the prompt we will be creating: the model instructions, data containing the lexicon terms, and data containing the terms to be mapped.  

1. Copy and paste the following instructions into the chat window, but **DO NOT** press **Submit** yet.
    >For these radiology procedure names, Return a table of row #,STUDY_DESCRIPTION, best semantically matching LONG_COMMON_NAME (blank if no match), and CONFIDENCE (low, medium, high) of the match, CODE, RAND_ID,  whether RAND_ID equals CODE.  Also give the # of processed STUDY_DESCRIPTIONs and # of LONG_COMMON_NAMEs, and # of matches.
    
    "CODE","LONG_COMMON_NAME","13","CT cervical and thoracic spine with IV contrast","30","CT cystography with bladder contrast","44","CT thoracic spine with IV contrast","12","CT cervical and thoracic spine without IV contrast","43","CT thoracic spine without IV contrast","49","CT low dose lung cancer screening without IV contrast","41","CT whole body","4","CT chest and abdomen and pelvis without IV contrast","1","CT abdomen and pelvis with IV contrast","34","CT maxillofacial without IV contrast","42","CT cardiac for calcium scoring","10","CT cervical spine without IV contrast","3","CT abdomen without and with contrast","19","CTA head and neck with IV contrast","37","CT virtual bronchoscopy","18","CT lumbosacral spine without and with IV contrast.","24","CT colonography","16","CT lumbar spine with IV contrast","9","CT chest without IV contrast","32","CT sacrum without IV contrast","21","CTA head with IV contrast","28","CT paransal sinuses with IV contrast","11","CT cervical spine with IV contrast","35","CT upper extremity with IV contrast","22","CTA lower extremity with IV contrast","23","CT abdomen with IV contrast multiphase","6","CT head","39","CTA renal arteries with IV contrast","15","CT lumbar spine without and with IV contrast","8","CT chest with IV contrast","46","CT pelvis with IV contrast","14","CT lumbar spine without IV contrast","17","CT lumbosacral spine with IV contrast","25","CT high resolution chest without IV contrast","48","CT wrist without IV contrast","40","CTA abdominal aorta","50","CT kidneys ureter bladder without IV contrast","45","CT pelvis without IV contrast","20","CTA coronary arteries with IV contrast","5","CT chest and abdomen and pelvis with IV contrast","33","CT maxillofacial with IV contrast","26","CT orbits without IV contrast","47","CT soft tissue neck without IV contrast","7","CT head with IV contrast","29","CT paransal sinuses without IV contrast","31","CT sacrum with IV contrast","2","CT abdomen without IV contrast","38","CTA brain with IV contrast","36","CT upper extremity without IV contrast","27","CT orbits without and with IV contrast"
    "RAND_ID","STUDY_DESCRIPTION_1","20","CTA Coronaries w/ IV contrast","5","CT Thorax Abd Pelvis w/ IV contrast","34","CT Maxfac wo IV contrast","23","CT Abd w/ IV contrast multiphase","25","CT HR Chest wo contrast","11","CT C-spine w/ IV contrast","12","CT C/T-spine wo contrast","16","CT L-spine w/ IV contrast","30","CT Cystogram w/ bladder contrast","14","CT L-spine wo contrast","19","CTA Head/Neck w/ IV contrast","36","CT left arm w/o","10","CT C-spine wo contrast","18","CT LS-spine w/wo IV contrast","21","CTA Head w/ IV contrast","43","Thoracic Spine CT -C","45","Pelvis CT -C","8","CT Thorax w/ contrast","48","Wrist CT -C","32","CT Sacrum wo IV contrast","39","Renal CTA +C","27","CT Orbits w/wo IV contrast","2","CT Abd w/o contrast","26","CT Orbits wo contrast","35","CT right arm w/con","22","CTA LE w/ IV contrast","33","CT Maxfac w/ IV contrast","49","Low Dose Lung CT -C","41","Total Body CT","7","CT Head w/ IV contrast","37","Virtual Bronch","31","CT Sacrum w/ IV contrast","6","CT Head wo contrast","1","CT Abd/Pelvis w/ contrast","47","Neck CT -C","15","CT L-spine w/wo IV contrast","4","CT Thorax/Abd/Pelvis wo contrast","50","KUB CT -C","46","Pelvis CT +C","29","CT Sinuses wo IV contrast","24","CT Colongraphy","9","CT Thorax wo contrast","40","Abd Aorta CTA","13","CT C/T-spine w/ IV contrast","28","CT Sinuses w/ IV contrast","38","Brain CTA +C","42","Cardiac CT Calcium Score","3","CT Abd w/wo contrast","44","Thoracic Spine CT +C","17","CT LS-spine w/ IV contrast"



## Acknowledgements

* **Author** - David Miller, Senior Principal Product Manager, Yanir Shahak, Senior Principal Software Engineer
