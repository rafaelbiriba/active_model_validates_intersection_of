module ActiveModelValidatesIntersectionOf
  class Validator < ActiveModel::EachValidator
    ERROR_MESSAGE = "An object with the method #include? or a proc, lambda or symbol is required, " \
                    "and must be supplied as the :in (or :within) option"

    def check_validity!
      unless delimiter.respond_to?(:include?) || delimiter.respond_to?(:call) || delimiter.respond_to?(:to_sym)
        raise ArgumentError, ERROR_MESSAGE
      end
    end

    def validate_each(record, attribute, value)
      raise ArgumentError, "value must be an array" unless value.is_a?(Array)
      
      if (value - members(record)).size > 0
        record.errors.add(attribute, :inclusion, **options.except(:in, :within).merge!(value: value))
      end
    end

    private 

    def members(record)
      members = if delimiter.respond_to?(:call)
        delimiter.call(record)
      elsif delimiter.respond_to?(:to_sym)
        record.send(delimiter)
      else
        delimiter
      end
    end

    def delimiter
      @delimiter ||= options[:in] || options[:within]
    end
  end
end
