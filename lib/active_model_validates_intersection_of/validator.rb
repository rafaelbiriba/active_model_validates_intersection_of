module ActiveModelValidatesIntersectionOf
  class Validator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      delimiter = options[:in] || options[:within]
      raise(ArgumentError, "An array must be supplied as the :in option of the configuration hash") unless delimiter.kind_of?(Array)

      if (value - delimiter).any?
        record.errors.add(attribute, :inclusion, options.except(:in, :within).merge!(value: value))
      end
    end
  end
end