# Mspire::Isotope

mspire library that can retrieve (from NIST) and yield element isotope information.

## Installation

    gem install mspire-isotope

## Usage

```ruby
require 'mspire/isotope'
```

Note: by default Neese biological isotope abundance ratios are used so H, C, N, O, S
have slightly different ratios than straight NIST ratios.

### The Isotopes hashed by element

```ruby
Mspire::Isotope::BY_ELEMENT
carbon_isotopes = Mspire::Isotope::NIST::BY_ELEMENT[:C]
```

### An array of all isotopes

```ruby
all_isotopes = Mspire::Isotope::ISOTOPES
```

### Only the monoisotopic isotopes

(the monoisotopic isotope is the one with the highest relative abundance)

```ruby
monoisotopic_isotopes = Mspire::Isotope::ISOTOPES.select(&:mono)
```

### Convenience method for access by element

# find the lightest carbon isotope
isotope = Mspire::Isotope[:C]

# find the monoisotopic (i.e., most abundant isotope) of carbon
isotope = Mspire::Isotope[:C].find(&:mono)

### Information available

```ruby
c12 = Mspire::Isotope[:C][0]
c12.atomic_number # => 6
c12.element # => :C,
c12.mass_number # => 12,
c12.atomic_mass # => 12.0,
c12.relative_abundance # => 0.9891,
c12.average_mass # => 12.0107,
c12.mono # => true

c13 = Mspire::Isotope[:C][1]
...
```

### Only use NIST data

```ruby
by_element_hash = Mspire::Isotope::NIST::BY_ELEMENT
isotope_array = Mspire::Isotope::NIST::ISOTOPES
```

What about the convenience method? You set which element_hash you are using:

```ruby
Mspire::Isotope[:C][0].relative_abundance  # => 0.9891
Mspire::Isotope.element_hash = Mspire::Isotope::NIST::BY_ELEMENT
Mspire::Isotope[:C][0].relative_abundance  # => 0.9893
```
