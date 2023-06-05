# Tune our ChefGPT

## Introduction

Now that we have a tuned model, let's test it.

Estimated Lab Time: -- 20 minutes

### Objectives

In this lab, you will:

* Load the tuned model
* Use several techniques to prompts the model for recipes
* Observe the results

## Task 1: Download the notebook & upload it to your notebook environment

* Download the following notebook: [6-try-chefgpt.ipynb](files/6-try-chefgpt.ipynb).
* Locate the notebook in your download folder and drag it to your notebook environment. Please make sure to navigate to the correct folder.
* Once the notebook has been uploaded, right click it on the left to open it in your environment. We've added comments to the cells to help you better understand the code.

![Drag and drop notebook](../6-try-untuned/images/drag-drop-notebook.gif)

## Task 3: Execute the code & observe the results

Please execute the cells in their order of appearance and observe the result.
After executing the fourth cell, you should see an output which looks a lot like a recipe.
The result is far from perfect but it is distinctly better than our initial experiments.
You may observe issues like the following:
![Select the right kernel](images/first-recipe-output.jpg)

Here, the unicode value for the "degrees" symbol shows as a hexadecimal number instead of the actual symbol.
Such issues are likely to occur in the absence of a "cleanup" step. This is part of the normal progressive process of fine-tuning our models and datasets. Using small datasets allows us to quickly observe training results, make sure we are on the right path, iterate and improve before we commit to training on large datasets which could require significant resources and time investments.
In the cleanup set, we could easily convert the degree symbol to F or C for better result.

Execute the `v3`, `v4` and `pipeline` variations and observe the difference to the output.
No version is going to be perfect at the moment as the LLM itself is small and so was out training dataset, but you can see how we can control the output using the available parameters.

At this point we could consider training our model on a larger dataset in order to improve the results. We could also consider using a large LLM.