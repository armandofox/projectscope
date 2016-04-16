require 'spec_helper'

describe CodeClimateMetric do
    before :each do
        @url = 'https://codeclimate.com/github/dhhxu/projectscope/'
        @cc = CodeClimateMetric.create(url: @url)
    end
    describe '#coverage_url' do
        it 'should remove the trailing forward slash' do
            @cc.coverage_url
            expect(@cc.url).not_to eq(@url)
            expect(@cc.url).to eq(@url[0..-2])
        end
        
        it 'should return the url to the code climate coverage page' do
            expect(@cc.coverage_url).to eq(@url + 'coverage') 
        end
    end
    
    describe '#coverage_badge_url' do
        it 'should generate the correct link to the coverage badge svg' do
            expect(@cc.coverage_badge_url).to eq(@url + 'badges/coverage.svg') 
        end
    end
    
    describe '#gpa_badge_url' do
        it 'should generate the correct link to the gpa badge svg' do
            expect(@cc.gpa_badge_url).to eq(@url + 'badges/gpa.svg') 
        end
    end
    
    describe '#get_gpa' do
        it 'the model gpa attribute should be nil' do
            expect(@cc.gpa).to eq(nil) 
        end
        it 'should update the model gpa attribute' do
            @cc.get_gpa
            expect(@cc.gpa).not_to eq(nil)
            expect(@cc.gpa).to be > 0.0
        end
    end
    
    describe '#get_coverage' do
        it 'the model coverage attribute should initially be nil' do
            expect(@cc.coverage).to eq(nil)
        end
        it 'should update the model coverage attribute' do
            @cc.get_coverage
            expect(@cc.coverage).not_to eq(nil)
            expect(@cc.coverage).to be > 0
        end
    end
    
    describe '#parse_response' do
        before :each do
            @bad_cc = CodeClimateMetric.create(url: '')
            @no_cov = CodeClimateMetric.create(url: 'https://codeclimate.com/github/cal-sfai/submission-site')
        end
        context 'existing badges' do
            it 'should return a gpa' do
                hsh = @cc.parse_response(@cc.gpa_badge_url)
                gpa = hsh[:stat]
                expect(gpa.to_f).to be > 0.0
            end
            
            it 'should return a coverage' do
                hsh = @cc.parse_response(@cc.coverage_badge_url)
                cov = hsh[:stat]
                expect(cov.to_i).to be > 0
            end
        end
        
        context 'nonexisting badges' do
            
            it 'should return nil for gpa if url is empty string' do
                hsh = @bad_cc.parse_response(@bad_cc.gpa_badge_url)
                gpa = hsh[:stat]
                expect(gpa).to eq(nil)
            end
            it 'should return nil for coverage if url is empty string' do
                hsh = @bad_cc.parse_response(@bad_cc.coverage_badge_url)
                cov = hsh[:stat]
                expect(cov).to eq(nil)
            end
            it 'should return unknown for coverage if code climate does not have coverage badge' do
                hsh = @no_cov.parse_response(@no_cov.coverage_badge_url)
                cov = hsh[:stat]
                expect(cov).to eq("unknown")
            end
        end
    end

    describe '#get_data' do
        it 'the model should initially have score, gpa, coverage attributes nil' do
            expect(@cc.score).to eq(nil)
            expect(@cc.gpa).to eq(nil)
            expect(@cc.coverage).to eq(nil)
        end
        it 'should update the gpa, coverage, score attributes' do
            @cc.get_data
            expect(@cc.score).to be > 0.0
            expect(@cc.gpa).to be > 0.0
            expect(@cc.coverage).to be > 0.0
        end
    end
    
    describe '#update_score' do
        # Only makes sense for projects that have coverage and gpa
        it 'the model score attribute should initially be nil' do
            expect(@cc.score).to eq(nil) 
        end
        it 'should update the model score attribute' do
            @cc.update_score
            expect(@cc.score).to be >= 0.0
        end
        it 'the score attribute should be a number in [0, 1]' do
            @cc.update_score
            expect(@cc.score).to be >= 0.0
            expect(@cc.score).to be <= 1.0
        end
    end
end