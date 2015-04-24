require 'json'
require "owldiff/version"
require "owldiff/ontology_change"
require "owldiff/ontology_diff"
require "owldiff/ontology_entity"
require "uri"
require 'net/http'
require 'singleton'

module Owldiff

  class Client
    include Singleton

    def self.setup *args
      instance.set_uri(*args)
      instance
    end

    def self.diff *args
      instance.query *args
    end

    def set_uri host, port
      @uri = URI::HTTP.build host: host, port: port , path: "/diff.json"
    end

    def query *args
      raise_error unless @uri
      @uri.query = params *args # build query
      OntologyDiff.from_json Net::HTTP.get(@uri)
    end

    private

    def params url1, url2
      params = {owl1_url: url1, owl2_url: url2}
      URI.encode_www_form params
    end

    def raise_error
      raise Exception.new "Either did not set the host or the port for the diff service!"
    end

  end

end
