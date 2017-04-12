import logging as log
import os
import sys
import time
#import datetime
import json
#import re
import random
from uuid import UUID
from pprint import pformat as pf
from pprint import pprint as pp


log_level = str(os.getenv('LOG_LEVEL', 'INFO')).upper()

sleep_duration = int(os.getenv('SLEEP_DURATION', 5 * 3600))

some_env_variable_value = str(
    os.getenv(
        'SOME_VARIABLE',
        'https://some.default/value/{0}'))

log.getLogger('').setLevel(log.getLevelName(log_level))
log.debug("""LOG_LEVEL: {0}""".format(str(log_level)))
log.debug("""SLEEP_DURATION: {0}""".format(str(sleep_duration)))
log.debug("""SOME_VARIABLE: {0}""".format(str(some_env_variable_value)))

# log.getLogger('urllib3').setLevel(log.getLevelName(log_level))


def this_version_string():
    si = sys.implementation.name if hasattr(sys, 'implementation') else 'python_unknown'
    sv = sys.version_info
    return json.dumps({"python": """{0}-{1}.{2}.{3}-{4}-{5}""".format(si,
                                                                      sv.major,
                                                                      sv.minor,
                                                                      sv.micro,
                                                                      sv.releaselevel,
                                                                      sv.serial).lower(),
                       "config": str(os.getenv('APP_CONFIG_VERSION',
                                               'unknown'))},
                      indent=None,
                      sort_keys=True)


def isUUID(s, v=None):
    try:
        val = UUID(s, version=v)
    except ValueError:
        return False
    return True


def do_sleep(t):
    st = random.randint(int(t * 0.6), int(t * 1.4))
    log.info('Sleeping for {0} seconds'.format(st))
    time.sleep(st)
    log.info('Now awake (slept {0})'.format(st))


def do_task_part_1():
    log.info('Starting part: 1')
    # ...
    # ...
    # ...


if __name__ == '__main__':

    log.info('STARTING: {0}'.format(this_version_string()))

    while True:
        do_sleep(sleep_duration)
        # do_task_part_1()
        # do_task_part_2()
        # do_task_part_3()
