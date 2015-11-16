import sys
import random
from random import randint
import numpy as np

"""
Job units will be written to a tab separated file with the following format (without the header):

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
    """
    The user has to specify all three parameters to generate a custom data set.
    If 2 or less parameters are specified, the jobs will be generated with default
    parameters.
    """

    if len(argv) == 3:
        number_of_jobs = int(argv[0])
        pattern = argv[1]
        output_file = argv[2]
        print ('Generating jobs with user selected parameters ...')
        generate_random_jobs(number_of_jobs, pattern, output_file)
    else:
        print ('Generating jobs with default parameters ...')
        generate_random_jobs()


def generate_random_jobs(n=100, pattern='random', output_file='job_units.txt'):
    """
    Generates a data set.

    n: size of the data set (number of tokens can vary due to the randomness of
    the function).

    pattern: for 'poisson', the pattern of the data will be similar to the one in Figure 6a.
             for 'inverse_poisson', the pattern of the data will be similar to the on in
             Figure 6b.

    output_file: name of the generated output file.

    """

    if pattern == 'poisson':
        lengths = np.random.poisson(3, n) * 10
        lengths = lengths + 1
    elif pattern == 'inverse_poisson':
        lengths = np.random.poisson(3, n) * 10
        lengths = lengths + 1
        m = max(lengths)
        lengths = [m - entry for entry in lengths]

    arrival_times = random.sample(range(1, n*3), n)
    arrival_times.sort()
    outfile = open(output_file, "w")
    for job_id, arrival_time in enumerate(arrival_times):
        if pattern == 'random':
            generate_job(outfile, arrival_time, job_id + 1, randint(10, 30))
        elif pattern == 'poisson' or pattern == 'inverse_poisson':
            generate_job(outfile, arrival_time, job_id + 1, lengths[job_id])
    outfile.close()


def generate_job(outfile, arrival_time, job_id, length):
    """
    Write the job units to file with the format specified on top of this script.
    """
    for unit in range(1, length + 1):
        s = '%d\t%d\t%d\t%d\n' % (arrival_time, unit, length, job_id)
        outfile.write(s)


if __name__ == '__main__':
    main(sys.argv[1:])
