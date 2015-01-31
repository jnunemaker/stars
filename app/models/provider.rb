class Provider
  NotFound = Class.new(StandardError)

  def self.all
    @all ||= [
      new(id: 1, name: "github"),
    ]
  end

  def self.valid_ids
    all.map(&:id)
  end

  def self.find(id)
    all.detect { |record| record.id == id.to_i } ||
    raise(NotFound, "Could not find record with id of #{id.inspect}")
  end

  def self.find_by_name(name)
    all.detect { |record| record.name == name.to_s } ||
    raise(NotFound, "Could not find record with name of #{name.inspect}")
  end

  def self.github
    @github ||= find(1)
  end

  # Public
  attr_reader :id

  # Public
  attr_reader :name

  def initialize(attrs = {})
    @id = attrs.fetch(:id).to_i
    @name = attrs.fetch(:name).to_s
  end
end
