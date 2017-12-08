require 'json'

class Spell
    
    def initialize(params)
        @classification = params["Classification"]
        @effect = params["Effect"]
        @name = params["Spell(Lower)"]
        @formatted_name = params["Spell"]
    end
    
    attr_reader :classification, :effect, :name, :formatted_name
    
    def self.data
    path = 'data/spells.json'
    file = File.read(path)
    JSON.parse(file)
end

def self.random
new(data.sample)
end

def self.effects
data.map{|el| el["Effect"]}
end

# These two methods are used to validate answers
def self.is_spell_name?(str)
data.index { |el| el["Spell(Lower)"] == (str.downcase) }
end

def self.is_spell_name_for_effect?(name, effect)
data.index { |el| el["Spell(Lower)"] == name && el["Effect"] == effect }
end

# To get access to the collaborative repository, complete the methods below.

# Spell 1: Reverse
# This instance method should return the reversed name of a spell
# Tests: `bundle exec rspec -t reverse .`
def reverse_name
    reversedName = @name.reverse
    return reversedName
end

# Spell 2: Counter
# This instance method should return the number
# (integer) of mentions of the spell.
# Tests: `bundle exec rspec -t counter .`
def mention_count
    count = Hash.new 0 #Only works as '0' even though documentation says it should be bracketed like '(0)'
    Mention.data.each do |harry|
        
        count[harry["Spell"]] += 1
    end
    return count[@name]
end

# Spell 3: Letter
# This instance method should return an array of all spell names
# which start with the same first letter as the spell's name
# Tests: `bundle exec rspec -t letter .`
def names_with_same_first_letter
    letter = @name[0]
    dDore = []
    Spell.data.each do |harry|
        if harry["Spell(Lower)"][0] == letter
            dDore << harry["Spell(Lower)"]
        end
    end
    return dDore
end

# Spell 4: Lookup
# This class method takes a Mention object and
# returns a Spell object with the same name.
# If none are found it should return nil.
# Tests: `bundle exec rspec -t lookup .`
def self.find_by_mention(mention)

snapeData = Spell.data
coco = (nil)

snapeData.each{|spell|
    
    if spell["Spell(Lower)"] == mention.name
        
        coco = Spell.new({"Classification" => spell["Classification"],
                        "Effect" => spell["Effect"],
                        "Spell(Lower)" => spell["Spell(Lower)"],
                        "Spell" => spell["Spell"]})
    end
}

return coco


end

end
