require 'spec_helper'


describe Rubyidescat::Client do
  describe 'initialize' do
    it 'creates a new client' do
      expect { Rubyidescat::Client.new }.to_not raise_error
    end
  end
  
  let(:client) { Rubyidescat::Client.new }
  describe 'poblacio' do

    describe 'geo' do
      it 'should accept one parameter and return results' do
        VCR.use_cassette('torrelles geo') do
          results = client.get_population('geo', { 'q' => 'torrelles' })
          expect(results["feed"]["opensearch:totalResults"]).to eq("6")
        end
      end
    end

    describe 'sug' do

      it 'should accept one parameter and return results' do
        VCR.use_cassette('torrelles sug') do
          results = client.get_population('sug', { 'q' => 'torrelles' })
          expect(results).to eq(["torrelles",["Torrelles de Foix","Torrelles de Llobregat"]])
        end
      end

      it 'should accept several extra parameters and return results' do
        VCR.use_cassette('sug tipus com "barc"') do
          results = client.get_population('sug', { 'q' => 'barc', 'tipus' => 'com' })
          expect(results).to eq(["barc",["Barcelonès"]])
        end
      end

      it 'should accept multiple parameters with multiple values and return results' do
        VCR.use_cassette('sug multiple parameters and values') do
          results = client.get_population('sug', { 'q' => 'ab', 'tipus' => ['mun','np'] })
          expect(results).to eq(["ab",["Abella","Abella de la Conca","Abella, l'","Abrera"]])
        end
      end
    end

    describe 'cerca' do
      
      it 'should accept one parameter and return results' do
        VCR.use_cassette('torrelles cerca') do
          results = client.get_population('cerca', { 'q' => 'torrelles de llobregat' })
          expect(results["feed"]["opensearch:totalResults"]).to eq("3")
        end
      end

      it 'should accept several extra parameters and return results' do
        VCR.use_cassette('cerca tipus pob "torrelles de llobregat"') do
          results = client.get_population('cerca', { 'q' => 'torrelles de llobregat', 'tipus' => 'pob' })
          expect(results["feed"]["opensearch:totalResults"]).to eq("3")
        end
      end

      it 'should accept parameter sim' do
        VCR.use_cassette('cerca sim 0,1 "abrera"') do
          results = client.get_population('cerca', { 'q' => 'abrera', 'sim' => '0,1' })
          expect(results["feed"]["opensearch:totalResults"]).to eq("4")
        end
      end

    end #end cerca
  end #end poblacio

  describe "rectifications" do
    describe "cerca" do 
      it 'should accept zero parameters and return results' do
        VCR.use_cassette('rectifications cerca') do
          results = client.get_rectifications('cerca')
          expect(results["feed"]["opensearch:totalResults"].to_i).to be > 0 
        end
      end
    end
  end
end
