# PomodoroController.rb
# PomodoroMRIA
#
# Created by Will Green on 1/15/11.
# Copyright 2011 __MyCompanyName__. All rights reserved.

class PomodoroController 
	attr_accessor :timer_label, :start_stop_button 
	attr_accessor :pomodoro_timer, :time_left
	attr_accessor :minutes, :warn_limit, :alert_limit
	
	def awakeFromNib()
		@minutes = 1
		@time_left = @minutes * 60
    @warn_limit = @time_left * 2/5
    @alert_limit = @time_left * 1/5
    set_timer_label(@time_left)
	end
	
	def start_stop_pomodoro(sender)
		if @pomodoro_timer.nil?
			@pomodoro_timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector:"time_passed:", userInfo:nil, repeats:true) 
			@start_stop_button.title = "Stop Pomodoro"
		else 
			reset_interface
		end
	end
	
	def time_passed(timer)
		if @time_left > 1 
			@time_left -= 1
      set_timer_label(@time_left)
		else
			reset_interface
			alert_user 
		end
	end
  
  def reset_interface 
		@time_left = @minutes * 60 
    set_timer_label(@time_left)
		@start_stop_button.title = "Start Pomodoro" 
		@pomodoro_timer.invalidate 
		@pomodoro_timer = nil
	end
  
  protected
  def set_timer_label(time_left)
    @timer_label.textColor = label_color(time_left)
    minutes, seconds = minutes_and_seconds @time_left
    @timer_label.stringValue = format_time(minutes, seconds)
  end
  
  def label_color(time_left)
    color = NSColor.blackColor
    color = NSColor.yellowColor if time_left < @warn_limit
    color = NSColor.redColor if time_left < @alert_limit
    color
  end
	
	def minutes_and_seconds(time_left)
		[@time_left/60 % 60, @time_left % 60]
	end
	
	def format_time(minutes, seconds)
		"#{minutes.to_s.rjust(2,'0')}:#{seconds.to_s.rjust(2,'0')}"
	end
	
	def alert_user 
		voice = NSSpeechSynthesizer.alloc.initWithVoice("com.apple.speech.synthesis.voice.Victoria") 
		voice.startSpeekingString("Pomodoro complete! Time for a short break.")
	end
	
end