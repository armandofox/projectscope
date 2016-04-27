class CodeClimateMetric < ActiveRecord::Base
    belongs_to :project
    
    require 'httparty'
    require 'url_helper'
    
    # validates :url, url: true
    validate :url_appropriate
    
    def self.gpa_display
        return :gpa
    end
    
    def self.coverage_display
        return :coverage
    end
    
    def get_data
        if self.url and self.url != ''
            gpa_hsh = get_gpa
            cov_hsh = get_coverage
            update_score
        end
    end
    
    def update_score
        # attributes gpa and coverage will exist
        # Score is in interval [0, 1]
        w_gpa = 0.5
        w_cov = 1.0 - w_gpa
        
        gpa = self.gpa || 0.0
        cov = self.coverage || 0
        
        gpa_norm = gpa / 4.0
        cov_norm = cov / 100.0
        score = w_gpa * gpa_norm + w_cov * cov_norm
        self.update(score: score)
        # trending?
    end
    
    def get_gpa
        hsh = parse_response(gpa_badge_url)
        gpa = hsh[:stat]
        
        if gpa
            gpa = gpa.to_f
            if self.gpa == nil
                self.update(gpa: gpa)
            elsif self.gpa != gpa
                self.update(gpa: gpa)
                # save trends?
            end
        end
        hsh[:stat] = self.gpa
        hsh
    end
    
    def get_coverage
        hsh = parse_response(coverage_badge_url)
        cov = hsh[:stat]
    
        if cov and cov != "unknown"
            cov = cov.to_i
            if self.coverage == nil
                self.update(coverage: cov)
            elsif self.coverage != cov
                self.update(coverage: cov)
                # save trends?
            end
        end
        hsh[:stat] = self.coverage
        hsh
    end
    
    def parse_response(url)
        if self.url == ''
            # special case for empty CC URL
            return {:stat => nil, :color => nil}
        end
        begin
            response = HTTParty.get(url)
            color_regex = /path fill="([^"]+)"\s/
            if response.body =~ color_regex
                color = $1 
            else
                color = nil
            end
            
            stat_regex = /fill-opacity=".3">.*?fill-opacity=".3">([^<]+)/
            if response.body =~ stat_regex
                stat = $1 
            else
                stat = nil
            end
            return {:stat => stat, :color => color}
        rescue Errno::ECONNREFUSED
            {:stat => nil, :color => nil}
        end
    end
    
    def coverage_url
        fix_url
        self.url + '/coverage' 
    end
    
    def gpa_badge_url
        fix_url
        self.url + '/badges/gpa.svg'
    end
    
    def coverage_badge_url
        fix_url
        self.url + '/badges/coverage.svg'
    end
    
    private
    
    def fix_url
        # only works in the case there is a single trailing '/'
        # e.g. codeclimate.com/github/dhhxu/projectscope/
        if self.url.length > 1 and self.url[-1] == '/'
            self.update(url: self.url[0..-2])
        end
    end
    
    # permits empty urls if a project does not have a Code Climate link
    def url_appropriate
        if self.url and self.url.length > 0
            errors.add :url, "Invalid URL" unless
                UrlHelper.url_exist? self.url
        elsif self.url == nil
            errors.add :url, "Invalid URL" 
        end
    end
end
