class Search
  attr_reader :database

  # support for different databases with same format
  def initialize(database)
    @database = database
  end

  def find(query:)
    # prepare search value and options
    value = split_input_value(query.to_s.strip)
    options = value.select { |s| s.start_with?("-") }.map! { |o| o.delete_prefix("-") }
    value.reject! { |s| s.start_with?("-") }

    # reject all language_refs by some options
    rejected_refs = database.types.where(name: options).map(&:language_refs).flatten

    # search exact language_refs by name
    language_full_refs = database.languages.exact_where(name: value).pluck(:key)

    # search language_refs by different fields or not exact name
    part_refs = if language_full_refs.none?
      authors_part_refs  = database.authors.where(name: value).map(&:language_refs).flatten
      types_part_refs    = database.types.exact_where(name: value).map(&:language_refs).flatten
      language_part_refs = database.languages.where(name: value).pluck(:key)
      (authors_part_refs + types_part_refs + language_part_refs)
    else
      []
    end

    # prepare searched language_refs
    refs = (language_full_refs + part_refs - rejected_refs)
    database.find_languages(refs)
  end

  private

  def split_input_value(input)
    # check if string have exact matches with \", separate to own strings and remove blank strings
    if input.include?("\"")
      input.split(/ "|"| -/).map { |e| e.delete('\"') }
    else
      input.split(/ -| /)
    end.reject(&:empty?)
  end
end
