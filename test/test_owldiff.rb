require_relative 'minitest_helper'

class TestOwldiff < Minitest::Unit::TestCase

  def setup
    @diff = Owldiff::OntologyDiff.new false
    @diff.format_change = Owldiff::OntologyChange.new "humanized change text", :format, :modified, "RDF/XML"
    @diff.new_entities = [ Owldiff::OntologyEntity.new("\#Someentity", "http://someentitiesiri\#Someentity") ]
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

  def test_setup
    client = Owldiff::Client.setup "localhost", 4567
    assert "http://localhost:4567/diff.json", client.instance_variable_get(:@uri)
  end

  def test_no_settings
    assert_raises(Exception)do
      Owldiff::Client.instance.instance_variable_set(:@uri,nil)
      Owldiff::Client.diff "http://test.de/a.owl", "http://test.de/b.owl"
    end
  end

  def test_query
    client = Owldiff::Client.setup "localhost", 4567
    assert Owldiff::Client.instance, client
    path = "test/fixtures/diff.json"
    Net::HTTP.stubs(:get).returns(File.open(path).read)
    diff = Owldiff::Client.diff "http://test.de/a.owl", "http://test.de/b.owl"
    assert diff
    diff = Owldiff::Client.diff "http://test.de/a.owl", "http://test.de/b.owl", :base64
    assert diff
  end

  def test_from_json
    path = "test/fixtures/diff.json"
    diff = Owldiff::OntologyDiff.from_json File.open(path).read
    assert diff
    assert_equal Owldiff::OntologyDiff, diff.class
    refute_empty diff.axiom_changes
    assert_equal Owldiff::OntologyChange, diff.axiom_changes.first.class
    refute_empty diff.modified_entities
    assert_equal Owldiff::OntologyEntity, diff.modified_entities.first.class
  end

  def test_error_responses
    assert_raises(Owldiff::OwldiffError)do
      Owldiff::OntologyDiff.from_json "{ \"error\" : \"message\" }"
    end
    begin
      Owldiff::OntologyDiff.from_json "{ \"error\" : \"message\" }"
    rescue  => e
      assert "message", e.message
    end
  end


end
