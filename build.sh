#!/bin/bash

PLUGIN_NAME="entity-manager"

cd scripting
spcomp $PLUGIN_NAME.sp -o ../plugins/$PLUGIN_NAME.smx
