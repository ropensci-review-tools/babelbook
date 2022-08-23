
if (fs::dir_exists("docs")) fs::dir_delete("docs")
quarto::quarto_render(as_job = FALSE)

temporary_directory <- withr::local_tempdir()
fs::dir_copy(getwd(), temporary_directory)
config <- yaml::read_yaml(file.path(temporary_directory, "babelbook", "_quarto.yml"))
config$lang <- "fr"
# Here there could be some logic not replacing if there is no .fr equivalent
config$book$chapters <- gsub("\\.qmd", ".fr.qmd", config$book$chapters)
yaml::write_yaml(config, file.path(temporary_directory, "babelbook", "_quarto.yml"))
quarto::quarto_render(file.path(temporary_directory, "babelbook"), as_job = FALSE)
fs::dir_copy(file.path(temporary_directory, "babelbook", "docs"), file.path("docs", "fr"))

# Add the language switching part
add_link <- function(path, lang = "en") {
  html <- xml2::read_html(path)
  sidebar <- xml2::xml_find_all(html, "//div[@id='quarto-margin-sidebar']")
  
  if (lang == "en") {
    new_path <- sub("\\...\\.html", ".html", basename(path))
    xml2::xml_add_child(
      sidebar,
      "a",
      sprintf("Version in %s", lang),
      href = sprintf("/babelbook/%s", new_path)
    )
  } else {
    new_path <- fs::path_ext_set(basename(path), sprintf(".%s.html", lang))
    xml2::xml_add_child(
      sidebar,
      "a",
      sprintf("Version in %s", lang),
      href = sprintf("/babelbook/%s/%s", lang, new_path)
    )
  }
  
  
  xml2::write_html(html, path)
}

purrr::walk(fs::dir_ls("docs", glob = "*.html"), add_link, lang = "fr")
purrr::walk(fs::dir_ls("docs/fr", glob = "*.html"), add_link, lang = "en")
