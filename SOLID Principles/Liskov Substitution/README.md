# LISKOV Substitution

If S is a subtype of T, then objects of type T in a program may be replaced with objects of type S without altering any of the desirable properties of that program.

## Laymen's Terms

You should be able to replace an object with a subtype of that object without breaking shit.

## Important Points

- An overriden method on the subclass needs to accept the same parameters as it superclass method.
- An overriden method on the subclass needs to return the same type as it superclass method.
  - Or, following this principle, a subclass of the type that is returned by the superclass

## Why Is It Important?

This principle aims to enforce consistency so that the parent Class or its child Class can be used in the same way without any errors. This makes code easier for future programmers to work with and understand while limiting the risk that a class will be used somewhere it was not intended to be used.

## Example

Let's say we have a generic class `DeliveryService` who's purpose is to deliver mail. It might look like something like this.

```ruby
class DeliveryService
  def deliver_mail
    # The return keyword isn't needed here but I've used it to
    # keep the examples super explicit and easy to follow.
    return Mail.new(title: "Gas Bill")
  end
end
```

and be used like this

```ruby
delivery_person = DeliveryService.new
mail = delivery_person.deliver_mail
puts mail.title # The Mail class implements #title

### OUTPUT
# Gas Bill
```

Later on, we might decide the subtleties of mail delivery are too complex for one generic class and so we create two subclasses, `AustraliaPost` and `Fedex`.

Let's implement `Fedex` first

```ruby
class Fedex < DeliveryService
  def deliver_mail
    puts "Here's your mail, have a great day"
    return Mail.new(title: "Gas Bill")
  end
end
```

If we check our current code and make sure everything works...

```ruby
delivery_person = Fedex.new
mail = delivery_person.deliver_mail
puts mail.title

### OUTPUT
# Here's your mail, have a great day
# Gas Bill
```
We can see that `DeliveryService` could be replaced by `Fedex` without breaking any code and our example still works.

It accepts the same arguments (none) and returns the same type `Mail`. `Fedex` is just a bit friendlier and has a nice greeting to go along with the mail.

Now Let's implement AustraliaPost, another subclass of `DeliveryService`

```ruby
class AustraliaPost < DeliveryService
  def deliver_mail
    return nil
  end
end
```

Following my real world experiences, Australia Post typically struggles with delivering mail correctly and so we've mimicked that by returning `nil` from the `deliver_mail` class.

If we were to substitute `AustraliaPost` in place of the `DeliveryService` in our example, we get an error!

```ruby
delivery_person = AustraliaPost.new
mail = delivery_person.deliver_mail
puts mail.title

### OUTPUT
# undefined method `title' for nil:NilClass (NoMethodError)
```

We've broken our code and, as such, have clearly violated the LISKOV principle because our superclass `DeliveryService` cannot be replaced by an object of it's subclass `AustraliaPost`

It's a simple fix though

```ruby
class AustraliaPost < DeliveryService
  def deliver_mail
    puts "Sorry it took 4 weeks, here's your mail"
    return Mail.new(title: "Gas Bill")
  end
end
```
*I did have `sleep(4.weeks)` in there but was unsure if anyone would copy/paste and run this so a puts will have to do* 😬

```ruby
delivery_person = AustraliaPost.new
mail = delivery_person.deliver_mail
puts mail.title

### OUTPUT
# Sorry it took 4 weeks, here's your mail
# Gas Bill
```

And by ensuring that the subclasses of `DeliveryService` behave in the same manner, return the same type and accept the same arguments, we're now in line with the LISKOV principle and our code is much more resilient and consistent because of it.
