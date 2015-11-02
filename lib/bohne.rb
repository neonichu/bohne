require "bohne/version"
require "rexml/document"

module Bohne
  class Bohne
  	def self.convert(source, destination)
  	  input = Bohne.new(source)
  	  input.write(destination)
  	end

  	def initialize(path)
  	  @doc = doc = REXML::Document.new(File.new(path))

  	  document = doc.elements['document']

  	  document.attributes['targetRuntime'] = 'AppleTV'
  	  document.attributes['type'] = 'com.apple.InterfaceBuilder.AppleTV.XIB'
  	  document.attributes['useTraitCollections'] = nil

  	  document.elements['dependencies'].elements['deployment'].remove

  	  rootView = document.elements['objects'].elements['view']
  	  rootViewRect = rootView.elements['rect']
  	  rootViewRect.attributes['width'] = '1920'
  	  rootViewRect.attributes['height'] = '1080'
  	end

  	def to_s
      formatter = REXML::Formatters::Pretty.new(2)
      formatter.compact = false
      out = ''
      formatter.write(@doc, out)
      out.gsub!("<?xml version='1.0' encoding='UTF-8'?>", '<?xml version="1.0" encoding="UTF-8"?>')
      out.gsub!("'", '"')
      out << "\n"
      out
    end

    def write(path)
      File.open(path, 'w') do |f|
        f.write(to_s)
      end
    end
  end
end
