class MessageJob
  @queue = :messages
  def self.perform(mass)

    puts "MessagesJob is ok! #{mass.inspect} "
    #endnow

  end
 end