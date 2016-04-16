require 'spec_helper'

describe ProjectsHelper do
    before :each do
        @repo_name = 'dhhxu/projectscope' 
    end
    describe '#github_url' do
        it 'should return proper github url' do
            repo_name = 'dhhxu/projectscope'
            expected = "https://github.com/dhhxu/projectscope"
            expect(helper.github_url repo_name).to eq(expected)
        end
    end
    
end