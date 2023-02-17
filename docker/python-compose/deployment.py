#!/usr/bin/python3.8
import docker
import argparse

# client = docker.from_env()
parser = argparse.ArgumentParser()
parser.add_argument('-x', action='store_true', help="flagsita")
parser.add_argument('-run', action='store_true', help="run vagrant")
args = parser.parse_args()
options = parser.parse_args()
if options.x:
    print("que pereza, solo queria ver si podía hacerlo")

if options.run: