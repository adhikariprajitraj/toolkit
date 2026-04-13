# Use the official ShareLaTeX/Overleaf image as base
FROM sharelatex/sharelatex:5.5.4

# Install additional LaTeX packages (only packages that exist and aren't already installed)
RUN tlmgr update --self && \
    tlmgr install \
    amsmath \
    amssymb \
    amsthm \
    array \
    adjustbox \
    algorithm2e \
    biber \
    biblatex \
    booktabs \
    caption \
    changepage \
    chemfig \
    cite \
    circuitikz \
    cleveref \
    colortbl \
    csquotes \
    enumitem \
    fancyhdr \
    float \
    framed \
    gensymb \
    listings \
    lmodern \
    mathtools \
    mhchem \
    microtype \
    multirow \
    parskip \
    pdfcol \
    pgfplots \
    physics \
    placeins \
    setspace \
    siunitx \
    subcaption \
    subfigure \
    tcolorbox \
    textpos \
    threeparttable \
    tikz \
    titlesec \
    units \
    xcolor \
    xurl \
    lastpage \
    || true && \
    mktexlsr

# Update font maps and rebuild formats
RUN updmap-sys && \
    fmtutil-sys --all

# Set the working directory
WORKDIR /overleaf
