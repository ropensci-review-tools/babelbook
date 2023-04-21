
# babelbook

**Now see [babelquarto](https://github.com/ropensci-review-tools/babelquarto)**

<!-- badges: start -->
<!-- badges: end -->

The goal of babelbook is to try and create the same Quarto HTML book in two languages.
This is a workaround meant to be used for rOpenSci dev guide... until there is an implementation in Quarto as that one can only be better!

See https://github.com/quarto-dev/quarto-cli/issues/275

Here the orchestration script is [orchestration.R](orchestration.R).
I want the language switch to not be added dynamically, because here at least we know for sure where the other language version lives so it is not too hard to add the link in advance.

Later if we get nicer URLs https://github.com/quarto-dev/quarto-cli/issues/2045, 
the orchestration script will need to be amended to first map English files to other language files and every file to its output file, 
so we might be able to keep generating the link to the "other version".
