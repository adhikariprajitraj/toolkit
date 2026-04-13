# Use the official ShareLaTeX/Overleaf image as base
FROM sharelatex/sharelatex:5.5.4

# Install additional system packages and texlive packages
RUN apt-get update && apt-get install -y \
    texlive-fonts-extra \
    texlive-latex-extra \
    && rm -rf /var/lib/apt/lists/*

# Install additional LaTeX packages via tlmgr.
# Install one package at a time so an unavailable package does not skip the rest.
RUN \
        for pkg in \
            amsmath amssymb amsthm array adjustbox algorithm2e biber biblatex \
            booktabs caption changepage chemfig cite circuitikz cleveref colortbl \
            csquotes enumitem fancyhdr float framed gensymb inconsolata listings \
            lmodern mathtools mhchem microtype multirow parskip pdfcol pgfplots \
            physics placeins setspace siunitx subcaption subfigure tcolorbox textpos \
            threeparttable tikz titlesec units xcolor xurl lastpage fira fontawesome5; do \
            tlmgr install "$pkg" || echo "WARN: tlmgr package '$pkg' not available in this image"; \
        done && \
        mktexlsr

# Update font maps and rebuild formats
RUN updmap-sys && \
    fmtutil-sys --all

# Set the working directory
WORKDIR /overleaf
