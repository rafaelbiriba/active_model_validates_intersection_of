require "spec_helper"
require_relative "../shared.rb"

RSpec.describe ActiveModel::Validations::HelperMethods do
  class BadSetup
    include ActiveModel::Validations
    attr_accessor :list
    validates_intersection_of :list
  end

  let(:badsetup) { BadSetup.new }

  context "setup" do
    describe "without an :in configuration" do
      it_behaves_like "invalid configuration"
    end
  end

  VALID_ARRAY = ["z", "x", 5 , 6]

  let(:valid_partial_array) { VALID_ARRAY.sample(2) }
  let(:invalid_partial_array) { valid_partial_array + ["invalid"] }

  class List
    include ActiveModel::Validations
    attr_accessor :list
    validates_intersection_of :list, in: VALID_ARRAY, message: "not valid"
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
