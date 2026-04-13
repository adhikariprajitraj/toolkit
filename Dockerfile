# Use the official ShareLaTeX/Overleaf image as base
FROM sharelatex/sharelatex:5.5.4

# Install additional LaTeX packages via tlmgr.
# Install one package at a time so an unavailable package does not skip the rest.
RUN \
    curl -fsSL https://mirror.ctan.org/systems/texlive/tlnet/update-tlmgr-latest.sh -o /tmp/update-tlmgr-latest.sh && \
    sh /tmp/update-tlmgr-latest.sh -- --upgrade && \
        for pkg in \
            amsmath amssymb amsthm array adjustbox algorithm2e biber biblatex \
            booktabs caption changepage chemfig cite circuitikz cleveref colortbl \
            csquotes enumitem fancyhdr float framed gensymb inconsolata listings \
            lmodern mathtools mhchem microtype multirow parskip pdfcol pgfplots \
            physics placeins setspace siunitx subcaption subfigure tcolorbox textpos \
            threeparttable pgf tikzfill titlesec units upquote xcolor xurl xkeyval lastpage fira fontaxes fontawesome5; do \
            tlmgr install "$pkg" || echo "WARN: tlmgr package '$pkg' not available in this image"; \
        done && \
    f="$(kpsewhich tcolorbox.sty)" && \
    awk 'BEGIN{added=0} {print} /% Tagging code by Ulrike Fischer/ && !added {print "\\providecommand\\NewStructureName[1]{}"; print "\\providecommand\\AssignStructureRole[2]{}"; print "\\providecommand\\NewTaggingSocket[2]{}"; print "\\providecommand\\NewTaggingSocketPlug[3]{}"; print "\\providecommand\\AssignTaggingSocketPlug[2]{}"; print "\\providecommand\\UseStructureName[1]{}"; print "\\providecommand\\tagstructbegin[1]{}"; print "\\providecommand\\tagstructend{}"; added=1}' "$f" > /tmp/tcolorbox.sty && \
    mv /tmp/tcolorbox.sty "$f" && \
        mktexlsr

# Update font maps and rebuild formats
RUN updmap-sys && \
    fmtutil-sys --all

# Set the working directory
WORKDIR /overleaf
