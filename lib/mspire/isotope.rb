require "mspire/isotope/version"

module Mspire
  class Isotope
    class << self
      attr_accessor :element_hash
      def by_element(element)
        element_hash[element]
      end
      alias_method :[], :by_element
    end
    MEMBERS = [
      :atomic_number, 
      :element, 
      :mass_number, 
      :atomic_mass, 
      :relative_abundance, 
      :average_mass, 
      :mono
    ].each {|key| attr_accessor key }

    def initialize(*args)
      MEMBERS.zip(args) {|k,val| self.send("#{k}=", val) }
    end
  end
end


# sets Mspire::Isotope::BY_ELEMENTS and Mspire::Isotope::ISOTOPES
require 'mspire/isotope/neese'
module Mspire
  class Isotope
    BY_ELEMENT = Mspire::Isotope::Neese::BY_ELEMENT
    ISOTOPES = Mspire::Isotope::Neese::ISOTOPES

    self.element_hash = Mspire::Isotope::Neese::BY_ELEMENT
  end
end
