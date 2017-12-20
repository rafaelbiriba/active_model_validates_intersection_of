require "spec_helper"
require_relative "../shared.rb"

RSpec.describe ActiveModelValidatesIntersectionOf::Validator do
  class BadSetupValidator
    include ActiveModel::Validations
    attr_accessor :list
  end

  context "setup" do
    describe "with neither :in nor :within configuration" do
      it "raises argument error" do
        expect {
        BadSetupValidator.class_eval("validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:list]")     
        }.to raise_error(ArgumentError)
      end
    end
  end

  context "validation" do
    context "with :in option" do
      class ListValidator
        VALID_ARRAY = ["a", "b", 1 , 2]
        include ActiveModel::Validations
        attr_accessor :list
        validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:list], in: VALID_ARRAY, message: "not valid"
      end

      let(:valid_partial_array) { ListValidator::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }
      subject { ListValidator.new }

      describe "with a valid list" do
        it_behaves_like "valid object"
      end

      describe "with an invalid list" do
        it_behaves_like "invalid object"
      end
    end

    context "with :within option" do
      class WithinOptionListValidator
        VALID_ARRAY = ["a", "b", 1 , 2]
        include ActiveModel::Validations
        attr_accessor :list
        validates_with ActiveModelValidatesIntersectionOf::Validator, attributes: [:list], within: VALID_ARRAY, message: "not valid"
      end

      let(:valid_partial_array) { WithinOptionListValidator::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

      subject { WithinOptionListValidator.new }

      context "validation with :in option" do
        describe "with a valid list" do
          it_behaves_like "valid object"
        end

        describe "with an invalid list" do
          it_behaves_like "invalid object"
        end
      end
    end
  end
end
