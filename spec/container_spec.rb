require "spec_helper"

describe TheGame::Container do
  describe ".new" do
    it "initializes with empty food content" do
      content = TheGame::Container.new.food
      expect(content).to be == []
    end
  end

  describe "#add" do
    it "adds added food to content" do
      food = TheGame::Item::Food.new
      container = TheGame::Container.new
      container.add(food)
      expect(container.food).to be == [food]
    end

    it "adds added axe to content" do
      axe = TheGame::Item::Axe.new
      container = TheGame::Container.new
      container.add(axe)
      expect(container.axes).to be == [axe]
    end
  end

  describe "#get_food" do
    it "returns nil if no food" do
      container = TheGame::Container.new
      returned = container.get_food
      expect(returned).to be nil
    end

    it "it returns nil if only axe inside" do
      container = TheGame::Container.new
      axe = TheGame::Item::Axe.new
      container.add(axe)
      returned = container.get_food
      expect(returned).to be nil
    end

    it "returns food if axe and food inside" do
      container = TheGame::Container.new
      axe = TheGame::Item::Axe.new
      container.add(axe)
      food = TheGame::Item::Food.new
      container.add(food)

      returned = container.get_food
      expect(returned).to be_a TheGame::Item::Food
    end

    it "removes food from container, leaves axe inside" do
      container = TheGame::Container.new
      food = TheGame::Item::Food.new
      container.add(food)
      axe = TheGame::Item::Axe.new
      container.add(axe)

      returned = container.get_food
      expect(container.axes).to be == [axe]
      expect(container.food).to be == []
    end

    it "returns food" do
      container = TheGame::Container.new
      food = TheGame::Item::Food.new
      container.add(food)
      returned = container.get_food
      expect(returned).to be_a TheGame::Item::Food
    end

    it "removes food from container if only food inside" do
      food = TheGame::Item::Food.new
      container = TheGame::Container.new
      container.add(food)
      container.get_food
      expect(container.food).to be == []
    end
  end

  describe "#has_food?" do
    it "should return false if container is empty" do
      container = TheGame::Container.new
      expect(container.has_food?).to be false
    end

    it "should return true if container has food" do
      container = TheGame::Container.new
      food = TheGame::Item::Food.new
      container.add(food)
      expect(container.has_food?).to be true
    end
  end

  describe "#food_count" do
    it "is equal to 0 if no food" do
      container = TheGame::Container.new
      expect(container.food_count).to be == 0
    end

    it "is equal to 1 if 1 food added" do
      container = TheGame::Container.new
      food = TheGame::Item::Food.new
      container.add(food)
      expect(container.food_count).to be == 1
    end
  end

  describe "#food_amount" do
    it "is equal to 0 if no food" do
      container = TheGame::Container.new
      expect(container.food_amount).to be == 0
    end

    it "is equal to 1 if 1 food added" do
      container = TheGame::Container.new
      food = TheGame::Item::Food.new
      container.add(food)
      expect(container.food_amount).to be == 0.08333333333333334
    end
  end
end
