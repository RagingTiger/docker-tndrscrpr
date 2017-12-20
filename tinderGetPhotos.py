# libs
import requests
import json
import sys
import urllib.request
import os
import os.path
import random
import time

# unused imports from original author
# from selenium import webdriver
# from selenium.webdriver.common.keys import Keys

'''
For this script to run, the following must be specified, and the user must
create an "IMG_PATH" folder for the photos to be saved to.
'''

# globals
# Refer to README.md for how to get token
FBTOKEN = os.environ.get('FACEBOOK_TOKEN')

# Refer to README.md for how to get facebook ID
FBID = os.environ.get('FACEBOOK_ID')

# Name of folder to save images to
IMG_PATH = os.environ.get('TINDERPICS_DIR')


# functions
def waitABit(minTime, maxTime):
    wait = random.uniform(minTime, maxTime)
    print("WAIT: " + str(wait) + "\n")
    time.sleep(wait)


def tinderAPI_get_xAuthToken(facebook_token, facebook_id):

    loginCredentials = {'facebook_token': facebook_token,
                        'facebook_id': facebook_id}
    headers = {'Content-Type': 'application/json',
               'User-Agent': 'Tinder Android Version 3.2.0'}
    r = requests.post('https://api.gotinder.com/auth',
                      data=json.dumps(loginCredentials), headers=headers)
    x_auth_token = r.json()['token']

    return x_auth_token


def tinderAPI_getSubjectList(x_auth_token):

    # Get a list of subjects
    headers2 = {'User-Agent': 'Tinder Android Version 3.2.0',
                'Content-Type': 'application/json',
                'X-Auth-Token': x_auth_token}
    r2 = requests.get('https://api.gotinder.com/user/recs', headers=headers2)
    subjects = r2.json()['results']

    # Return list of subjects
    return subjects


def tinderAPI_passSubject(subject, x_auth_token):
    _id = subject['_id']
    headers3 = {'X-Auth-Token': x_auth_token,
                'User-Agent': 'Tinder Android Version 3.2.0'}
    r3 = requests.get('https://api.gotinder.com/pass/' + _id, headers=headers3)


def getPics(x_auth_token, imagepath):

    # Get list of subjects
    subjects = tinderAPI_getSubjectList(x_auth_token)

    # Iterate through list of subjects
    for subject in subjects:

        # Get the subject ID
        sid = subject['_id']

        # Gets a list of pictures of the subject
        pics = subject['photos']

        # Iterate through and save the pictures of the subject
        for picIndex in range(len(pics)):

            # Get the URL for the largest cropped photo
            processed_picURL = str(pics[picIndex]['processedFiles'][0]['url'])

            # unique image file name
            img_name = imagepath + '/' + sid + '_' + str(picIndex + 1) + '.jpg'

            # Get the photo and save
            urllib.request.urlretrieve(processed_picURL, img_name)

        # Wait some random amount of time and then pass the subject
        waitABit(0.5, 2.0)

        # Pass the subject
        tinderAPI_passSubject(subject, x_auth_token)


def main():
    # Log into Tinder
    x_auth_token = tinderAPI_get_xAuthToken(FBTOKEN, FBID)

    # Get pics
    for i in range(10000):

        # Print current iteration to terminal
        print("Potential Match Batch: ", str(i + 1))

        # Get one collection of subjects and their pictures
        try:
            getPics(x_auth_token, IMG_PATH)
        except (urllib.error.HTTPError, KeyError) as err:
            sys.exit('Error occured: {0}'.format(err))

        # Wait a bit
        waitABit(0.25 * 60, 0.5 * 60)


# executable
if __name__ == '__main__':

    # run main
    main()
