require_relative "./model"
require_relative "./concerns/author_associations"
require_relative "./concerns/type_associations"

class Language < Model
  include AuthorAssociations
  include TypeAssociations

  def initialize(name:, type_refs: [], author_refs: [])
    super(key: SecureRandom.hex(10), name: name, type_refs: type_refs, author_refs: author_refs)
  end

  def build_associations
    types.each {|e| e.language_refs << self.key}
    authors.each {|e| e.language_refs << self.key}
  end

  # show more details
  def to_s
    {
      name: name,
      type: types.map{ |t| t.name },
      designed_by: authors.map{ |t| t.name }
    }
  end
end
