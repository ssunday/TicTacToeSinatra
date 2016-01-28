require 'data_mapper'

#Below code was found on Stack Overflow to make it so an Object property properly updates.
#http://stackoverflow.com/questions/18698331/updating-object-property-in-datamappers
module DataMapper
  module Resource
    def make_dirty(*attributes)
      if attributes.empty?
        return
      end
      unless self.clean?
        self.save
      end
      dirty_state = DataMapper::Resource::PersistenceState::Dirty.new(self)
      attributes.each do |attribute|
        property = self.class.properties[attribute]
        dirty_state.original_attributes[property] = nil
        self.persistence_state = dirty_state
      end
    end
  end
end
