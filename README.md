# [RENoMafex.github.io](https://RENoMafex.github.io)

This is my personal homepage, it's main purpose is for me to learn a bit of HTML, CSS and JS.

## For those who are here to find out

**Yes**, the HTML files, that are visible on the website are generated using GCC, to be percise, its using the C Preprocessor to insert HTML templates into the files.

#### But how does the C Preprocessor generate valid html?

Lets assume we have an empty folder called `pages` and 2 relevant files:<br>
`index.html`:
```html
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
    <body>
        <!-- some html content -->
         #include "footer.html"
    </body>
</html>
```
`footer.html`:
```html
<div id="footer">
    <!--- footer content -->
</div>
```

Now if you have a C compiler installed, you can use its preprocessor, to automatically copy the contents of the `footer.html` file, right where the `#include "footer.html"` statement lives. For my example i am using `GCC`. The command, to make a file called `pages/index.html` we can run the command <span style="white-space: nowrap">`cpp -P -nostdinc index.html -o pages/index.html`</span>
in the terminal. Lets go through the parts of this command:
<table><tr>
    <th style="white-space: nowrap; text-align: center; font-size: 150%;">Command</th>
    <th style="width: 100%; font-size: 150%;">Explanation</th>
</tr><tr>
    <th style="text-align: center;">cpp</th>
    <th>Starts the C PreProcessor.</th>
</tr><tr>
    <th style="text-align: center;">-P</th>
    <th>Do not generate #line directives. This keeps the file clean of unwanted stuff.</th>
</tr><tr>
    <th style="text-align: center;">-nostdinc</th>
    <th>Do not search standard system include directories.</th>
</tr><tr>
    <th style="text-align: center;">index.html</th>
    <th>The input file.</th>
</tr><tr>
    <th style="white-space: nowrap; text-align: center;">-o pages/index.html</th>
    <th>Specifies the output file.</th>
</tr></table>

So in conclusion this command will in our example tell the C preprocessor, to take that `#include "footer.html"` line inside of `index.html` and replace it with the contents of the `footer.html` file and output a file called `out_index.html`.<br>
For this repo the actual command would be something like <span style="white-space: nowrap">`cpp -P -Isrc/templates -nostdinc src/index.html -o docs/index.html`</span>, where `-Isrc/templates` adds the `src/templates` folder to the include paths, which means, that you can store the templates for lines, which should be replaced inside that folder.

#### But the output files look ugly!
Yes, they do, simply because the C preprocessor doesnt care about indentation, so i use a tool called [tidy](https://www.html-tidy.org/) to fix that.