module OwlDiff
  class OntologyDiff
    SINGLE_CHANGE_TYPES = [:format,:ontology_id].map{ |type| "#{type}_change".to_sym }
    SET_CHANGE_TYPES = [:prefix,:import,:annotation,:axiom].map{ |type| "#{type}_changes".to_sym }
    ENTITIES = [:new,:modified,:removed].map{ |type| "#{type}_entities".to_sym }

    ALL_TYPES = SINGLE_CHANGE_TYPES + SET_CHANGE_TYPES + ENTITIES

    FROM_JSON = {
      SINGLE_CHANGE_TYPES => lambda { |change| OntologyChange.from_hash(change) },
      SET_CHANGE_TYPES => lambda { |changes| OntologyDiff.from_array(OntologyChange, changes)},
      ENTITIES => lambda { |entities| OntologyDiff.from_array(OntologyEntity, entities) }
    }

    ALL_TYPES.each do |type|
      attr_accessor type
    end

    def initialize binary_identical
      @binary_identical = binary_identical
    end

    def binary_identical?
      @binary_identical
    end

    def to_json(*opts)
      diff = { binary_identical: @binary_identical }
      ALL_TYPES.each do |type|
        diff[type] = self.send(type)
      end
      diff.to_json(*opts)
    end

    def self.from_json json
      ontology_changes = JSON.parse(json)
      diff = OntologyDiff.new ontology_changes["binary_identical"]
      FROM_JSON.each do |types, block|
        diff.type_from_hash types, ontology_changes, block
      end
      diff
    end

    def type_from_hash types, hash, block
      types.each do |type|
        value = hash[type.to_s]
        self.send "#{type}=", block.call(value) if value
      end
    end

    private

    def self.from_array klass, values
      values.map do |value|
        klass.from_hash(value)
      end
    end

  end
end
