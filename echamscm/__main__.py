"""
Generate ECHAM SCM forcing files for all input files found in `source-data/`
"""

import echamscm.arm_iop
import argparse
import os



argparser = argparse.ArgumentParser(__doc__)
argparser.add_argument('n_levels', help="Number of target ECHAM model levels", type=int)

args = argparser.parse_args()

try:
    os.makedirs('output')
except OSError as e:
    if e.errno == 17:
        pass
    else:
        raise

datapath = os.path.join(os.path.dirname(os.path.abspath(__file__)), os.pardir, 'source-data')
echamscm.arm_iop.make_all(n_levels=args.n_levels, base_path=os.path.join(datapath, 'arm-iop'))
