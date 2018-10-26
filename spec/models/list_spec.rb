require 'rails_helper'

RSpec.describe List, type: :model do
 describe '#complete_all_tasks!' do
  it 'should mark all task from the list as complete' do
    list = List.create(name: "Shopping")
    Task.create(complete: false, list_id: list.id, name: "Milk")
    Task.create(complete: false, list_id: list.id, name: "Eggs")
    
    list.complete_all_tasks!

    list.tasks.each do |task|
      expect(task.complete).to eq(true)
   end
  end
 end

 describe "#snooze_all_tasks" do
     it "should snooze each task on a list" do
       list = List.create(name: "Pet Peeves")

       times = [5.hours.ago, Time.now, 37.minutes.from_now]
       times.each do |time|
         Task.create(deadline: time, list_id: list.id)
       end

       list.snooze_all_tasks!

       list.tasks.order(:id).each_with_index do |task, index|
         expect(task.deadline).to eq(times[index] + 1.hour)
       end
     end
   end

 describe "#total_duration" do
     it "should return total duration of lists" do
       list = List.create(name: "Dancing da da da")
       
       Task.create(list_id: list.id, duration: 30)
       Task.create(list_id: list.id, duration: 25)

       expect(list.total_duration ).to eq(55)
     end
   end

  describe '#incomplete_tasks' do
    it 'should return the incomplete tasks' do
      list = List.create(name: "Shopping")

    task_1 = Task.create(list_id: list.id, complete: true)
    task_2 = Task.create(list_id: list.id, complete: true)
    task_3 = Task.create(list_id: list.id, complete: false)
    task_4 = Task.create(list_id: list.id, complete: false)

    expect(list.incomplete_tasks).to match_array([task_4, task_3])
    expect(list.incomplete_tasks.count).to eq(2)

     list.incomplete_tasks.each do |task|
       expect(task.complete).to eq(false)
     end
   end
 end


    describe '#favorite_tasks' do
      it 'should return the favorite tasks' do
        list = List.create(name: "Shopping")

       task_1 = Task.create(list_id: list.id, favorite: false)
       task_2 = Task.create(list_id: list.id, favorite: true)
       task_3 = Task.create(list_id: list.id, favorite: false)
       task_4 = Task.create(list_id: list.id, favorite: true)

       expect(list.incomplete_tasks).to match_array([task_4, task_3])
       expect(list.incomplete_tasks.count).to eq(2)

       list.favorite_tasks.each do |task|
          expect(task.favorite).to be(true)
       end
    end
  end
end




