# -*- coding: utf-8 -*-

module WithRailsLogger
  def _debug(*args)
    Rails.logger.debug "!!!!!"
    args.each do |arg|
      Rails.logger.debug "!!!!!" + arg.inspect
    end
    Rails.logger.debug "!!!!!"
  end
end

Object.send :include, WithRailsLogger
