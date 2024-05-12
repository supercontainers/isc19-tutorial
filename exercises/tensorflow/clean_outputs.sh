#!/bin/bash
rm -rf fake_home/* fake_home/.keras ; touch fake_home/.keep
rm -rf logs
rm -rf saved_model
rm -rf training_checkpoints
rm -f slurm*.out
