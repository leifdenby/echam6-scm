import os

def get_vct_file(n_levels):
    if n_levels == 47:
        return os.path.join(os.path.abspath(os.path.dirname(__file__)), 'vct-defs', 'ECHAM_L47_vct.nc')
    else:
        raise NotImplementedError("vct definition file wasn't found for %d levels, please put one in `vct-defs/`" % n_levels)
