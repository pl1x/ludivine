class Answer

    # Available: moduleName,methodName,username,message

    def compile

        @memory.connect()
    	query = @message.sub("compile", "").strip

    	if query == ""
    		return Hash["text" => "You must give me something to compile.\n`compile something`"]
    	end

    	thoughts = @memory.load(query).shuffle

    	votes = {}
    	votesSum = 0

    	thoughts.each do |known|
    		if known[1] != query then next end
    		votes[known[2]] = votes[known[2]].to_i + 1
    		votesSum += 1
    	end

    	if votesSum < 1
	    	return Hash["text" => "I don't know what *"+query+"* is."]
	    end

    	graph = ""
    	votes.sort_by {|_key, value| value}.reverse.each do |value,count|
    		percent = ((count.to_f/votesSum.to_f)*100).to_i
    		graph += progressBar(percent)+" *"+value+"* has "+count.to_s+" votes, for "+percent.to_s+"%\n"
    	end

    	return Hash["text" => "The result for "+query+" is: \n"+graph]

    end

    def progressBar percent

    	graph = ""

    	i = 0
    	while i < percent/10
    		graph += "="
    		i += 1
    	end 

    	space = 0
    	while space < (10-i)
    		graph += " "
    		space += 1
    	end

    	return "`"+graph+"`"

    end

end