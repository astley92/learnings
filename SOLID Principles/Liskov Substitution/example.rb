class Mail
  attr_reader :title
  def initialize(title:)
    @title = title
  end
end

class DeliveryService
  def deliver_mail
    return Mail.new(title: "Gas Bill")
  end
end

class Fedex < DeliveryService
  def deliver_mail
    puts "Here's your mail, have a great day"
    return Mail.new(title: "Gas Bill")
  end
end

class AustraliaPost < DeliveryService
  def deliver_mail
    puts "Sorry it took 4 weeks, here's your mail"
    return Mail.new(title: "Gas Bill")
  end
end

delivery_person = DeliveryService.new
mail = delivery_person.deliver_mail
puts mail.title

delivery_person = Fedex.new
mail = delivery_person.deliver_mail
puts mail.title

delivery_person = AustraliaPost.new
mail = delivery_person.deliver_mail
puts mail.title
