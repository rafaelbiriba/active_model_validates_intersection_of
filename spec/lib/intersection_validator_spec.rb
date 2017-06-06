require "spec_helper"
require_relative "../shared.rb"

RSpec.describe IntersectionValidator do
  class BadSetupValidator
    include ActiveModel::Validations
    attr_accessor :list
    validates :list, intersection: true
  end

  let(:badsetup) { BadSetupValidator.new }

  context "setup" do
    describe "with neither :in nor :within configuration" do
      it_behaves_like "invalid configuration"
    end
  end

  context "validation" do
    context "with :in option" do
      class ListAliasValidator
        VALID_ARRAY = ["a", "b", 1 , 2]
        include ActiveModel::Validations
        attr_accessor :list
        validates :list, intersection: { in: VALID_ARRAY, message: "not valid" }
      end

      let(:valid_partial_array) { ListAliasValidator::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }
      subject { ListAliasValidator.new }

      describe "with a valid list" do
        it_behaves_like "valid object"
      end

      describe "with an invalid list" do
        it_behaves_like "invalid object"
      end
    end

    context "with :within option" do
      class WithinOptionListAliasValidator
        VALID_ARRAY = ["a", "b", 1 , 2]
        include ActiveModel::Validations
        attr_accessor :list
        validates :list, intersection: { within: VALID_ARRAY, message: "not valid" }
      end

      let(:valid_partial_array) { WithinOptionListAliasValidator::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

      subject { WithinOptionListAliasValidator.new }

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
