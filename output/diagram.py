import matplotlib.pyplot as plt
import numpy as np

rr_short = []
sjf_short = []
fcfs_short = []
files = ['rr_result_short.txt','fcfs_result_short.txt','sjf_result_short.txt']

for i, value in enumerate(files):
	file = open(value, 'r')
	for line in file:
		try:
			line = float(line)
			if i == 0:
				rr_short.append(line)
			elif i == 1:
				fcfs_short.append(line)
			elif i == 2:
				sjf_short.append(line)
		except ValueError:
			break
for i, value in enumerate(fcfs_short):
	print value

fig, ax = plt.subplots()
ind = np.arange(100)
width = 0.35 

n_groups = 100

fig, ax = plt.subplots()

index = np.arange(n_groups)
bar_width = 0.25

opacity = 0.6
error_config = {'ecolor': '0.5'}

rects1 = plt.bar(index, fcfs_short, bar_width,
                 alpha=opacity,
                 color='b',
                 #yerr=std_men,
                 error_kw=error_config,
                 label='fcfs, avg:175.730675')

rects1 = plt.bar(index + bar_width, sjf_short, bar_width,
                 alpha=opacity,
                 color='y',
                 #yerr=std_men,
                 error_kw=error_config,
                 label='sjf, avg:228.803775')
rects1 = plt.bar(index +bar_width+bar_width, rr_short, bar_width,
                 alpha=opacity,
                 color='r',
                 #yerr=std_men,
                 error_kw=error_config,
                 label='rr, avg:282.26485')

#rects2 = plt.bar(index + bar_width, means_women, bar_width,
 #                alpha=opacity,
  #               color='r',
   #              yerr=std_women,
    #             error_kw=error_config,
     #            label='Women')

plt.xlabel('Jobb')
plt.ylabel('run time')
plt.title('Comparing different scheduling algorithms')
#plt.xticks(index + bar_width, ('A', 'B', 'C', 'D', 'E'))
plt.legend()

plt.tight_layout()
plt.show()