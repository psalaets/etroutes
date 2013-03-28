class Route < ActiveRecord::Base
  # Recognized route types. Routes can have one or more of these.
  TYPES = [:boulder, :lead, :toprope]

  attr_accessible :grade, :gym, :location, :name, :rid, :set_by, :url

  def types=(new_types)
    comma_delimited = (TYPES & new_types).join(',')
    write_attribute(:types, comma_delimited)
  end

  def types
    return [] unless types?
    read_attribute(:types).split(',').map(&:to_sym)
  end
end
