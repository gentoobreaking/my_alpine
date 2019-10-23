#!/bin/bash

[ ! -f ./.gitignore ] && echo -e "variables.env_david\nvariables.env\nset_env" > ./.gitignore
[ -f ./.gitignore ] && cat ./.gitignore
git rm --cached `git ls-files -i --exclude-from=.gitignore`
git add .
git commit -m 'ensure no secerts in source.'
git push

# --- END --- #
