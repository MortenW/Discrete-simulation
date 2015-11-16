import sys
import collections

"""
This script loads a file of job units and computes the average waiting times
for the FCFS and SJF scheduling methods.
"""


def main(argv):
    if len(argv) == 1:
        jobs_file = argv[0]
    else:
        jobs_file = 'job_units.txt'

    jobs = load_jobs(jobs_file)
    print ('FCFS average waiting time: %f') % fcfs_average_waiting_time(jobs)
    print ('SJF average waiting time: %f') % sjf_average_waiting_time(jobs)


def fcfs_average_waiting_time(jobs):
    # Sort dictionary on key
    ordered_jobs = collections.OrderedDict(sorted(jobs.items(), key=lambda t: t[0]))
    return average_waiting_time(ordered_jobs)


def sjf_average_waiting_time(jobs):
    # Sort dictionary on value
    ordered_jobs = collections.OrderedDict(sorted(jobs.items(), key=lambda t: t[1]))
    return average_waiting_time(ordered_jobs)


def average_waiting_time(ordered_jobs):
    waiting_time = 0
    last = 0
    w = []
    for _, v in ordered_jobs.iteritems():
        if last != 0:
            waiting_time += last
            last = v
        else:
            last = v
        w.append(waiting_time)
    waiting_time = sum(w)
    average_waiting_time = float(waiting_time) / len(ordered_jobs)
    return average_waiting_time


def load_jobs(jobs_file):
    jobs = {}
    for line in open(jobs_file, "r"):
        tmp = line.rstrip().split("\t")
        at = int(tmp[0])
        total = int(tmp[2])
        jobs[at] = total
    return jobs


if __name__ == '__main__':
    main(sys.argv[1:])
