
        DESCRIPTION_1=$(awk '/<DESCRIPTION>/ {
                                     process="true"
                                     next
                                     }
                                    /<\/DESCRIPTION>/ {
                                     process=""
                                     next
                                     }
                                     process=="true" {
                                     print
                                     }' ${file1} )

