class TheGame
  class Action
    def self.create(*params)
      new(*params)
    end

    private_class_method :new
  end
end
