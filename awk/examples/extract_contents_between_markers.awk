
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

And write to seperate files:

awk -v c=1 '/<dspuser>/ {
                       f="file."(c)".txt"
                       process="true"
                       next
                       }
                       /<\/dspuser>/ {
                       close(f)
                       f="file."(c++)".txt"
                       process=""
                       next
                       }
                       process=="true" {
                       print > f
                       }' dspkeys.cfg


