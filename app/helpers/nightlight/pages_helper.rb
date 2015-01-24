module Nightlight
  module PagesHelper

    def avg_page_brightness pages
      if pages.any?
        avg = pages.map(&:brightness).sum.to_f / pages.size.to_f
        avg.to_i
      else
        0
      end
    end

    def link_to_page page
      path = page.sample_path.presence || page.path
      link_to page.path, path, target: '_blank'
    end

    def last_checked_at page, opts={}
      lead = opts[:short] ? "" : "last checked "
      time =
        if page.last_checked_at
          "#{time_ago_in_words(page.last_checked_at)} ago"
        else
          "??"
        end
      "#{lead}#{time}"
    end

  end
end
