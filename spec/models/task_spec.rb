require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "#toggle_complete!" do
    it "should switch complete to false if it was true" do
      task = Task.create(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end

    it "should switch complete to true if it was false" do
      task = Task.create(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
  end

  describe '#toggle_favorite!' do 
    it 'should switch to your favorite if it was not' do 
      task = Task.create(favorite: true)
      task.toggle_favorite!
      expect(task.favorite).to eq(false)
    end

    it 'should switch to not your favorite if it was' do
      task = Task.create(favorite: false)
      task.toggle_favorite!
      expect(task.favorite).to eq(true)
    end
  end

  describe '#overdue?' do
    it 'should return true if the deadline is earlier than now' do
      task = Task.create(deadline: 1.day.ago) 
      expect(task.overdue?).to eq(true)
    end

    it 'should return if deadline has not passed' do
      task = Task.create(deadline: 1.day.from_now)
      expect(task.overdue?).to eq(false)
    end
  end 

  describe '#increment_priority!' do
    it 'should increase the priority' do
      task = Task.create(priority: 5)
      task.increment_priority!
      expect(task.priority).to eq(6)
    end

    it 'should not increment past 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end

  describe '#decrease_priority!' do
    it 'should decrease priority' do
      task = Task.create(priority: 5)
      task.decrement_priority!
      expect(task.priority).to eq(4)
    end

    it 'should decrease the priority' do
      task = Task.create(priority: 1)
      task.decrement_priority!
      expect(task.priority).to eq(1)
    end
  end

  describe '#snooze_hour!' do
    it 'should push deadline back by one hour' do
      time = Time.now
      task = Task.create(deadline: time)
      task.snooze_hour!
      expect(task.deadline).to eq(time + 1.hour)
    end
  end
end