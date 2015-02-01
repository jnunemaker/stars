module FixtureFileHelpers
  def fixture_file(name)
    Rails.root.join("test", "fixtures", "webmock", name).read
  end
end
