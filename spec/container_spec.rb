require "spec_helper"

describe TheGame::Container do
  describe ".new" do
    it "initializes with empty content" do
      content = TheGame::Container.new.content
      expect(content).to be == []
    end
  end

  describe "#add" do
    it "adds added items to content" do
      food = TheGame::Item::Food.new
      container = TheGame::Container.new
      container.add(food)
      expect(container.content).to be == [food]
    end
  end

  describe "#get_food" do
    it "returns food" do
      food = TheGame::Item::Food.new
      container = TheGame::Container.new
      container.add(food)
      returned = container.get_food
      expect(returned).to be_a TheGame::Item::Food
    end

    it "removes food from container" do
      food = TheGame::Item::Food.new
      container = TheGame::Container.new
      container.add(food)
      container.get_food
      expect(container.content).to be == []
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
