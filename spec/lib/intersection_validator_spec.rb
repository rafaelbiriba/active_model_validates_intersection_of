require "spec_helper"
require_relative "../shared.rb"

RSpec.describe IntersectionValidator do
  class BadSetupValidator
    include ActiveModel::Validations
    attr_accessor :list
  end

  context "setup" do
    describe "with neither :in nor :within configuration" do
      it "raises argument error" do
        expect {
          BadSetupValidator.class_eval("validates :list, intersection: true")
        }.to raise_error(ArgumentError)
      end
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

      context "when the model value is an array with nil value" do
        class ListTest
          VALID_ARRAY = ["z", "x", 5 , 6]
          include ActiveModel::Validations
          attr_accessor :list
          validates_intersection_of :list, within: VALID_ARRAY, message: "not valid"
        end
  
        subject { ListTest.new }
  
        it "should return as invalid" do
          subject.list = [nil]
          expect(subject.valid?).to eq(false)
        end
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

      context "when the model value is an array with nil value" do
        class ListTest
          VALID_ARRAY = ["z", "x", 5 , 6]
          include ActiveModel::Validations
          attr_accessor :list
          validates_intersection_of :list, within: VALID_ARRAY, message: "not valid"
        end
  
        subject { ListTest.new }
  
        it "should return as invalid" do
          subject.list = [nil]
          expect(subject.valid?).to eq(false)
        end
      end
    end

    context "validate with lambda" do
      class SomeList
        VALID_ARRAY = ["z", "x", 5 , 6]
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, in: lambda {|a| VALID_ARRAY }, message: "not valid"
      end

      it "is valid" do
        list = SomeList.new
        list.list = ["z"]
        expect(list.valid?).to eq true
      end

      it "is invalid" do
        list = SomeList.new
        list.list = ["G"]
        expect(list.valid?).to eq false
      end
    end

    context "validate with proc" do
      class ProcList
        VALID_ARRAY = ["z", "q", 5 , 3]
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, in: proc { VALID_ARRAY }, message: "not valid"
      end

      it "is valid" do
        list = ProcList.new
        list.list = ["q"]
        expect(list.valid?).to eq true
      end

      it "is invalid" do
        list = ProcList.new
        list.list = [10]
        expect(list.valid?).to eq false
      end
    end

    context "validate with symbol" do
      class SymList
        VALID_ARRAY = ["z", "d", 5 , 6]
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, in: :valid_options, message: "not valid"

        def valid_options
          VALID_ARRAY
        end
      end

      it "is valid" do
        list = SymList.new
        list.list = ["d"]
        expect(list.valid?).to eq true
      end

      it "is invalid" do
        list = SymList.new
        list.list = [8]
        expect(list.valid?).to eq false
      end
    end

    context "validate with value as string" do
      class SomeInvalidList
        include ActiveModel::Validations
        attr_accessor :list
        validates_intersection_of :list, in: proc { ['test'] }, message: "not valid"
      end

      it "causes an exception" do
        list = SomeInvalidList.new
        list.list = "d"
        expect {
          list.valid?
        }.to raise_error(ArgumentError, "value must be an array")
      end
    end
  end
end
