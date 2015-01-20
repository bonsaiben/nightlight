module Nightlight
  class Page < ActiveRecord::Base
    belongs_to :assignee, class_name: "User"
    has_many :activities, dependent: :destroy

    validates :path, presence: true, uniqueness: {scope: :name}

    scope :hidden, ->{ where hidden: true }
    scope :unhidden, ->{ where hidden: false }
    scope :unassigned, ->{ where assignee_id: nil }

    def to_param
      [id, name.gsub("'", "").parameterize].join("-")
    end

    def brightness
      if last_checked_at.nil? || last_checked_at < 1.month.ago
        0
      elsif last_checked_at < 2.weeks.ago
        1
      elsif last_checked_at < 1.week.ago
        2
      elsif last_checked_at < 1.day.ago
        3
      else
        4
      end
    end

    def current_status
      activities.status.first
    end

    def checked! user=nil
      user ||= assignee
      activities.checked.where(user: user).create!
      self.last_checked_at = Time.now
      self.assignee = nil if user==assignee
      save!
    end

  end
end
