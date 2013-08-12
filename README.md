gitline
=======

Generate timeline statistics for a git repository and display in a web interface.

The approach is pretty straightforward -- we get a log of who committed how many lines on each file, then we aggregate by each level of the filesystem tree, make a color-coded plot for each file, and display it all in a jquery treetable.

Usage
=====

(1) Configure .mailmap for your local repo until each author always appears the same using %aN (see git-log, git-blame, etc).

(2) Change to this directory and configure gitline. The first argument is a relative or absolute path to the repository (for use with --git-dir). The second argument is an optional url prefix to use so that files can be displayed. For github this is something like "https://github.com/krivard/gitline/blob/master/".

gitline $ ./configure.sh path/to/local/git/repo/.git http://domain.com/path/to/display/file/

If you provide no arguments to configure.sh, it will configure gitline to generate documentation for the gitline project. This is a useful demo.


(3) Edit gitline.conf until the colors for each author are to your liking. Up to 14 authors are supported automatically but only the first 4 have been rigorously tested. 

(4) Make:

gitline $ make

"Empty x/y range" messages are normal; gnuplot is whiny but generally does the Right Thing.

(5) Browse to gitline/www/index.html and review the result. Make stylesheet edits in www/style.css. If you wish to change the colors for authors, you'll need to make those changes in gitline.conf and then `make clean all` to regenerate plots and css files.