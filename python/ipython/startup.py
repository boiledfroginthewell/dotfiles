# %load .ipython-setup
# %load_ext autoreload
from datetime import datetime, date
import math

import IPython
import pandas as pd
import numpy as np
import scipy as sp
import scipy.optimize
import pandas_datareader as pdr
import plotly.express as px

try:
	import portfolio.source as source
	import portfolio.metrics as metrics
except ImportError:
	pass

pd.options.display.max_columns = 20

