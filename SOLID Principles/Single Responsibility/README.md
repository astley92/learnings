# Single Responsibility

The single-responsibility principle (SRP) is a computer-programming principle that states that every module, class or function in a computer program should have responsibility over a single part of that program's functionality, and it should encapsulate that part. All of that module, class or function's services should be narrowly aligned with that responsibility.

## Laymen's Terms

Every class, module or function in a program should have one and only one responsiblity.

## Why Is It Important?

If everything, to an extent, in your program is broken down and segregated by responsibilty, making changes at a later date become much easier. Future changes become easier to implement because of multiple reasons, including:

- The code is more readable, you can tell exactly what a a certain class does.
- The amount of pre planning and thinking is decreased. Everything is already broken down by responsibility so it should be easier to see where a change is required to achieve your goal.

This also means that future changes to the code are less risky because the required change is easier to see. Because the readability of the code is increased and the complexity is decreased, the chance that your modules/classes will result in unexpected side effects is reduced.

## Example

For almost all of these example, I'll begin with an example of something that violates the given principle and then we can refactor on those "bad" examples in order to fit the principle. For the single responsibility principle, an example that makes sense would be the following `Person` class.

```ruby
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
```

```json
// ./test.json
{"title":"Mr","first_name":"John","last_name":"Browne","address":"123 Fake Street"}
```

As you can see here, our example does work and the persons details are exported to json, but, our Person class is responsible for everything!
- Serialization from a person to a json string
- Writing json string to a file

If the required behaviour were to change, say we wanted a CSV instead of a JSON file, almopst all methods on the Person class would need to change which, following this principle, doesn't make sense.

If I try to explain the entire purpose of the person class in one sentence it might look something like this.

***The puropse of the Person class is to encapsulate all details of a person and serialize itself to a json string and export itself to a json file.***

## Credits
