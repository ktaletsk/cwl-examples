# WIPP on CWL example workflow

This is manually created prototype workflow to show the viability of running WIPP plugins created by NIST and NCATS using Common Workflow Language (CWL).

The steps of workflow follow the steps of [example workflow](https://github.com/usnistgov/WIPP/tree/master/data/Test-Workflow) created by WIPP team.

The workflow described here was tested on Biowulf HPC cluster using [Cromwell CWL executor](https://github.com/broadinstitute/cromwell) version 51 with custom configuration for running Docker steps in Singularity. See the related configuration files in `cromwell` folder.