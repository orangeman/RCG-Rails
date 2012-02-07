class Car 
  
  @@id = 0
  
  attr_accessor :id, :route
  
  def initialize
    @id = @@id += 1
    @route = Route.all[rand*Route.all.size]
    @route.rides << self
  end
  
  def to_s
    "Auto #{@id}: #{@route}"
  end
  
  def to_text
    @route.to_text
  end
  
  
  def detour
    @route.detour
  end
  
  def distance
    @route.distance
  end
  
  
  def time_to_pickup
    @route.time_to_pickup
  end
  
  
  
  def current_position
    route.from
  end
  
  
  
end
