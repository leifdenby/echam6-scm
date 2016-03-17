# SCM forcing for ECHAM6

Single-column forcing files for the [ECHAM 6 model (Max Planck Institute
Hamburg)](http://www.mpimet.mpg.de/en/science/models/echam.html).

To generate all forcing files from the input data in the repository run:

> python -m echamscm {n_levels}

where `n_levels` is the number of ECHAM model levels. Currently only 47 model
levels has been implemented.


Any bugs or comments please email leif@denby.eu
