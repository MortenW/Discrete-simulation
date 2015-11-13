#from scipy.stats import weibull_min
#from scipy.stats import hypergeom
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.backends.backend_pdf import PdfPages

"""
fig, ax = plt.subplots(1, 1)

c = 1.78661669304
mean, var, skew, kurt = weibull_min.stats(c, moments='mvsk')

x = np.linspace(weibull_min.ppf(0.00, c),
                weibull_min.ppf(0.99, c), 100)

rv = weibull_min(c)
#ax.plot(x, rv.pdf(x), 'k-', lw=2, label='frozen pdf')

vals = weibull_min.ppf([0.000, 0.5, 0.999], c)
np.allclose([0.000, 0.5, 0.999], weibull_min.cdf(vals, c))

r = weibull_min.rvs(c, size=1000) * 50

ax.hist(r, normed=True, alpha=0.2)
ax.legend(loc='best', frameon=False)
plt.show()
"""


s = np.random.poisson(3, 10000) * 10
s = s + 1
m = max(s)
s = [m - entry for entry in s]

plt.figure()
plt.clf()
binwidth = 10
count, bins, ignored = plt.hist(s, bins=range(min(s), max(s) + binwidth, binwidth), normed=True)
plt.xlabel('Job length', fontsize=13)
plt.ylabel('Probability', fontsize=13)
pp = PdfPages('long_data.pdf')
pp.savefig(plt.gcf())
plt.show()
pp.close()
