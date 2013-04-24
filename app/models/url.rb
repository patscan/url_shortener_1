require 'uri'

class Url < ActiveRecord::Base
  # Remember to create a migration!
  before_create :shorten_url
  validates :full, :format => URI::regexp(%w(http https))

  private
  def shorten_url
    stripped_url = self.full.gsub(/http[s]?:\/\/w{3}?/, "").gsub(/[^a-zA-Z0-9]/, "")
    temp_short = stripped_url.split(//).sample(7).join("")

    until Url.find_by_short(temp_short) == nil
      temp_short = stripped_url.split(//).sample(7).join("")
    end

    self.short = temp_short
  end 
end