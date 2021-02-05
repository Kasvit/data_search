module AuthorAssociations
  def authors
    database.find_authors(author_refs)
  end
end
