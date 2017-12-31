#!/usr/bin/env python

# libs
import os
import sys
import tqdm


# funcs
def new_file_name(fname, fnum, dirpath):
    """Rename old files with new scheme."""

    # get new name
    return '{2}/{0}_{1}.jpg'.format(fname, fnum, dirpath)


def clean_names(dirpath):
    """Walk through data directory tree and clean names."""

    # create temporary file, currennt file, and counter
    temp_file = None
    curnt_file = None
    file_countr = 0

    # walk path
    for root, dirs, files in os.walk(dirpath):
        if files and len(files) > 1:
            print('Path: {0}'.format(root))

            for f in tqdm.tqdm(files):
                temp_file = f.split('_')[0]
                if temp_file == curnt_file:
                    # increment counter
                    counter += 1

                    # get new name
                    new_name = new_file_name(curnt_file, counter, root)

                    # rename
                    os.rename('{0}/{1}'.format(root, f), new_name)

                else:
                    # set current file to point to temp file
                    curnt_file = temp_file

                    # update counter
                    counter = 0
                    counter += 1

                    # get new file name
                    new_name = new_file_name(curnt_file, counter, root)

                    # rename
                    os.rename('{0}/{1}'.format(root, f), new_name)


# executable
if __name__ == '__main__':

    # run
    clean_names(sys.argv[1])
