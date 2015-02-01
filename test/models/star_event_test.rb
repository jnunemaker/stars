require 'test_helper'

class StarEventTest < ActiveSupport::TestCase
  test "event_id must be unique" do
    assert_difference "StarEvent.count" do
      StarEvent.create(event_id: "asdf")
    end

    assert_raises ActiveRecord::RecordNotUnique do
      StarEvent.create(event_id: "asdf")
    end
  end

  test "requires event_id" do
    star_event = StarEvent.new(event_id: nil)
    star_event.valid?
    assert star_event.errors[:event_id].include?("can't be blank")
  end

  test "find_or_create_for_event creates event if it does not exist" do
    assert_difference 'StarEvent.count' do
      event = build(:github_event)
      star_event = StarEvent.find_or_create_for_event(event)
      assert_equal event.id, star_event.event_id
    end
  end

  test "find_or_create_for_event finds event if already exists" do
    event = build(:github_event)
    StarEvent.find_or_create_for_event(event)

    assert_no_difference 'StarEvent.count' do
      star_event = StarEvent.find_or_create_for_event(event)
      assert_equal event.id, star_event.event_id
    end
  end
end
