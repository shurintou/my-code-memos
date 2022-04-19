#This shell is for those who has set the wrong email that cause no green commit contributions counted in their github homepage.

#place this file in the /src path, and then execute it.

#If there are any uncommitted change exist, this shell won't work. Please revert(or stash) the changes before the execution. 

#[important!!!]
# This shell is only recommended to individual project cause it may change other user's commits unintentionally,
# so make sure the GIT_COMMITTER_NAME be checked and know what you about to do before the execution. 

git filter-branch --env-filter '

YOUR_USERNAME="yourUsername"
OLD_EMAIL="wrong@email.com"
CORRECT_EMAIL="correct@email.com"

if [ "$GIT_COMMITTER_NAME" = "$YOUR_USERNAME" -a "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_COMMITTER_NAME" = "$YOUR_USERNAME" -a "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

#After the execution, type ' git push origin --force --all ' in git bash.