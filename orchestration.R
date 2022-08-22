fs::dir_delete("_book")
quarto::quarto_render()

temporary_directory <- withr::local_tempdir()
fs::dir_copy(getwd(), temporary_directory)
config <- yaml::read_yaml(file.path(temporary_directory, "babelbook", "_quarto.yml"))
config$lang <- "fr"
# Here there could be some logic not replacing if there is no .fr equivalent
config$book$chapters <- gsub("\\.qmd", ".fr.qmd", config$book$chapters)
yaml::write_yaml(config, file.path(temporary_directory, "babelbook", "_quarto.yml"))
quarto::quarto_render(file.path(temporary_directory, "babelbook"))
fs::dir_copy(file.path(temporary_directory, "babelbook", "_book"), file.path("_book", "fr"))

# TODO: add the language switching part