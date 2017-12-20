require "spec_helper"
require_relative "../shared.rb"

RSpec.describe ActiveModel::Validations::HelperMethods do
  class BadSetup
    include ActiveModel::Validations
    attr_accessor :list
  end

  context "setup" do
    describe "with neither :in nor :within configuration" do
      it "raises argument error" do
        expect {
          BadSetup.class_eval("validates_intersection_of :list")
        }.to raise_error(ArgumentError)
      end
    end
  end

  context "validation" do
    context "with :in option" do
      class List
        VALID_ARRAY = ["z", "x", 5 , 6]
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, in: VALID_ARRAY, message: "not valid"
      end

      let(:valid_partial_array) { List::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

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

    context "with :within option" do
      class ListWithinOption
        VALID_ARRAY = ["z", "x", 5 , 6]
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, within: VALID_ARRAY, message: "not valid"
      end

      let(:valid_partial_array) { ListWithinOption::VALID_ARRAY.sample(2) }
      let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

      subject { ListWithinOption.new }

      context "validation" do
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
