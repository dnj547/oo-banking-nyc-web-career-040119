require 'pry'
class Transfer
  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if self.valid? && @status == "pending" && (@sender.balance - @amount > 0)
      @receiver.deposit(@amount)
      @sender.deposit(-@amount)
      @status = "complete"

    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.valid? && @status == "complete" && (@receiver.balance - @amount > 0)
      @sender.deposit(@amount)
      @receiver.deposit(-@amount)
      @status = "reversed"

    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

end
