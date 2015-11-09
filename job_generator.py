import sys
import random
from random import randint

"""
Job units will be written to a tab separated file with the following format:

    Arrival time    Unit ID     Total       Job ID
               2          1        31           14
               2          2        31           14
               2          3        31           14
                              .
                              .
                              .
               2          31        31          14
               5           1         8          15
               5           2         8          15
                              .
                              .
                              .
               5           8         8          15
"""


def main(argv):
    print len(argv)
    if len(argv) != 2:
        number_of_jobs = 20
        output_file = 'job_units.txt'
    else:
        number_of_jobs = int(argv[0])
        print number_of_jobs
        output_file = argv[1]
        print output_file

    generate_random_jobs(number_of_jobs, output_file)


def generate_random_jobs(n, output_file):
    arrival_times = random.sample(range(1, n*3), n)
    arrival_times.sort()
    outfile = open(output_file, "w")
    for job_id, arrival_time in enumerate(arrival_times):
        generate_job(outfile, arrival_time, job_id + 1, randint(1, 30))
    outfile.close()


def generate_job(outfile, arrival_time, job_id, length):
    for unit in range(1, length + 1):
        s = '%d\t%d\t%d\t%d\n' % (arrival_time, unit, length, job_id)
        outfile.write(s)


if __name__ == '__main__':
    main(sys.argv[1:])
