require 'test_helper'

class UserStarEventTest < ActiveSupport::TestCase
  test "relationships" do
    user = users(:jnunemaker)
    star_event = star_events(:bkeepers)
    user_star_event = user_star_events(:jnunemaker_bkeepers)
    assert_equal user, user_star_event.user
    assert_equal star_event, user_star_event.star_event
  end

  test "requires valid state" do
    user_star_event = UserStarEvent.new(state: nil)
    user_star_event.valid?
    errors = user_star_event.errors[:state]
    assert errors.include?("is not included in the list")

    user_star_event = UserStarEvent.new(state: UserStarEvent::States.values.first)
    user_star_event.valid?
    errors = user_star_event.errors[:state]
    assert_not errors.include?("is not included in the list")
  end

  test "requires star_event_id" do
    user_star_event = UserStarEvent.new(star_event_id: nil)
    user_star_event.valid?
    errors = user_star_event.errors[:star_event_id]
    assert errors.include?("can't be blank")
  end

  test "requires user_id" do
    user_star_event = UserStarEvent.new(user_id: nil)
    user_star_event.valid?
    errors = user_star_event.errors[:user_id]
    assert errors.include?("can't be blank")
  end

  test "ensure_imported creates user star event if none existing" do
    user = users(:jnunemaker)
    star_event = create(:star_event)

    assert_difference 'UserStarEvent.count' do
      UserStarEvent.ensure_imported(user, star_event)
    end
  end

  test "ensure_imported does not create duplicates" do
    user = users(:jnunemaker)
    star_event = create(:star_event)
    UserStarEvent.ensure_imported(user, star_event)

    assert_no_difference 'UserStarEvent.count' do
      UserStarEvent.ensure_imported(user, star_event)
    end
  end

  test "ensure_imported raises validation errors" do
    star_event = create(:star_event)
    assert_raises ActiveRecord::RecordInvalid do
      UserStarEvent.ensure_imported(nil, star_event)
    end
  end
end
