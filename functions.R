get_coupdecoeur <- function(file) {
  readxl::read_excel(path = file, skip = 18, n_max = 2) %>%
    tricky::set_standard_names() %>%
    dplyr::select(x_1, cocher_la_case_le_cas_echeant_) %>%
    tidyr::spread(key = x_1, value = cocher_la_case_le_cas_echeant_) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file,
      slug = sub(pattern = "^([[:digit:][:alpha:]\\-]*)\\/.*", replacement = "\\1", x = file), 
      alerte = 1*(!is.na(alerte)), 
      coup_de_coeur = 1*(!is.na(coup_de_coeur))
    )
}
get_coupdecoeur(file = "082569-gendarmerie/82569-Gendarmerie nationale - Mathilde Bras.xlsx")

get_evaluateur <- function(file) {
  readxl::read_excel(path = file) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file
    ) %>%
    dplyr::filter(
      appel_a_manifestation_d_interet_pour_l_intelligence_artificielle_grille_d_analyse_des_candidatures == "Evaluateur :"
    ) %>%
    dplyr::select(file, evaluateur = x_1)
}
get_evaluateur("082569-gendarmerie/82569-Gendarmerie nationale - Mathilde Bras.xlsx")

get_notes <- function(file) {
  readxl::read_excel(path = file, skip = 6) %>%
    tricky::set_standard_names() %>%
    dplyr::mutate(
      file = file, 
      slug = sub(pattern = "^([[:digit:][:alpha:]\\-]*)\\/.*", replacement = "\\1", x = file), 
      note_entre_1_et_5_ = as.numeric(note_entre_1_et_5_)
    ) %>%
    dplyr::filter(grepl(pattern = "^[[:digit:]].*", x = critere)) %>%
    dplyr::select(slug, file, critere, note_entre_1_et_5_, commentaires)
  }  
get_notes(file = "082569-gendarmerie/82569-Gendarmerie nationale - Mathilde Bras.xlsx")

get_review <- function(file) {
  get_notes(file = file) %>%
    dplyr::left_join(
      y = get_evaluateur(file = file), 
      by = "file"
    )
}
