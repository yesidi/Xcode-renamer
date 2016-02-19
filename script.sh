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
mv "${NEWNAME}Tests/${OLDNAME}Tests.m" "${NEWNAME}Tests/${NEWNAME}Tests.m"

# Rename the folder with the UITest code
mv "${OLDNAME}UITests" "${NEWNAME}UITests"
mv "${NEWNAME}UITests/${OLDNAME}UITests.m" "${NEWNAME}UITests/${NEWNAME}UITests.m"

# Renamte the xcodeproject file.
mv "${OLDNAME}.xcodeproj" "${NEWNAME}.xcodeproj"

# Rename the shared scheme
mv "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${OLDNAME}.xcscheme" "${NEWNAME}.xcodeproj/xcshareddata/xcschemes/${NEWNAME}.xcscheme"

# Rename the shared scheme for swift
mv "${NEWNAME}.xcodeproj/xcuserdata/iosdev.xcuserdatad/xcschemes/${OLDNAME}.xcscheme" "${NEWNAME}.xcodeproj/xcuserdata/iosdev.xcuserdatad/xcschemes/${NEWNAME}.xcscheme"

# Rename the 'OLDNAME-Bridging-Header' file for swift
mv "${NEWNAME}/${OLDNAME}-Bridging-Header.h" "${NEWNAME}/${NEWNAME}-Bridging-Header.h"

# Rename the 'OLDNAME.xcdatamodeld' file for coreData
mv "${NEWNAME}/${OLDNAME}.xcdatamodeld" "${NEWNAME}/${NEWNAME}.xcdatamodeld"
mv "${NEWNAME}/${NEWNAME}.xcdatamodeld/${OLDNAME}.xcdatamodel" "${NEWNAME}/${NEWNAME}.xcdatamodeld/${NEWNAME}.xcdatamodel"

# Rename the 'OLDNAME.xcworkspace' file for cocoapods
mv "${OLDNAME}.xcworkspace" "${NEWNAME}.xcworkspace"

# For each file inside the folder, replace the default title with the new one.
find . -type f  -print0 | xargs -0 sed -i '' "s/${OLDNAME}/${NEWNAME}/g"
echo "Operation completed"