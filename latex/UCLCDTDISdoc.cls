%-------------------------------------------------------------------------
% Template class for UCL CDT DIS documents
%
%-------------------------------------------------------------------------
\def\ATPackageVersion{00-00}

\ProvidesClass{ucldiscdtlatex/latex/UCLCDTDISdoc}[2018/02/10 v.00-00 UCL CDT DIS document class]
% Needs 2009 TeX Live or later
\NeedsTeXFormat{LaTeX2e}[2009/01/01]

%-------------------------------------------------------------------------
% More advanced if syntax
\RequirePackage{ifthen}
% Process options. Use kvoptions package.
\RequirePackage{kvoptions}
%\RequirePackage[debugshow]{kvoptions}
\SetupKeyvalOptions{
  family=ADOC,
  prefix=ADOC@
}
\DeclareBoolOption[true]{disstyle}
\DeclareBoolOption[true]{disdraft}
\DeclareStringOption{paper}
\DeclareStringOption[normal]{titlesize}
\DeclareBoolOption[true]{floatopt}
\DeclareBoolOption[true]{abstract}
\DeclareBoolOption[true]{datetop}
\DeclareBoolOption[false]{showframe}
\DeclareStringOption[0pt]{titleextraheight}
\DeclareStringOption[0pt]{copyrightoffset}
\ProcessKeyvalOptions{ADOC}

% Type of document
\newcommand*{\ADOC@docheadingdefault}{UCL CDT DIS Note}
\typeout{uclcdtdisdoc: UCL CDT DIS Note}

% Set the main class
\def\ADOC@mainclass{scrartcl}

% Set paper size
\ifx\ADOC@paper\@empty
  \def\ADOC@paperstring{a4paper}
  \PassOptionsToClass{a4paper}{\ADOC@mainclass}
  \typeout{uclcdtdisdoc: paper size set to default A4}
\else
  \def\ADOC@paperstring{\ADOC@paper paper}
  \PassOptionsToClass{\ADOC@paperstring}{\ADOC@mainclass}
  \typeout{uclcdtdisdoc: paper is \ADOC@paper, string for class is \ADOC@paperstring}
\fi

% Set font sizes for title page
\ifthenelse{\equal{\ADOC@titlesize}{small}}{%
  \newcommand*{\ADOC@maintitlesize}{\LARGE}
  \newcommand*{\ADOC@authorsize}{\large}
  \newcommand*{\ADOC@abstractsize}{\small}
}{%
  \newcommand*{\ADOC@maintitlesize}{\huge}
  \newcommand*{\ADOC@authorsize}{\Large}
  \newcommand*{\ADOC@abstractsize}{\normalsize}
}



%-------------------------------------------------------------------------
% Defaults for title page
\newdimen\ADOC@skipbeforetitle
\ADOC@skipbeforetitle=60\p@
\newcommand{\skipbeforetitle}[1]{\ADOC@skipbeforetitle=#1}

% Any additions here that affect the cover page should also be added to atlascover.sty
\def\@title{Dummy title in atlasdoc\\ Use \textbackslash AtlasTitle to set it}
\newcommand{\DISTitleText}{Dummy DISTitleText in UCLCDTDISdoc\\ Use \textbackslash DISTitle to set it}
\newcommand{\DISTitle}[1]{%
  % \def\@title{#1}%
  \title{#1}%
  \renewcommand{\DISTitleText}{#1}%
}
\author{The UCL CDT DIS}
\date{\today}

% DIS Partner logo
\def\ADOC@partnerlogo{logo-example}
\newcommand*{\DISPartnerLogo}[1]{\def\ADOC@partnerlogo{#1}}

% Draft version
\def\ADOC@draftversion{}
\newcommand*{\draftversion}[1]{\def\ADOC@draftversion{#1}}
\newcommand*{\DISVersion}[1]{\def\ADOC@draftversion{#1}}

% DIS reference code - empty by default
\def\ADOC@refcode{}
\newcommand*{\DISRefCode}[1]{\def\ADOC@refcode{#1}}

% DIS note number
\def\ADOC@disnote{}
\newcommand*{\DISNote}[1]{\def\ADOC@disnote{#1}}

% DIS date - arXiv submission; to be filled in by the Physics Office
\def\ADOC@disdate{\today}
\newcommand*{\DISDate}[1]{\def\ADOC@disdate{#1}}

% DIS document heading
\def\ADOC@docheading{}
\newcommand*{\DISHeading}[1]{\def\ADOC@docheading{#1}}

% Abstract text
% \newif\ifADOC@abstract
% \ADOC@abstractfalse
\def\DISAbstractText{}
\newcommand{\DISAbstract}[1]{\def\DISAbstractText{#1}}
\newcommand{\abstracttext}[1]{\def\DISAbstractText{#1}}

% Extra macros needs for the cover page - define them here
\def\ACOV@CommentsDeadline{Comments deadline}
\newcommand{\DISCoverCommentsDeadline}[1]{\def\ACOV@CommentsDeadline{#1}}

\def\ACOV@AnalysisTeam{Analysis team}
\newcommand{\DISCoverAnalysisTeam}[1]{\def\ACOV@AnalysisTeam{#1}}


% Multiple corresponding editors
\def\ACOV@Editors{} % Corresponding editor name & corresponding.editor@email \\ }
\newcommand{\DISCoverEditor}[2]{%
  \g@addto@macro\ACOV@Editors{%
    #1 & (\texttt{#2}) \\
  }%
}

%-------------------------------------------------------------------------

% Invoke main class
% Note that \KOMAoptions is not available in versions of KOMA-Script older than 3.0
\LoadClass[titlepage,11pt]{scrartcl}

% Turn on bold math when using \bfseries
\def\bfseries{\fontseries\bfdefault\selectfont\boldmath}

% Set KOMA-script options for DIS style
\ifADOC@disstyle
  \KOMAoptions{headinclude=true, footinclude=false}
  % Put less text on the pages of BOOKs etc.
  \KOMAoptions{DIV=14, BCOR=5mm}
  % Do not put a dot after Section/Chapter, nor in the figure caption.
  \KOMAoptions{numbers=noendperiod}
  % Paragraph spacing is half a line
  \KOMAoptions{parskip=half}
  \addtokomafont{disposition}{\rmfamily}
  \addtokomafont{author}{\ADOC@authorsize}
  \addtokomafont{part}{\LARGE}
  \addtokomafont{descriptionlabel}{\rmfamily}
  \setkomafont{pagehead}{\normalsize\rmfamily}
  \setkomafont{caption}{\normalfont\small}
  \setcapindent{0pt}
  \deffootnote[1em]{1em}{1em}{\textsuperscript{\thefootnotemark}\ }
\fi

% Adjust font size for title
% For recent TeX Live version use xpatch. Have to use etoolbox for older versions (not supported)

\RequirePackage{xpatch}
% \xshowcmd\maketitle
\xpatchcmd{\maketitle}{\usekomafont{title}{\huge \@title \par}}{\usekomafont{title}{\ADOC@maintitlesize \@title \par}}{\typeout{disdoc xpatch: OK! Title size changed!}}{\typeout{disdoc xpatch: Oh no! Title size is still huge!}}


% Some tweaks to remove the date from \maketitle
%\expandafter\show\csname\string\maketitle\endcsname
%\expandafter\show\csname\string\maketitle\space\endcsname
\ifADOC@datetop
% Remove \@date and spacing following it from \@maketitle
  \xpatchcmd{\maketitle}{{\usekomafont{date}{\@date \par}}\vskip \z@ \@plus 3fill}{}{\typeout{atlasdoc xpatch: OK! Date font adjusted!}}{\typeout{atlasdoc xpatch: Oh no! Date font unchanged!}}
\fi



% Remove the numbers from all the headings (\section, \subsection, etc.)
%\setcounter{secnumdepth}{-1}

% Required packages
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{babel}
% hyperref is needed in many places, so include it here
\RequirePackage{hyperref}


% Adjust float settings to try to avoid problems.
% These follow the UK FAQ - see also P.199-200 of the LaTeX Book
\ifADOC@floatopt
  \renewcommand{\topfraction}{0.85}
  \renewcommand{\bottomfraction}{0.70}
  \renewcommand{\textfraction}{0.15}
  \renewcommand{\floatpagefraction}{0.66}
  \renewcommand{\dbltopfraction}{0.66}
  \renewcommand{\dblfloatpagefraction}{0.66}
  \setcounter{topnumber}{9}
  \setcounter{bottomnumber}{9}
  \setcounter{totalnumber}{20}
\fi

% Add ability to include line numbers
\RequirePackage{lineno}
% If you have an old lineno or do not have it, you can get it from the latex/other directory
% \RequirePackage{latex/other/lineno}
% \nolinenumbers
\ifADOC@showframe
  \RequirePackage{showframe}
\fi

% Compute the time in hours and minutes; make new variables \timehh and \timemm
\newcount\timehh\newcount\timemm
\timehh=\time
\divide\timehh by 60 \timemm=\time
\count255=\timehh\multiply\count255 by -60 \advance\timemm by \count255
% Now make a string with date and time
\newcommand{\dateandtime}{\today \ --
  \ifnum\timehh<10 0\fi\number\timehh:\ifnum\timemm<10 0\fi\number\timemm}


% Draft heading/footer code
\newcommand{\DISDraftHeading}{
  \RequirePackage[headsepline]{scrlayer-scrpage}
  \ihead{}
  \chead[]{\fbox{\textsf\bfseries UCL CDT DIS DRAFT}}
  \ohead{}
  \ifoot{\dateandtime}
  \cfoot{}
  \ofoot{\thepage}
  \pagestyle{scrheadings}
}


% Length needed for parbox/minipage in title page
\newlength{\titlepageparbox}
\setlength{\titlepageparbox}{\textwidth}
%\addtolength{\titlepageparbox}{-2\fboxrule}
%\addtolength{\titlepageparbox}{-2\fboxsep}
%\addtolength{\titlepageparbox}{-9pt}
%\typeout{titlepageparbox is \the\titlepageparbox}



%-----------------------------------------------------------------------

%\setkomavar{firsthead}{%
%  {\usekomafont{headtitle}\usekomavar{headtitle}\\}
%  {\usekomafont{headsubtitle}\usekomavar{headsubtitle}\\}
%  \noindent\hspace*{-\useplength{1cm}}%
%  \includegraphics[width=\paperwidth]{uclbanner-outline}%
%}

% Title page design
\newcommand{\DISTitleHeader}{%

\vspace*{-22mm}
\parbox[t][35mm][t]{\paperwidth}{%
 \noindent\hspace*{-2.8cm}
 \includegraphics{uclbanner-outline}
}

  \parbox[t][35mm][t]{\titlepageparbox}{%
    \parbox[b][35mm][t]{0.24\titlepageparbox}{%
      \includegraphics[height=35mm]{cdt_dis_logo}
    }
    \hspace*{\fill}
    \parbox[b][35mm][c]{0.48\titlepageparbox}{%
      \centering
        {\sffamily\bfseries\fontsize{20}{24}\selectfont
         \ifx\ADOC@docheading\@empty
           \textsf{\ADOC@docheadingdefault}\par
         \else
           \textsf{\ADOC@docheading}\par
         \fi
        }
        \vspace*{2ex}
        % reference code, if any 
        \ifx\ADOC@refcode\@empty
            \mbox{}%
        \else
            {\Large \ADOC@refcode}\par
        \fi
        \vspace*{1.5ex}
        % Date, if any
        \ifADOC@datetop
          \ifx\@date\@empty
            \mbox{}\par
          \else
            \@date\par
          \fi
        \fi
    }
    \hspace*{\fill}
    \parbox[b][35mm][t]{0.24\titlepageparbox}{%
      \hspace*{\fill}\includegraphics[height=35mm]{\ADOC@partnerlogo}\par
      \ifADOC@disdraft
        \ifx\ADOC@draftversion\@empty
          \relax{0}
        \else
          \normalsize\hspace*{\fill}Draft version \ADOC@draftversion
        \fi
      \fi
    }
  }\par
}
%-----------------------------------------------------------------------

% Copyright cover footer - parbox does not introduce spurious vertical space
\newcommand{\DISCopyrightFooter}{%
  \parbox[b]{\linewidth}{%
    \rmfamily\mdseries\fontsize{10}{12}\selectfont
    \copyright\ \the\year \ University College London for the benefit of the Centre for Doctoral Training in Data Intensive Sciences. %\newline
    Reproduction of this article or parts of it is allowed as specified in the CC-BY-4.0 license.
  }\par
}

%-----------------------------------------------------------------------

% Add elements to KOMA-Script title page
% Header
\typeout{uclcdtdisdoc: defining UCL CDT DIS document title page}
\titlehead{\DISTitleHeader}

%-----------------------------------------------------------------------


% Abstract and copyright
\newlength{\abstractparbox}
\setlength{\abstractparbox}{\textwidth}
% \addtolength{\abstractparbox}{-2\fboxrule}
% \addtolength{\abstractparbox}{-2\fboxsep}
\newlength{\abstractheight}
\setlength{\abstractheight}{0.50\textheight}
\addtolength{\abstractheight}{-\ADOC@titleextraheight}
\newlength{\copyrightoffset}
\ifthenelse{\equal{\ADOC@maintitlesize}{small}}{%
  \setlength{\copyrightoffset}{-7.5em}
}{%
  \setlength{\copyrightoffset}{-7.5em}
}
\addtolength{\copyrightoffset}{\ADOC@copyrightoffset}

\newcommand{\AbstractText}{%
  \vspace*{\stretch{1}}
  % \fbox{\begin{minipage}[b][\abstractheight]{\abstractparbox}
  \begin{minipage}[b][\abstractheight]{\abstractparbox}
    % Astract
    \if\DISAbstractText\@empty
      \mbox{}
    \else
      \begin{quote}\ADOC@abstractsize
      \ifADOC@disdraft
        \ifx\ADOC@draftversion\@empty%
          \DISAbstractText\par
        \else
          \begin{internallinenumbers}
            \DISAbstractText
          \end{internallinenumbers}\par
        \fi
      \else
        \DISAbstractText\par
      \fi
      \end{quote}
    \fi
  \end{minipage}\par
}


\addtolength{\copyrightoffset}{\ADOC@copyrightoffset}
\newcommand{\DISAbstractCopyright}{%
  \vspace*{\stretch{1}}
  % \fbox{\begin{minipage}[b][\abstractheight]{\abstractparbox}
  \begin{minipage}[b][\abstractheight]{\abstractparbox}
    % Astract
    \if\DISAbstractText\@empty
      \mbox{}
    \else
      \begin{quote}\ADOC@abstractsize
      \ifADOC@disdraft
        \ifx\ADOC@draftversion\@empty%
          \AtlasAbstractText\par
        \else
          \begin{internallinenumbers}
            \DISAbstractText
          \end{internallinenumbers}\par
        \fi
      \else
        \DISAbstractText\par
      \fi
      \end{quote}
    \fi
    \vspace*{\stretch{1}}
    \DISCopyrightFooter
  \end{minipage}\par
  % \end{minipage}}\par
  \vspace*{\copyrightoffset}
}


\publishers{\vspace*{\fill}\normalsize\rmfamily\DISAbstractCopyright}

%-----------------------------------------------------------------------
\AtBeginDocument{%
    % Add draft heading and line numbers
    \ifADOC@disdraft
      \ifx\ADOC@draftversion\@empty%
        \typeout{*** uclcdtdisdoc: this draft document does not have version number!}
      \else
        \typeout{uclcdtdisdoc: this is an UCL CDT DIS draft document}
        \DISDraftHeading
        \linenumbers
      \fi
    \else
      \typeout{uclcdtdisdoc: this is the final version of an UCL CDT DIS document}
    \fi
}

\endinput
