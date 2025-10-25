
#

for func in become \
            catidpub \
	    col1 \
	    col2 \
	    col3 \
	    col4 \
	    col5 \
	    col6 \
	    col7 \
	    col8 \
	    col9 \
	    col10 \
            cdfile \
            duora \
            latrora \
            lsora \
            mcd \
            mcdworkdir \
            mvold \
            psgrep \
            pslgwr \
            pslsn \
            pstns \
            rmcurrentdir \
            setalertlogvar \
            setdbaliases \
            setoradbenv \
            setpdb \
            setpdbroot \
            showpath \
            showsqlpath \
            ssh-asap \
            sid \
            sleeptrue \
            sorttk \
            unsetoraclesid \
            unsetpdb \
            viewwhich \
            viwhich
do
    . ${CS_TOP}/functions/${func}
done
