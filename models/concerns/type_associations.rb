module TypeAssociations
  def types
    database.find_types(type_refs)
  end
end
