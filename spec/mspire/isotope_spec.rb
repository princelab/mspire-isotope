require 'spec_helper'

require 'mspire/isotope'

describe Mspire::Isotope do

  specify 'Mspire::Isotope[] accesses isotopes by element' do
    carbon12 = Mspire::Isotope[:C][0]  # the lightest carbon isotope
    carbon12.element.should == :C
    carbon12.mass_number.should == 12
    carbon12 = Mspire::Isotope[:C].find(&:mono)  # the most abundant (i.e., monoisotopic isotope)
    carbon12.element.should == :C
    carbon12.mass_number.should == 12
    carbon12.mono.should be_true
  end

  it 'can set the element_hash to change convenience method access' do
    Mspire::Isotope[:C][0].relative_abundance.should == 0.9891
    Mspire::Isotope.element_hash = Mspire::Isotope::NIST::BY_ELEMENT
    Mspire::Isotope[:C][0].relative_abundance.should == 0.9893
  end

  specify 'Mspire::Isotope::ISOTOPES has all the common isotopes and (uses Neese by default)' do
    # frozen
    Mspire::Isotope::ISOTOPES.size.should == 288
    hydrogen_isotopes = Mspire::Isotope::ISOTOPES.select {|iso| iso.element == :H }
    hydrogen_isotopes.size.should == 2

    {atomic_number: 1, element: :H, mass_number: 1, atomic_mass: 1.00782503207, relative_abundance: 0.999844, average_mass: 1.00794, mono: true}.each do |k,v|
      hydrogen_isotopes.first.send(k).should == v
    end
    {atomic_number: 1, element: :H, mass_number: 2, atomic_mass: 2.0141017778, relative_abundance: 0.000156, average_mass: 1.00794, mono: false}.each do |k,v|
      hydrogen_isotopes.last.send(k).should == v
    end
    u = Mspire::Isotope::ISOTOPES.last
    {atomic_number: 92, element: :U, mass_number: 238, atomic_mass: 238.0507882, relative_abundance: 0.992742, average_mass: 238.02891, mono: true}.each do |k,v|
      u.send(k).should == v
    end
  end

  specify 'Mspire::Isotope::BY_ELEMENT has all common isotopes by element (uses Neese by default)' do
    [{atomic_number: 6, element: :C, mass_number: 12, atomic_mass: 12.0, relative_abundance: 0.9891, average_mass: 12.0107, mono: true}, {atomic_number: 6, element: :C, mass_number: 13, atomic_mass: 13.0033548378, relative_abundance: 0.0109, average_mass: 12.0107, mono: false}].zip(Mspire::Isotope::BY_ELEMENT[:C]) do |hash, iso|
      hash.each do |k,v|
        iso.send(k).should == v
      end
    end
    Mspire::Isotope::BY_ELEMENT[:H].size.should == 2
  end
end
