require 'spec_helper'


describe Rubyidescat::Client do
  describe 'initialize' do
    it 'creates a new client' do
      expect { Rubyidescat::Client.new }.to_not raise_error
    end

    it 'should have a base url for the API' do
      #expect { Rubyidescat::Client }.to be_const_defined :BASE_URL
    end
  end
  
  let(:client) { Rubyidescat::Client.new }
  describe 'poblacio' do

    describe 'sug' do
      it 'should set format correctly' do
        VCR.use_cassette('empty sug') do
          client.poblacio('v1','json','sug')
          expect(client.instance_variable_get('@format')).to eq('json')
        end
      end

      it 'should set version correctly' do
        VCR.use_cassette('empty sug') do
          client.poblacio('v1','json','sug')
          expect(client.instance_variable_get('@version')).to eq('v1')
        end
      end

      it 'should set operation correctly' do
        VCR.use_cassette('empty sug') do
          client.poblacio('v1','json','sug')
          expect(client.instance_variable_get('@operation')).to eq('sug')
        end
      end

      it 'should set request url correctly' do
        VCR.use_cassette('torrelles sug') do
          results = client.poblacio('v1','json','sug', { 'q' => 'torrelles' })
          expect(client.request_url).to eq('http://api.idescat.cat/pob/v1/sug.json?p=q/torrelles')
        end
      end

      it 'should accept one parameter and return results' do
        VCR.use_cassette('torrelles sug') do
          results = client.poblacio('v1','json','sug', { 'q' => 'torrelles' })
          expect(results).to eq(["torrelles",["Torrelles de Foix","Torrelles de Llobregat"]])
        end
      end

      it 'should accept several extra parameters and return results' do
        VCR.use_cassette('sug tipus com "barc"') do
          results = client.poblacio('v1','json','sug', { 'q' => 'barc', 'tipus' => 'com' })
          expect(results).to eq(["barc",["Barcelonès"]])
        end
      end

      it 'should accept multiple parameters with multiple values and return results' do
        VCR.use_cassette('sug multiple parameters and values') do
          results = client.poblacio('v1','json','sug', { 'q' => 'ab', 'tipus' => ['mun','np'] })
          expect(results).to eq(["ab",["Abella","Abella de la Conca","Abella, l'","Abrera"]])
        end
      end
    end

    describe 'cerca' do
      it 'should set operation correctly' do
        VCR.use_cassette('empty cerca') do
          client.poblacio('v1','json','cerca')
          expect(client.instance_variable_get('@operation')).to eq('cerca')
        end
      end

      it 'should set request url correctly' do
        VCR.use_cassette('torrelles cerca') do
          results = client.poblacio('v1','json','cerca', { 'q' => 'torrelles de llobregat' })
          expect(client.request_url).to eq('http://api.idescat.cat/pob/v1/cerca.json?p=q/torrelles%20de%20llobregat')
        end
      end

      it 'should accept one parameter and return results' do
        VCR.use_cassette('torrelles cerca') do
          results = client.poblacio('v1','json','cerca', { 'q' => 'torrelles de llobregat' })
          expect(results["feed"]["opensearch:totalResults"]).to eq("3")
        end
      end

    end

  end
end
