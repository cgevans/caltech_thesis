% Docs will go here...

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{caltech_thesis}

\newif\ifthesisdraft

% Options
\DeclareOption{thesisdraft}{\thesisdrafttrue}
\DeclareOption{defended}{\thesisdefendedtrue}

\ProcessOptions\relax

\LoadClassWithOptions{memoir}



% Parameters

\newcommand{\copyyear}{\gdef\@copyyear}
\copyyear{\the\year}                                % Default is this year.

\newcommand{\defensedate}{\gdef\@defensedate}
\defensedate{\@date}                                % Default is today

\def\titleskip{\vskip 4\bigskipamount}      %% Whitespace after title
\def\authorskip{\vskip 2\bigskipamount}     %% Whitespace after author

% Package Loading, Initial
\RequirePackage{datetime}
\RequirePackage{geometry}
\RequirePackage{setspace}
\RequirePackage{fontspec}

% PAGE GEOMETRY
% =============
% Caltech thesis regulations are ambiguous regarding the top margin. This makes the
% header be 0.75" from the top, and the body at least 1" (no header I know of is less
% than 0.25").

\geometry{letterpaper,inner=1.5in,outer=1in,top=0.75in,bottom=1in,twoside,includehead}

% FONT STUFF
% ==========
% Choose whatever you'd like here, or set something different. Note that the fonts in my
% thesis are slightly different, as they are in different weights of Minion Pro opticals.

%\setmainfont[Ligatures=TeX,Numbers={Monospaced,Lining}]{Minion Pro}

% TITLE PAGE / COPYRIGHT
% ======================

% Copyright page.
\newcommand{\@makecopyright}{%
    {\parindent=0pt
        \null              % Forces rest to bottom of page
        \vfill
        \begin{center}
            \copyright~\@copyyear\\
            \@author\\
            All Rights Reserved
        \end{center}}
}               %% End of \makecopyright

% Title page. Note that unlike most other classes, this does not employ the antiquated
% memory-saving technique of deleting all the variables afterward. Feel free to use
% them later.
\renewcommand{\maketitle}{%
    \frontmatter
    \OnehalfSpacing
    \begin{center}
        \titleskip
        \noindent{\@title\par}
        \titleskip
        \noindent Thesis by\\
        {\large\@author}\par
        \authorskip\noindent
        In Partial Fulfillment of the Requirements\\
        for the Degree of\\
        Doctor of Philosophy\par
        \vfill
        \noindent\includegraphics[width=1.25in]{seal-filled-orange}
        \vfill
        {\scshape California Institute of Technology}\\
        Pasadena, California\\
        2014\\
        (Defended \@defensedate)
    \end{center}
    \thispagestyle{empty}
    \clearpage
    \thispagestyle{plain}
    \@makecopyright
    \OnehalfSpacing % Set one-half spacing (also in the toc redefinition below)

    % Thesis regulations insist on every page having a number, apparently even blank pages
    % other than the title page.
    \aliaspagestyle{empty}{plain}
    \clearpage
}

% CHAPTER / HEADING FORMATTING, ETC
% =================================

\headstyles{wilsondob}
\chapterstyle{ger}

% Thesis regulations insist on every page having a number, apparently even blank pages.
\makeevenhead{plain}{\thepage}{}{}
\makeoddhead{plain}{}{}{\thepage}
\makeoddfoot{plain}{}{}{}
\makeevenfoot{plain}{}{}{}


% Here are some custom headers for non-blank pages.
\nouppercaseheads
\makepagestyle{ctheadings}
\makeevenhead{ctheadings}{\thepage}{}{\scshape\leftmark}
\makeoddhead{ctheadings}{\rightmark}{}{\thepage}
\makeheadrule{ctheadings}{\textwidth}{\normalrulethickness}
\pagestyle{ctheadings}

% In the case of a draft document, make this clear.
\ifthesisdraft
\settimeformat{ampmtime}
\makeevenfoot{plain}{}{}{\color{red} \textit{Draft: \today}}
\makeoddfoot{plain}{\color{red}  \textit{Draft: \today, \currenttime}}{}{}
\makeevenfoot{ctheadings}{}{}{\color{red}  \textit{Draft: \today, \currenttime}}
\makeoddfoot{ctheadings}{\color{red} \textit{Draft: \today, \currenttime}}{}{}
\fi

% Make the table of contents single-spaced, starting on a verso (even) page
% so that, when the book is opened, as much of it will be visible as possible.
% This may not matter to you.
\let\actualtableofcontents\tableofcontents
\def\tableofcontents{%
    \SingleSpacing
    \cleartoverso
    \actualtableofcontents
    \OnehalfSpacing
}

% More formatting stuff
\openright % Make chapters start on recto (odd) pages
\setlength{\parindent}{6pt} % Indent paragraphs slightly
\nonzeroparskip % But also put some space between them!
