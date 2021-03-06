module Carmmunity
  class Rider

    #@@riders = []

    attr_reader :rider_id, :name, :phone_number

    def initialize(rider_hash)
      @rider_id = rider_hash[:rider_id]
      @name = rider_hash[:name]
      @phone_number = rider_hash[:phone_number]
    end

    def trips_taken
      trips = Trip.rider_trips(@rider_id)
      return trips
    end


    def previous_drivers
      drivers = trips_taken.map { |trip| Driver.find(trip.driver_id) }
      return drivers
    end


    def self.find(id)

      self.all.select do |rider|

        return rider if rider.rider_id == id
      end
      raise ArgumentError.new "#{id} returned no results"
    end #end self.find



    def self.all

      @@riders = []

      if @@riders.length == 0


        CSV.read("support/riders.csv").each do |row|
          rider = {
            rider_id: row[0].to_i,
            name: row[1],
            phone_number: row[2]
          }

          @@riders << Carmmunity::Rider.new(rider)
        end
      end

      return @@riders
    end #end of self.all

  end #end of class
end #end of module
