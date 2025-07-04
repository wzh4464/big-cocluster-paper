% An article class for author response to reviewer comment.
% Copyright (C) 2017 Martin Schroen
% Modifications Copyright (C) 2020 Kaishuo Zhang
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

\NeedsTeXFormat{LaTeX2e}
\typeout{*** LOADING LOCAL ar2rc.cls ***}
\ProvidesClass{ar2rc}[2020/08/04 Author response to reviewer comment class]
\LoadClass{article}

\RequirePackage[includeheadfoot,top=20mm, bottom=20mm, footskip=2.5cm]{geometry}

% Typography
\RequirePackage[T1]{fontenc}
\RequirePackage{times}
%\RequirePackage{mathptmx} % math also in times font
\RequirePackage{amssymb,amsmath}
\RequirePackage{microtype}
\RequirePackage[utf8]{inputenc}

% Misc
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{soul} % Highlight using \hl{}

% Table
\RequirePackage{adjustbox} % center large tables across textwidth by surrounding tabular with \begin{adjustbox}{center}
\renewcommand{\arraystretch}{1.5} % enlarge spacing between rows
\RequirePackage{caption}
\captionsetup[table]{skip=10pt} % enlarge spacing between caption and table

% Section styles
\RequirePackage{titlesec}
\titleformat{\section}{\normalfont\large}{\makebox[0pt][r]{\bf \thesection.\hspace{4mm}}}{0em}{\bfseries}
\titleformat{\subsection}{\normalfont}{\makebox[0pt][r]{\bf \thesubsection.\hspace{4mm}}}{0em}{\bfseries}
\titlespacing{\subsection}{0em}{1em}{-0.3em} % left before after
\titleformat{\paragraph}[display]{\normalfont\bfseries}{}{0em}{}
\titlespacing{\paragraph}{0em}{1em}{0.5em}

% Paragraph styles
\setlength{\parskip}{0.6\baselineskip}%
\setlength{\parindent}{0pt}%

% Quotation styles
\RequirePackage{mdframed}
\renewmdenv[leftmargin=0.4em, rightmargin=0.4em%
    innerleftmargin=0.6em,innerrightmargin=0.6em]{quote}

% Table styles
\let\oldtabular=\tabular
\let\endoldtabular=\endtabular
\renewenvironment{tabular}[1]{\begin{adjustbox}{center}\begin{oldtabular}{#1}}{\end{oldtabular}\end{adjustbox}}

% Shortcuts
%% Let textbf be both, bold and italic
%\DeclareTextFontCommand{\textbf}{\bfseries\em}

%% Add RC and AR to the left of a paragraph
%\def\RC{\makebox[0pt][r]{\bf RC:\hspace{4mm}}}
%\def\AR{\makebox[0pt][r]{AR:\hspace{4mm}}}

%% Define that \RC and \AR should start and format the whole paragraph 
%%% 更稳妥的定义，用大括号参数，不再依赖空行
\RequirePackage{xparse}

% RC and AR commands with starred versions
\NewDocumentCommand{\RC}{s+m}{%
  \par\medskip
  \IfBooleanTF{#1}
    {\noindent{\color{blue}\bfseries\itshape #2}\hspace{1em}} % Starred version (\RC*)
    {
      \noindent{\color{blue}\textbf{Comment:}\hspace{1em}
      {\bfseries\itshape #2}}\par % Unstarred version (\RC)
    }
}

\NewDocumentCommand{\AR}{s+m}{%
  \par\smallskip
  \IfBooleanTF{#1}
    {\noindent #2\hspace{1em}} % Starred version (\AR*)
    {
      \noindent\textbf{Response:}\hspace{1em}
      {#2}\par % Unstarred version (\AR)
    }
}

%%%
%DIF PREAMBLE EXTENSION ADDED BY LATEXDIFF
%DIF UNDERLINE PREAMBLE %DIF PREAMBLE
\RequirePackage[normalem]{ulem} %DIF PREAMBLE
\RequirePackage{xcolor}
\providecommand{\DIFadd}[1]{{\protect\color{blue}\uwave{#1}}} %DIF PREAMBLE
\providecommand{\DIFdel}[1]{{\protect\color{red}\sout{#1}}}                      %DIF PREAMBLE
%DIF SAFE PREAMBLE %DIF PREAMBLE
\providecommand{\DIFaddbegin}{} %DIF PREAMBLE
\providecommand{\DIFaddend}{} %DIF PREAMBLE
\providecommand{\DIFdelbegin}{} %DIF PREAMBLE
\providecommand{\DIFdelend}{} %DIF PREAMBLE
%DIF FLOATSAFE PREAMBLE %DIF PREAMBLE
\providecommand{\DIFaddFL}[1]{\DIFadd{#1}} %DIF PREAMBLE
\providecommand{\DIFdelFL}[1]{\DIFdel{#1}} %DIF PREAMBLE
\providecommand{\DIFaddbeginFL}{} %DIF PREAMBLE
\providecommand{\DIFaddendFL}{} %DIF PREAMBLE
\providecommand{\DIFdelbeginFL}{} %DIF PREAMBLE
\providecommand{\DIFdelendFL}{} %DIF PREAMBLE
%DIF END PREAMBLE EXTENSION ADDED BY LATEXDIFF

% Define title defaults if not defined by user
\providecommand{\lettertitle}{Authors' Response to Reviews of}
\let\@journal\@empty
\let\@doi\@empty
\newcommand{\journal}[1]{\gdef\@journal{#1}}
\newcommand{\doi}[1]{\gdef\@doi{#1}}

% Make title and legend
\renewcommand\maketitle{
{\Large\bf \lettertitle}\\[1em]
{\LARGE \@title}\\[1em]
{\@author}\\
{\it \@journal}\texttt{\@doi}\\
\hrule
% \hfill {\bfseries RC:} \textbf{\textit{Reviewers' Comment}},\(\quad\) AR: Authors' Response, \(\quad\square\) Manuscript Text
}



%% Macros for bibliographystyles %%

% \def\bibcommenthead{\if@bibcomment\begingroup\parindent=0pt\parskip=0pt%
% \removelastskip\vskip13pt\nointerlineskip%
%
% \vbox{\bibfont If you are submitting to one of the Nature Research journals, using the eJP
%  submission system, please include the references within the manuscript file itself. You may
%  do this by copying the reference list from your .bbl file, and pasting it into the bibliography
%  environment of the main manuscript .tex file.}\par%
% \removelastskip\nobreak\vskip13pt\nobreak%
% \endgroup\fi}%

\def\bibcommenthead{}%

%% Macros for border matrix %%

