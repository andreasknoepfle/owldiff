require_relative 'minitest_helper'

class TestOwldiff < Minitest::Unit::TestCase

  def setup
    @diff = OwlDiff::OntologyDiff.new false
    @diff.format_change = OwlDiff::OntologyChange.new "humanized change text", :format, :modified, "RDF/XML"
    @diff.new_entities = OwlDiff::OntologyEntity.new "\#Someentity", "http://someentitiesiri\#Someentity"
  end

  def test_that_it_has_a_version_number
    refute_nil ::Owldiff::VERSION
  end

  def test_if_ontology_diff_responds_to_all_diff_types

    types = [ :format_change,:ontology_id_change,
              :prefix_changes,:import_changes,
              :annotation_changes,:axiom_changes,
              :new_entities,:modified_entities,:removed_entities
            ]
    types.each do |type|
      @diff.respond_to? type
    end
  end

  def test_constructor
    assert !@diff.binary_identical?
  end

  def test_if_ontology_diff_is_json_serializable
    assert_equal String, @diff.to_json.class
  end


end
