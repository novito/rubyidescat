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

		it 'should return poblacions that start with "torrelles"' do
			VCR.use_cassette('torrelles sug') do
				results = client.poblacio('v1','json','sug', { 'q' => 'torrelles' })
				expect(results).to eq(["torrelles",["Torrelles de Foix","Torrelles de Llobregat"]])
			end
		end

	end
end
