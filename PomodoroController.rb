# PomodoroController.rb
# PomodoroMRIA
#
# Created by Will Green on 1/15/11.
# Copyright 2011 __MyCompanyName__. All rights reserved.

class PomodoroController 
	attr_accessor :timer_label, :start_stop_button 
	attr_accessor :pomodoro_timer, :time_left
	
	def awakeFromNib()
		@time_left = 25
	end
	
	def start_stop_timer(sender)
		if @pomodoro_timer.nil?
			@pomodoro_timer = NSTimer.scheduledTimerWithTimeInterval(60, [ CA]target:self, selector:"time_passed:", userInfo:nil, repeats:true) 
			@timer_label.textColor = NSColor.redColor 
			@start_stop_button.title = "Stop Pomodoro"
		else 
			reset_interface
		end
	end
	
	def time_passed(timer)
		if @time_left > 1 
			@time_left -= 1
			@timer_label.stringValue = @time_left
		else
			reset_interface
			timer_finished_alert 
		end
	end
	
	def reset_interface 
		@time_left = 25 
		@timer_label.stringValue = @time_left 
		@timer_label.textColor = NSColor.blackColor 
		@start_stop_button.title = "Start Pomodoro" 
		@pomodoro_timer.invalidate 
		@pomodoro_timer = nil
	end
	
	def alert_user 
		voice = NSSpeechSynthesizer.alloc.[ CA]initWithVoice("com.apple.speech.synthesis.voice.Victoria") 
		voice.startSpeekingString("Pomodoro complete. Time for a short break")
	end
	
end