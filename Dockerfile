# Use the official ShareLaTeX/Overleaf image as base
FROM sharelatex/sharelatex:5.5.4

# Install additional LaTeX packages (only packages that exist and aren't already installed)
RUN tlmgr update --self && \
    tlmgr install \
    xcolor \
    listings \
    tcolorbox \
    siunitx \
    titlesec \
    float \
    caption \
    booktabs \
    pgfplots \
    biber \
    biblatex \
    enumitem \
    multirow \
    algorithm2e \
    cite \
    setspace \
    parskip \
    microtype \
    csquotes \
    mathtools \
    physics \
    units \
    gensymb \
    mhchem \
    chemfig \
    circuitikz \
    xltabular \
    cleveref \
    adjustbox \
    changepage \
    subfigure \
    textpos \
    framed \
    pdfcol \
    && \
    mktexlsr

# Update font maps and rebuild formats
RUN updmap-sys && \
    fmtutil-sys --all

# Set the working directory
WORKDIR /overleaf
