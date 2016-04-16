class UrlValidator < ActiveModel::EachValidator
    require 'url_helper'
    def validate_each(record, attribute, value)
        record.errors.add attribute, "Invalid URL" unless
            UrlHelper.url_exist?(value)
    end
end