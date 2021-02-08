require_relative "./concerns/query_methods"

class Database
  include QueryMethods

  attr_reader :languages, :types, :authors, :data

  # initialize database based on file_path
  def initialize(file_path)
    @languages = []
    @types     = []
    @authors   = []
    @data      = JSON.parse(File.open(file_path).read)
  rescue Errno::ENOENT
    raise FileMissingError, "can`t find file"
  rescue JSON::ParserError
    raise FileParsingError, "Invalid file"
  end

  # Find or create new Author by name
  def type(name)
    types.detect{|e| e.name == name} || (e = Type.new(name: name); types << e; e)
  end

  # Find or create new Author by name
  def author(name)
    authors.detect{|e| e.name == name} || (e = Author.new(name: name); authors << e; e)
  end

  # create objects from data
  def populate_database
    data.each do |record|
      # record = {
      #   "Name": "Ada",
      #   "Type": "Compiled, Imperative, Procedural, Object-oriented class-based",
      #   "Designed by": "Tucker Taft, Jean Ichbiah"
      # }
      type_refs   = record["Type"].to_s.split(", ").collect{|e| type(e).key}
      author_refs = record["Designed by"].to_s.split(", ").collect{|e| author(e).key}

      # creating new language with associations
      language = Language.new(
        name: record["Name"],
        type_refs: type_refs,
        author_refs: author_refs
      )

      language.build_associations

      languages << language
    end
  end
end
