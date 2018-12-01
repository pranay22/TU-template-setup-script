#!/bin/bash
# This script install Latex complying with TUDa requirements.
# This script is valid for a Debian Jessie system (GNU/Linux).

# Constants.
DL_DIR=$HOME/TUDaLatex

# Create directory and go there.
mkdir "$DL_DIR"
cd "$DL_DIR"

# Install Latex packages from apt.
sudo apt-get update && sudo apt-get install texlive texlive-lang-german texlive-fonts-extra texlive-latex-extra

# Get Packages from TUDa.
wget http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/tudfonts-tex/tudfonts-tex_0.0.20090806.zip
wget http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/latex-tuddesign/latex-tuddesign_1.0.20140928.zip
wget http://exp1.fkp.physik.tu-darmstadt.de/tuddesign/latex/latex-tuddesign-thesis/latex-tuddesign-thesis_0.0.20140703.zip

# Unzip.
for file in $(ls *.zip); do
	unzip -q "$file"
done
rm *.zip

# Move to the correct location.
sudo mv texmf/* /usr/local/share/texmf
rmdir texmf

# Add package to the latex core.
sudo mktexlsr
sudo updmap-sys
sudo updmap-sys --enable Map 5ch.map
sudo updmap-sys --enable Map 5fp.map
sudo updmap-sys --enable Map 5sf.map

# Compile an example.
cd $DL_DIR
mv doc/* .
rmdir doc
cd latex-tuddesign/doc/examples/tudexercise/
pdflatex TUDexercise.tex

