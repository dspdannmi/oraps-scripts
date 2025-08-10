BEGIN {
      section=0
      }

$0 ~ /^====/    {
                section=0
                field=0
                }

#
# Empty lines
#
$0 ~ /^$/       {
                section += 1
                }

#
# Non-empty lines
#
$0 !~ /^$/      {
                #
                # only interested in first 5 fields
                # of SQL text
                #
                if ((section == 1)  && (field < 5))
                    {
                    field += NF
                    printf("%s", $0)
                    }

                #
                # display the last "rows" column from the
                # "total" row
                #
                if ((section >= 3) && ( $1 == "total" ))
                    {
                    printf(" | ")
                    print $NF
                    }
                }

