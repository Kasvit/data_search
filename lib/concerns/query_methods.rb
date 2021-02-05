module QueryMethods
  methods_array = %i[languages types authors]
    methods_array.each do |attribute|
      define_method :"find_#{attribute}" do |refs|
        $database.send(:"#{attribute}").select{|e| refs.include?(e.key)}
      end
    end
end
