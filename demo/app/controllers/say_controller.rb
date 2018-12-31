class SayController < ApplicationController
  def hello
  	# instance variable
  	@time = Time.now
  	# returns a list of all the files in the current directory
  	@files = Dir.glob('*')

  	
  end

  def goodbye
  end
end
