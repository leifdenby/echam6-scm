"""
Wrapper script for ncl file that generates the actual ECHAM SCM file
"""

import subprocess
import os
import glob
import numpy as np
import collections
import netCDF4
import distutils.spawn

import echamscm


def make_forcing_file(source_filename, output_filename, vct_filename):
    # check that ncl is in path
    if not distutils.spawn.find_executable('ncl'):
        raise Exception("`ncl` needs to be in PATH")

    proc = subprocess.Popen('ncl', stdin=subprocess.PIPE, stdout=subprocess.PIPE)

    t = open(os.path.join(os.path.dirname(__file__), 'echam-scm-arm.ncl.template')).read().format(output_filename=output_filename, 
            source_filename=source_filename, vct_filename=vct_filename)

    out = proc.communicate(input=t)[0]

    if "error" in out or "fatal" in out:
        print "in:"
        print t
        print
        raise Exception(out)



def make_all(base_path, n_levels):
    path = os.path.abspath(os.path.join(base_path, '*/*/*/*/scm-forcing/*.cdf'))
    fnames = glob.glob(path)

    for fn in fnames:
        print os.path.dirname(fn)
        _, _, year, site, season, _, _ = os.path.dirname(os.path.relpath(fn)).split('/')

        season = season.replace('scm-', '')

        vct_filename = echamscm.get_vct_file(n_levels=47)
        source_filename=fn
        output_filename="output/echam6-L{n_levels}-scm-forcing__{site}-{year}-{season}.nc".format(
                year=year, site=site, season=season, n_levels=n_levels,
            )

        try:
            os.remove(output_filename)
        except:
            pass

        try:
            make_forcing_file(source_filename=source_filename, output_filename=output_filename, vct_filename=vct_filename)
        except Exception as e:
            print e.message

            print "Skipped", source_filename, "because of an error"


if __name__ == "__main__":
    make_all()
