#!/bin/bash

set -e -x

pushd task_01_concourse
  bundle install
  bundle exec rspec
  # copy old brakeman file from branch
  git checkout brakeman -- brakeman_output.json
  # compare
  brakeman --compare brakeman_output.json
  # switch to branch
  git checkout brakeman
  # create new brakeman file
  brakeman -o brakeman_output.json
  git config --global user.email "bianca.leitner@beecoding.at"
  git config --global user.name "BiancaLeitner"
  # commit and push it to the branch
  git commit -m "new version of brakeman-file"
  git push -u origin brakeman
  # return to master
  git checkout master
popd