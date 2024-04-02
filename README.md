# ucldiscdtlatex
University College London (UCL) Centre for Doctoral Training (CDT) in Data Intensive Sciences (DIS) Group Project Report Template = UCLDISCDTLATEX

*The current stable tag is 00-00-03*

This package will provide a basic latex environment for Group Project Reports. The following gives instructions for downloading and setting up the package. This was tested with TeX Live 2018. Eariler version might have issues (it is time to update!) To check what version you have try `pdflatex --version`

# Installing

Below, goes through a local installation where you can sync as a team via git directly.

You can also use [Overleaf](https://www.overleaf.com/read/szhcqfttdjjx#0fbf57). Fork the github repo and [sync github with overleaf](https://www.overleaf.com/learn/how-to/GitHub_Synchronization#Synchronizing_with_GitHub) and the full team and edit together via the web application (like Google docs but with latex). 

## Getting the Source

```
mkdir reportdir && cd $_
```

Then clone the source

```
git clone https://github.com/gfacini/ucldiscdtlatex
cd ucldiscdtlatex
git checkout tags/XX-YY-ZZ # see above for current tag
cd ../
```

If you have [ssh-keys set up](https://help.github.com/articles/generating-ssh-keys/), then you can clone over SSH instead of HTTPS:

```
git clone git@github.com:gfacini/ucldiscdtlatex
```


# Setup
The first step is to create a set of files from templates that can be customized for your report. These files can be saved in your own personal git repo. You should be ableo to update the uclcdtdislatex package without changing any of your custom files. The default basename is "mydocument". Make it something meaningful i.e. "ASOS_GroupProject" or whatever makes you happy.

```
cd ucldiscdtlatex
make newgp [BASENAME=mydocument] #[] means this is optional. Drop the brackets to set BASENAME to whatever you like
cd ../
```

You will see 5 new files:
 - `Makefile`: A copy of the uclcdtdislatex Makefile configured for your BASENAME
 - `mydocument.tex`: The main file for the document.
 - `mydocument-metadata.tex`: Basic information needed to customize the template to your report
 - `mydocument.bib`: For your bibliography.
 - `mydocument-defs.sty`: For any custom document settings

## Compile
```
make
```
mydocument.pdf will be created. 

## The main file
The main file for the document is `mydocument.tex` or equivalent. Make the following edits as needed:
 - If you add your own definitions, uncomment `\usepackage{mydocument-defs}` after adding some definitions to that file.
 - When you add references to `mydocument.bib`, uncomment `\addbibresource{mydocument.bib}`.
 - If you plan to put your figures in a directory i.e. figures, add the path to `graphicspath`
 - Follow the example of the introduction and conclusion to add more sections to the document.
 
 ## The metadata file
 To customize the report template, edit `mydocument-metadata.tex`:
  - Add the Industry Partner logo by uncommenting `\DISPartnerLogo{}` and adding the image file to your directory.
  - Put an appropriate title for the report in `\DISTitle{}`
  - For drafts, enter a version number using `\DISVersion{}`. This will add line numbers and mark the document as a draft. For the final version, comment this line out.
  - Add an abstract in `\DISAbstract{}`. This will appear on the front page.
  - Enter the authors and their affiliation including the Industry Partners participating in the project. 
  - The reference code `\DISRefCode{}` is a placeholder for now.
  
 ## The final version
 When the report is complete and has been reviewed by the CDT Management, please comment `\DISVersion{}` in the metadata file.
  

# Editing the package
If you have a question, contact Gabriel. If you see a problem with the package, either [create and issue](https://github.com/gfacini/ucldiscdtlatex/issues) or make the change and create pull request. 
