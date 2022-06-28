require "json"

class Person
  attr_reader :first_name, :last_name, :title, :address
  def initialize(first_name, last_name, title, address)
    @first_name = first_name
    @last_name = last_name
    @title = title
    @address = address
  end

  def export(filename)
    File.write(filename, to_json_string)
  end

  def to_json_string
    JSON.dump(
      {
        title: title,
        first_name: first_name,
        last_name: last_name,
        address: address,
      },
    )
  end
end

person = Person.new("John", "Browne", "Mr", "123 Fake Street")
person.export("test.json")

