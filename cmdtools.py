#!/usr/bin/env python

import argparse
import contextlib
import json
import logging
import os
import subprocess
from textwrap import dedent

logging.basicConfig()
logger = logging.getLogger(__name__)


@contextlib.contextmanager
def cd(path):
    old_cwd = os.getcwd()
    os.chdir(path)
    yield
    os.chdir(old_cwd)


def checkout_cmd(args):
    output_dir = os.path.realpath(args.output)
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)

    config = json.load(args.config)
    for repo in config['repos']:
        name = repo['name']
        url = repo['url']
        commit = repo['commit']

        repo_dir = os.path.join(output_dir, name)

        subprocess.check_call([
            'git', 'clone', url, repo_dir
        ])
        with cd(repo_dir):
            subprocess.check_call([
                'git', 'fetch', '--tags',
                '--progress', url,
                '+refs/pull/*:refs/remotes/origin/pr/*'
            ])
            subprocess.check_call([
                'git', 'checkout', commit
            ])
            subprocess.check_call([
                'git', 'submodule', 'update', '--init', '--recursive'
            ])
        logger.info('Checked out {}:{} at {}'.format(name, commit, repo_dir))


def parse_args():
    parser = argparse.ArgumentParser('onnx-builds')
    subparsers = parser.add_subparsers()

    co_parser = subparsers.add_parser('checkout')
    co_parser.add_argument('config', type=argparse.FileType('r'),
                           help='path of config file')
    co_parser.add_argument('-o', '--output', required=True,
                           help='root directory to checkout related repos')
    co_parser.set_defaults(func=checkout_cmd)

    return parser.parse_args()


def main():
    args = parse_args()
    args.func(args)


if __name__ == '__main__':
    main()
