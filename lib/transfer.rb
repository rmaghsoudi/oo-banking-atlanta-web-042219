class Transfer
  attr_accessor :sender, :receiver, :status
  attr_reader :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : @status = "rejected"
  end

  def execute_transaction
    if @sender.balance < @amount
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    elsif self.valid? && self.status == "pending"
      @receiver.deposit(@amount)
      @sender.balance -= @amount
      self.status = "complete"
    end
  end

  def reverse_transfer
    if self.status == "complete"
      @receiver.balance -= @amount
      @sender.deposit(@amount)
      self.status = "reversed"
    end
  end

end
