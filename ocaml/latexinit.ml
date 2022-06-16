open Printf

let author =
  ref
    "Paul Patault\\thanks{MPRI, \
     \\href{mailto:paul.patault@universite-paris-saclay.fr}{\\texttt{paul.patault@universite-paris-saclay.fr}}}"

let date = ref "\\today"
let path = ref ""
let title = ref "[Titre]"
let classe = ref "article"
let input_files = ref []
let anon_fun filename = input_files := filename :: !input_files

let speclist =
  [
    ("-author", Arg.Set_string author, "  tex param");
    ("-A", Arg.Set_string author, "  tex param");
    ("-date", Arg.Set_string date, "  tex param");
    ("-title", Arg.Set_string title, "  tex param");
    ("-T", Arg.Set_string title, "  tex param");
    ("-class", Arg.Set_string classe, "  tex param");
    ("-C", Arg.Set_string classe, "  tex param");
    ("-path", Arg.Set_string path, "  mkdir name");
    ("-P", Arg.Set_string path, "  mkdir name");
  ]

let usage_msg = "usage: " ^ Sys.argv.(0) ^ " [options]"

let ppbase =
  {separator|
\ProvidesPackage{ppbase}[2022]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% BASE PKG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage{ulem}\normalem
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[french]{babel}

\RequirePackage{url}
\RequirePackage{xcolor}
\RequirePackage{enumerate}

\RequirePackage{amsfonts, amsthm, amsmath, amssymb}
\RequirePackage{mathpartir}
\RequirePackage{adjustbox}

\RequirePackage{framed}
\RequirePackage{lmodern}
\RequirePackage{booktabs}
\RequirePackage[activate={true,nocompatibility},
    final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% BASE COLORS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\definecolor{thered}{rgb}{0.797,0,0}
\definecolor{lightgrey}{gray}{0.9}
\definecolor{lightred}{RGB}{255,245,245}
\definecolor{darkred}{RGB}{170,0,0}
\definecolor{codegreen}{rgb}{0,0.6,0}
\definecolor{codegray}{rgb}{0.5,0.5,0.5}
\definecolor{codepurple}{rgb}{0.58,0,0.82}
\definecolor{mgreen}{RGB}{40,150,40}
\definecolor{myellow}{RGB}{244,159,4}
\definecolor{mblue}{RGB}{4,100,244}
\definecolor{mgreen}{RGB}{30,160,8}

\definecolor{blue2}{rgb}{0.7, 0.83, 1}
\definecolor{ocolor}{rgb}{1, 0.74, 0.31}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MACROS / ALIASES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\bbk}[1]{[\![ #1 ]\!]}
\newcommand{\defeq}{\stackrel{\text{\tiny def}}{=}}
\newcommand{\comp}[1]{\mathcal{C}_{\textsc{\tiny Time}}(#1)}
\newcommand{\compe}[1]{\mathcal{C}_\emph{\textsc{\tiny Time}}(#1)}
\renewcommand{\r}[1]{\textcolor{thered}{#1}}
\newcommand{\ttA}{\texttt{\small A}}
\newcommand{\ttB}{\texttt{\small B}}
\newcommand{\ttws}{\texttt{\small \_}}
\newcommand{\rab}{$[\Rightarrow]$}
\newcommand{\lab}{$[\Leftarrow]$}
\newcommand{\ttl}{\texttt{[}\,}
\newcommand{\ttr}{\,\texttt{]}}
\newcommand{\ttx}{\texttt{x}}
\newcommand{\ttt}{\texttt{t}}
\newcommand{\ttw}{\texttt{\_}}
\newcommand{\ttu}{\texttt{usefulness}}
\newcommand{\vq}{$\vec{\text{q}}$}
\newcommand{\rvq}{\r{\vq}}
\newcommand{\rbf}[1]{\r{\textbf{#1}}}
\newcommand{\rotatedsquare}{\rotatebox[origin=c]{45}{$\blacksquare$}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% NEW COUNTER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcounter{daggerfootnote}
\newcommand*{\daggerfootnote}[1]{%
    \setcounter{daggerfootnote}{\value{footnote}}%
    \renewcommand*{\thefootnote}{\fnsymbol{footnote}}%
    \footnote[2]{#1}%
    \setcounter{footnote}{\value{daggerfootnote}}%
    \renewcommand*{\thefootnote}{\arabic{footnote}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% IF-INCLUSION PKG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newif\if@code    \@codefalse
\newif\if@figs    \@figsfalse
\newif\if@tikz    \@tikzfalse
\newif\if@href    \@hreffalse
\newif\if@gantt   \@ganttfalse
\newif\if@abeamer \@abeamerfalse

\DeclareOption{tikz}{\@tikztrue}
\DeclareOption{figs}{\@figstrue}
\DeclareOption{code}{\@codetrue}
\DeclareOption{href}{\@hreftrue}
\DeclareOption{gantt}{\@gantttrue}
\DeclareOption{abeamer}{\@abeamertrue}

\DeclareOption*{}
\ProcessOptions

\if@figs
    \RequirePackage{caption}
    \RequirePackage{float}
    \RequirePackage{wrapfig}
    \graphicspath{ {./img} }
    % \RequirePackage{pdfpages}
\fi

\if@tikz
    \RequirePackage{tikz}
    \usetikzlibrary{decorations.text,calc}
    \usetikzlibrary{arrows}
    \usetikzlibrary{arrows.meta}
    \usetikzlibrary{shapes.geometric}
    \usetikzlibrary{automata,positioning}
    \usetikzlibrary{matrix,backgrounds}
    \usetikzlibrary{angles,calc,quotes}
    \usetikzlibrary{matrix}
    \RequirePackage{graphviz}
\fi

\if@code
    \RequirePackage{algorithm}
    % \RequirePackage{algorithmic}
    % \RequirePackage{algpseudocode}
    \RequirePackage{minted}
    \RequirePackage{listings}
    \newcommand{\ocaml}[1]{\mintinline{ocaml}{#1}}
    \newcommand{\bashi}[1]{\mintinline{bash}{#1}}
    \renewcommand{\listingscaption}{Programme}
    \lstdefinestyle{mystyle}{
        % backgroundcolor=\color{lightgrey},
        % commentstyle=\color{mgreen},
        keywordstyle=\color{thered},
        numberstyle=\tiny\color{codegray},
        stringstyle=\color{mgreen},
        basicstyle=\ttfamily\footnotesize,
        breakatwhitespace=false,
        breaklines=true,
        captionpos=b,
        keepspaces=true,
        showspaces=false,
        showstringspaces=false,
        showtabs=false,
        tabsize=2,
    }
    \lstdefinestyle{mystyle_tiny}{
        keywordstyle=\color{thered},
        numberstyle=\tiny\color{codegray},
        stringstyle=\color{mgreen},
        basicstyle=\ttfamily\tiny,
        breakatwhitespace=false,
        breaklines=true,
        captionpos=b,
        keepspaces=true,
        showspaces=false,
        showstringspaces=false,
        showtabs=false,
        tabsize=2,
    }
    \lstdefinelanguage{gospel} {
        morekeywords={ type, val, requires, ensures },
        sensitive=false,
        % morecomment=[l]{//},
        % morecomment=[s]{/*}{*/},
        % morestring=[b]",
        emph={},
        emphstyle=\color{myellow},
        classoffset=1,
        keywords={},
        keywordstyle=\color{mblue},
        classoffset=0,
    }
    \lstset{style=mystyle}
\fi

\if@href
    \RequirePackage[bookmarks=true,colorlinks=true,
        citecolor={thered}, filecolor={thered},
        urlcolor={thered}, linkcolor={thered},
        pdfstartview={XYZ null null 1.22}, hyperindex=true]{hyperref}
\fi

\if@gantt
    \RequirePackage{graphicx}
    \RequirePackage{tikz-uml}
    \RequirePackage{pgfgantt}
\fi


\if@abeamer
    \usetheme{CambridgeUS}
    \usecolortheme{beaver} % seahorse, dolphin, default, beaver
    \usefonttheme{professionalfonts}
    \useinnertheme{rectangles}
    % \useoutertheme{infolines}
    \setbeamercolor{block title}{fg=white,bg=darkred}
    \setbeamercolor{block body}{bg=lightred}
    \setbeamercolor{section in toc}{fg=thered}
    \setbeamercolor{section in toc shaded}{bg=structure!20, fg=thered}
    \setbeamercolor{section number projected}{fg=thered, bg=thered,fg=white}
    \setbeamercolor{subsection number projected}{fg=thered, bg=thered,fg=white}
    \setbeamertemplate{itemize item}{\scalebox{0.8}{\r{$\blacksquare$}}}
    \setbeamertemplate{subitemize item}{\scalebox{0.8}{\r{$\blacksquare$}}}
    \setbeamertemplate{enumerate item}{\scalebox{0.5}{\r{\rotatedsquare}}}
    \setbeamercovered{invisible} % invisible / transparent
\else
    \RequirePackage{fullpage}
    % \RequirePackage[a4paper, left=3.3cm, right=3.3cm, bottom=5cm]{geometry}
    \RequirePackage{fancyhdr}
    \pagestyle{fancy}
    \fancyhead{}
    \fancyfoot{}
    \renewcommand{\sectionmark}[1]{\markright{\thesection\ #1}}
    % \renewcommand{\subsectionmark}[1]{\markright{\thesubsection\ #1}}
    % \renewcommand{\subsubsectionmark}[1]{\markright{\thesubsubsection\ #1}}
    % \fancyhead[CO]{\textsc{\rightmark}}
    % \fancyhead[CE]{\textsc{Paul Patault}}
    \fancyfoot[CO]{\thepage}
    \renewcommand{\footrulewidth}{0pt}
    \renewcommand{\headrulewidth}{0pt}
    % \setlength{\headheight}{40pt}
    % \addtolength{\topmargin}{-2pt}
    \setlength{\headheight}{20pt}
    \setlength{\topmargin}{-13.59999pt}
    \renewcommand{\baselinestretch}{1.2}

    \theoremstyle{plain}      \newtheorem{theoreme}{Théorème}%[section]
    \theoremstyle{plain}      \newtheorem{conjecture}{Conjecture}%[section]
    \theoremstyle{plain}      \newtheorem{corollaire}{Corollaire}%[theoreme]
    \theoremstyle{plain}      \newtheorem{lemme}{Lemme}
    \theoremstyle{definition} \newtheorem{definition}{Définition}%[section]
    \theoremstyle{definition} \newtheorem{notation}{Notation}%[section]
    \theoremstyle{remark}     \newtheorem{remarque}{Remarque}%[section]
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% END %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
  |separator}

let maker =
  "\\usepackage[href]{ppbase}\n\
   \\begin{document}\n\n\
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\
   \\thispagestyle{empty}\n\n\
   \\maketitle\n\n\
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n\n\
   %\\newpage\n\
   %\\bibliographystyle{abbrv}\n\
   %\\bibliography{refs}\n\n\
   \\end{document}"


let print f s = fprintf f s

let () =
  Arg.parse speclist anon_fun usage_msg;

  if !path = "" then
    (print_endline "Path is required";
    exit 1);

  printf "author : %s\n" !author;
  printf "path   : %s\n" !path;
  printf "title  : %s\n" !title;
  printf "classe : %s\n" !classe;
  let cmd = sprintf "mkdir -p %s" !path in
  let _c : int = Sys.command cmd in
  let cmd = "touch " ^ !path ^ "/ppbase.sty" in
  let _c : int = Sys.command cmd in
  let file_main = open_out (!path ^ "/main.tex") in
  let file_ppbase = open_out (!path ^ "/ppbase.sty") in
  print file_ppbase "%s" ppbase;
  close_out file_ppbase;
  print file_main
    "\\title{%s}\n\
     \\author{%s}\n\
     \\date{%s}\n\
     \\documentclass[a4paper, 10pt]{%s}\n"
    !title !author !date !classe;
  print file_main "%s" maker;
  close_out file_main
