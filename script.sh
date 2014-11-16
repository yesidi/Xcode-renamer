#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Please specify the name of the project"
    exit 1
fi

# Setting system variables
LC_CTYPE=C
LANG=C

OLDNAME=$1


# Replace all the spaces from the new name with underscore, because using spaces is evil.
# NEWNAME=$(echo $1 | sed 's/ /_/g')
NEWNAME=${2// /_} 



# Rename the root folder fo the project
mv "$OLDNAME" "$NEWNAME"
cd "$NEWNAME"
# Rename the folder with the source code
mv "$OLDNAME" "$NEWNAME"
# Rename the folder with the test code
mv "${OLDNAME}Tests" "${NEWNAME}Tests"
# Renamte the xcodeproject file.
mv "${OLDNAME}.xcodeproj" "${NEWNAME}.xcodeproj"

# Rename the shared scheme
mv "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${OLDNAME}.xcscheme" "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${NEWNAME}.xcscheme"

# For each file inside the folder, replace the default title with the new one. 
find . -type f  -print0 | xargs -0 sed -i '' "s/${OLDNAME}/${NEWNAME}/g"
echo "Operation completed"