class Simulation 

attr_accessor :cars, :status, :anzahl

def initialize(anzahl=nil)
  puts anzahl
  @anzahl = anzahl.to_i
  @cars = []
  @anzahl.times do
    cars << Car.new
  end
  status = 'aktiv'  
end


end
