
#

for func in become \
            catauthkeys \
            catidpub \
            cdwork \
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
            kernelrpms \
            lastwork \
            listwork \
            latrora \
            lsora \
            mcd \
            mcdwork \
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
            settoday \
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
    . ${DSP_TOP}/functions/${func}
done
