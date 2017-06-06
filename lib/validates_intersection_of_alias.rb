module ActiveModel::Validations::HelperMethods
  def validates_intersection_of(*attr_names)
    validates_with ActiveModelValidatesIntersectionOf::Validator, _merge_attributes(attr_names)
  end
end
