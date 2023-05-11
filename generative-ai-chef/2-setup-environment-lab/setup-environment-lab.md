# Create a Twitter Developer Account

## Introduction

To proceed with the lab you would need Oracle Cloud account and access to the Oracle Cloud Infrastructure Data Science and AI Services.

Estimated time - 5 minutes

### Objectives

1. Install and activate the required Conda environment
2. Install dependencies
3. Create project folder

### Prerequisites

## Task 1: Install and activate required Conda environment

- Step 1

Once your notebook is open select `File -> New Launcher` ...

![file-new-launcher](images/nb-new-launcher.png)

or click on the Plus `+` icon.

![launcher-plus-icon](images/nb-new-launcher-plus-icon.png)

This would open he Launcher which looks like this:

![nb-launcher](images/nb-launcher.png)

- Step 2

Open the `Environment Explorer` by clicking on the Extensions Icon

![env-explorer](images/nb-env-explorer.png)

- Step 3

In the Environment Explorer filter under `Conda Environments` select `Data Science` and under `Architecture` select `GPU`:

![env-explorer-filter](images/nb-env-ex-filter.png)

- Step 4

Open the `PyTorch 1.10 for GPU on Python 3.8
Python 3.8` and click on the `Copy` button under the Install section

```bash
odsc conda install -s pytorch110_p38_gpu_v1 
```

![copy-conda-install](images/nb-env-ex-install-btn.png)

- Step 5

Go back to the `Launcher` and click on the `Terminal` icon
![nb-launcher-start-terminal](images/nb-launcher-start-terminal.png)

- Step 6

In the newly open terminal past the Conda installation command and hit enter to install it
![nb-terminal-install-conda-1](images/nb-terminal-install-conda-1.png)

... confirm with `y` the installation

![nb-terminal-install-conda-2](images/nb-terminal-install-conda-2.png)

... wait for the installation to complete
![nb-terminal-install-conda-3](images/nb-terminal-install-conda-3.png)

- Step 7

Activate the conda environment by executing following after the installation completes:

```bash
conda activate /home/datascience/conda/pytorch110_p38_gpu_v1
```

![nb-activate-conda](images/nb-activate-conda.png)

## Task 2: Install dependencies

Now that we have the required conda environment ready, we would need to install some additional python dependencies required for the following code.

You can install the dependencies by running following line in the Terminal.

```bash
pip install transformers evaluate sentencepiece datasets datasets
```

## Task 3: Create project folder

You could work in the notebook root folder under `/home/datascience` but we recommend you to create a subfolder for the project.

In the terminal run:

```bash
mkdir hol
```

... and then enter the folder with

```bash
cd hol
```

You may now **proceed to the next lab**.
