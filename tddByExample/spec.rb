require 'rspec'
# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:
# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.
# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.
# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  def full_name
    build_name_string([@first_name, @middle_name, @last_name], ' ')
  end

  def initials
    build_name_string([first_name_initial, middle_initial, last_name_initial])
  end

  def full_name_with_middle_initial
    build_name_string([@first_name, middle_initial, @last_name], ' ')
  end

  private
    def middle_initial
      @middle_name[0].capitalize + '.'
    end

    def first_name_initial
      @first_name[0].capitalize + '.'
    end

    def last_name_initial
      @last_name[0].capitalize + '.'
    end

    def middle_name_given?
      @middle_name && !@middle_name.strip.empty?
    end

    # @param [Hash] name_strings - REQUIRES 2nd param to be middle name
    # @param [String] delimiter
    # @return [String]
    def build_name_string(name_strings, delimiter='')
      unless middle_name_given?
        name_strings.delete_at(1) # delete the middle name
      end
      name_strings.join(delimiter)
    end
end

RSpec.describe Person do

  before :all do
    @person = Person.new(first_name: 'Joshua', middle_name: 'David', last_name: 'Weaver');
  end

  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      expect(@person.full_name).to eq('Joshua David Weaver');
    end

    it "does not add extra spaces if middle name is missing" do
      person = Person.new(first_name: 'Joshua', last_name: 'Weaver');
      expect(person.full_name).to eq('Joshua Weaver')
    end
  end

  describe "#full_name_with_middle_initial" do
    it "concatenates first, middle and last name, but use Initial with period for middle" do
      expect(@person.full_name_with_middle_initial).to eq('Joshua D. Weaver')
    end
  end

  describe "#initials" do
    it "returns initials for first, middle, last name with periods after each letter and no spaces" do
      expect(@person.initials).to eq('J.D.W.')
    end
  end
end