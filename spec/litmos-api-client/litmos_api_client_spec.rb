require "spec_helper"

RSpec.describe '' do

  [:get, :post, :put, :delete].each do |verb|
    describe "##{verb}" do

      subject { LitmosApiClient::API.new('api-key', 'source', {logger: Logger.new("/dev/null")}) }

      describe 'everything is awesome' do
        before do
          stub_request(verb, 'https://api.litmos.com/v1.svc/baz?apikey=api-key&source=source').
            with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
            to_return(:status => 200, :body => {ok: true}.to_json, :headers => {})
        end

        it 'will pull and parse the result' do
          expect(subject.send(verb, 'baz')).to eq({ok: true})
        end

        it 'can omit the parsing and return the plain JSON' do
          expect(subject.send(verb, 'baz', dont_parse_response: true)).to eq({ok: true}.to_json)
        end

      end

      describe 'resource cannot be found' do
        before do
          stub_request(verb, 'https://api.litmos.com/v1.svc/baz?apikey=api-key&source=source').
            with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
            to_return(:status => 404, :body => "", :headers => {})
        end

        it 'will raise LitmosApiClient::NotFound' do
          expect{ subject.send(verb, 'baz') }.to raise_error(LitmosApiClient::NotFound)
        end
      end

      describe 'limit is excceded' do
        before do
          allow_any_instance_of(Object).to receive(:sleep)

          stub_request(verb, "https://api.litmos.com/v1.svc/baz?apikey=api-key&source=source").
            with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
            to_return({:status => 503, :body => ""})
        end

        it 'will raise LitmosApiClient::LimitExceeded' do
          expect{ subject.send(verb, 'baz') }.to raise_error(LitmosApiClient::LimitExceeded)
        end

      end

      describe 'something goes wrong' do
        before do
          stub_request(verb, "https://api.litmos.com/v1.svc/baz?apikey=api-key&source=source").
            with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
            to_return(:status => 500, :body => "", :headers => {})
        end

        it 'will raise LitmosApiClient::ApiError' do
          expect{ subject.send(verb, 'baz') }.to raise_error(LitmosApiClient::ApiError)
        end
      end
    end
  end
end
