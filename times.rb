require 'colorize' 

class Timer

	attr_accessor :loud

	def initialize msg=nil, loud=false
		@marks = []
		@t=nil
		@sum=0.0
		@loud = loud
		mark(msg) if msg 
	end

	def mark msg
		m = { :time=>Time.new.to_f, :msg => msg.to_s }
		count m
		@marks << m
		report_mark(m) if @loud
	end

	def << msg
		return mark msg
	end

	def count m
		if @t
			@sum += m[:time] - @t 
		else
			@t = m[:time]
			@sum = 0
		end
	end

	def recount 
		@t=nil
		@sum=0.0
		@marks.each do |m|
			count m
			report_mark m
		end
	end

	def report_mark m
		printf "\033[1;31mT=\033[0m%6.3f (+ %6.3f) %s\n", @sum, m[:time] - @t, m[:msg]
	end

	
end

