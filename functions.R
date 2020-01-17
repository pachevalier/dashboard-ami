get_coupdecoeur <- function(file) {
  suppressMessages(
  readxl::read_excel(path = file, skip = 17, n_max = 2) %>%
    tricky::set_standard_names() %>%
    dplyr::rename(x_1 = `_1`) %>%
    dplyr::select(x_1, cocher_la_case_le_cas_echeant_) %>%
    tidyr::spread(key = x_1, value = cocher_la_case_le_cas_echeant_) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file,
      slug = sub(pattern = "^([[:digit:][:alpha:]\\-]*)\\/.*", replacement = "\\1", x = file), 
      alerte = 1*(!is.na(alerte)), 
      coup_de_coeur = 1*(!is.na(coup_de_coeur))
    )
  )
}
get_coupdecoeur(file = "449453-EFS/449453-AF.xlsx")

get_accompagnement <- function(file) {
  suppressMessages(
  readxl::read_excel(path = file, skip = 22, n_max = 2) %>%
    tricky::set_standard_names() %>%
    dplyr::rename(x_1 = `_1`) %>%
    dplyr::select(x_1, cocher_la_case) %>%
    tidyr::spread(key = x_1, value = cocher_la_case) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file,
      slug = sub(pattern = "^([[:digit:][:alpha:]\\-]*)\\/.*", replacement = "\\1", x = file), 
      accompagnement_scientifique = 1*(!is.na(accompagnement_scientifique)), 
      accompagnement_technique_et_metier = 1*(!is.na(accompagnement_technique_et_metier)) 
    )
  )
}
get_accompagnement(file = "449453-EFS/449453-AF.xlsx")

get_evaluateur <- function(file) {
  suppressMessages(
  readxl::read_excel(path = file) %>%
    tricky::set_standard_names() %>%
    dplyr::rename(x_1 = `_2`) %>%
    dplyr::mutate(
      file = file
    ) %>%
    dplyr::filter(
      appel_a_manifestation_d_interet_pour_l_intelligence_artificielle_grille_d_analyse_des_candidatures == "Evaluateur :"
    ) %>%
    dplyr::select(file, evaluateur = x_1)
  )
}
get_evaluateur(file = "449453-EFS/449453-AF.xlsx")

get_notes <- function(file) {
  suppressMessages(
  readxl::read_excel(path = file, skip = 6) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file, 
      slug = sub(pattern = "^([[:digit:][:alpha:]\\-]*)\\/.*", replacement = "\\1", x = file), 
      note_entre_1_et_5_ = as.numeric(note_entre_1_et_5_)
    ) %>%
    dplyr::filter(grepl(pattern = "^[[:digit:]].*", x = critere)) %>%
    dplyr::select(slug, file, critere, note_entre_1_et_5_, commentaires)
    )
  }  
get_notes(file = "449453-EFS/449453-AF.xlsx")

get_review <- function(file) {
  get_notes(file = file) %>%
    dplyr::left_join(
      y = get_evaluateur(file = file), 
      by = "file"
    )
}
