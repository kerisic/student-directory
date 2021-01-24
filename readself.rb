def readself
  file = File.open($0, "r")
    file.readlines.each do |line|
      puts line
    end
  file.close
end

readself

#quine example 1
#src = "\nputs \"src = \" + src.inspect + src"
#puts "src = " + src.inspect + src

#quine example 2
#str="str=;puts str[0,4]+34.chr+str+34.chr+str[4..-1]";puts str[0,4]+34.chr+str+34.chr+str[4..-1]