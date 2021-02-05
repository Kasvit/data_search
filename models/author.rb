require_relative "./model"
require_relative "./concerns/language_associations"

class Author < Model
  include LanguageAssociations

  def initialize(name:)
    super(key: SecureRandom.hex(10), name: name, language_refs: [])
  end
end
