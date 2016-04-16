require 'spec_helper'
require 'url_helper'

describe UrlHelper do
    
    describe '#url_exist?' do
        before :each do
            @url = 'https://github.com/dhhxu/projectscope' 
        end
        it 'should return true for a valid url' do
            expect(UrlHelper.url_exist? @url).to eq(true)
        end
    
        it 'should return false for a invalid url' do
            bad_url = @url + "asdf"
            expect(UrlHelper.url_exist? bad_url).to eq(false)
        end
        
        it 'should return false for a nil url' do
            expect(UrlHelper.url_exist? nil).to eq(false)
        end
    end
    
    describe '#proper_url?' do
        it 'should return true for a properly formatted but not valid url' do
            url = 'http://www.non-existing-url.com'
            expect(UrlHelper.proper_url? url).to eq(true)
        end
        
        it 'should return false for nil url_string' do
            expect(UrlHelper.proper_url? nil).to eq(false) 
        end
        
        it 'should return true for a Github url' do
            url = 'https://github.com/dhhxu/projectscope'
            expect(UrlHelper.proper_url? url).to eq(true)
            expect(UrlHelper.proper_url? url + '.git').to eq(true)
        end
    end
    
end