class SimpleJob
  @queue = :maxcount

  def self.perform(mass)
    # здесь делаем важные и полезные вещи
    #testq = Testq.find(mass[0])
    #p "---#{testq.inspect}---"
    #testq.commentq="#{testq.commentq}, #{mass[1]}"
    #testq.save
    sleep(rand(1...5))
    puts "Job is ok! #{mass[0]}   #{mass[1]}"
  end
end