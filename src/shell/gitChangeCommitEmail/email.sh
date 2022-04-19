#This shell is for those who has set the wrong email that cause no green commit contributions counted in their github homepage.

#place this file in the /src path, and then execute it.

#Noat that the CORRECT_NAME is optional.

git filter-branch --env-filter '

OLD_EMAIL="wrong@email.com"
CORRECT_NAME="correctUsername"
CORRECT_EMAIL="correct@email.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

#After the execution, type ' git push origin --force --all ' in git bash.