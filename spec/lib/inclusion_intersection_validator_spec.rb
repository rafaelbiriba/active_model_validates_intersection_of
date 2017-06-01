require "spec_helper"
require_relative "../shared.rb"

RSpec.describe ActiveModelValidatesIntersectionOf::Validator do
  class BadSetupValidator
    include ActiveModel::Validations
    attr_accessor :list
    validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:list]
  end

  let(:badsetup) { BadSetupValidator.new }

  context "setup" do
    describe "without an :in configuration" do
      it_behaves_like "invalid configuration"
    end
  end

  VALID_ARRAY = ["a", "b", 1 , 2]

  let(:valid_partial_array) { VALID_ARRAY.sample(2) }
  let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

  class ListValidator
    include ActiveModel::Validations
    attr_accessor :list
    validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:list], in: VALID_ARRAY, message: "not valid"
  end

  subject { List.new }

  context "validation" do
    describe "with a valid list" do
      it_behaves_like "valid object"
    end

    describe "with an invalid list" do
      it_behaves_like "invalid object"
    end
  end
end
