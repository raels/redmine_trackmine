require 'sinatra'

class PivotalHandler < Sinatra::Base

  post '/pivotal_activity.xml' do
    message = request.body.read.strip
    message_hash = Hash.from_xml(message)
    return [202, "It is not a correct Pivotal Tracker message"] if message_hash['activity'].nil? 
    if message_hash['activity']['event_type'] == 'story_update'
      begin
        Trackmine.read_activity message_hash['activity'] 
      rescue
        return [202, "Not supported activity"] 
      end
      return [200, "Got the activity"]
    else
      return [202, "Not supported event_type"] 
    end

  end

end


