module EntriesHelper
  def seconds_to_time(seconds)
    hours = seconds / 3600
    minutes = seconds / 60 % 60
    seconds = seconds / 1 % 60

    ['%02d' % hours, '%02d' % minutes, '%02d' % seconds].join(":")
  end
end
