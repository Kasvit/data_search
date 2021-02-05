module LanguageAssociations
  def languages
    database.find_languages(language_refs)
  end
end
