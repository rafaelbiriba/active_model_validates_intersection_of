module ActiveModelValidatesIntersectionOf
  class Validator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      delimiter = options[:in]
      raise(ArgumentError, "An array must be supplied as the :in option of the configuration hash") unless delimiter.kind_of?(Array)
      if (value - delimiter).any?
        record.errors.add(attribute, :inclusion, options.except(:in).merge!(value: value))
      end
    end
  end
end
