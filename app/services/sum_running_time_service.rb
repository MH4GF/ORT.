# frozen_string_literal: true

class SumRunningTimeService
  def initialize(posts)
    @posts = posts
  end

  def call
    total_running_time = {
      total_min:  sum_all_running_time,
      hour:       calc_hour,
      min:        calc_min
    }

    total_running_time
  end

  private

  def sum_all_running_time
    sum = 0
    @posts.each do |post|
      sum += post.running_time.to_i
    end

    sum
  end

  def calc_hour
    sum_all_running_time / 60
  end

  def calc_min
    sum_all_running_time % 60
  end
end
