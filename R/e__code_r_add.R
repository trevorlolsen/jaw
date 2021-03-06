#' e__code_r_add
#'
#' @param session_name TODO
#' @param outer_env TODO
#'
#' @return TODO

e__code_r_add <- function(session_name,outer_env=totem) {
  session_tag <- RGtk2::gtkEntryGetText(outer_env[[session_name]]$data_view_list$file_source_entry)

  file_content <- read_text_file(totem$code_R)
  if (grepl(paste0("#start@", session_tag), file_content,
    fixed = T
  ) == F) {
    cat(paste0("#start@", session_tag, "\n\n#end@", session_tag, "\n", file_content), file = totem$code_R)
  }
}


#' e__code_r_add_cmd
#'
#' @param session_name TODO
#' @param cmd TODO
#' @param outer_env TODO
#'
#' @return TODO

e__code_r_add_cmd <- function(session_name, cmd,outer_env=totem) {
  session_tag <- RGtk2::gtkEntryGetText(outer_env[[session_name]]$data_view_list$file_source_entry)
  file_content <- read_text_file(totem$code_R)


  end_pat <- paste0("#end@", session_tag)

  if (grepl(end_pat, file_content, fixed = T) == F) {
    outer_env$u__code_r_add(session_name)
    file_content <- read_text_file(totem$code_R)
  }
  file_content <- gsub(end_pat, paste0(cmd, "\n", end_pat), file_content, fixed = T)

  cat(file_content, file = totem$code_R)
  utils::file.edit(totem$code_R)
}
