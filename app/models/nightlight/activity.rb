module Nightlight
  class Activity < ActiveRecord::Base
    belongs_to :user
    belongs_to :page

    validates :name, presence: true
    validates :description, presence: true, if: :status?

    default_scope ->{ order created_at: :desc }
    scope :status, ->{ where name: 'status' }
    scope :checked, ->{ where name: 'checked' }

    def to_s
      "#{user_name} #{verb_phrase}".humanize
    end

    def user_name
      user.try(:name) || 'someone'
    end

    def status?
      name=='status'
    end
    def checked?
      name=='checked'
    end

    private

    def verb_phrase
      if status?
        'updated the status'
      elsif checked?
        'checked the page'
      end
    end
  end
end
