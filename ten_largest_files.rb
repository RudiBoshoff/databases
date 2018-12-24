DIRNAME = "/home/rudi/webprojects/google*"

# SHOWS THE LARGEST 10 FILES IN DIRECTORY
puts "The largest files in #{DIRNAME}/** are: \n\n"
Dir.glob("#{DIRNAME}/**/*.*").sort_by{|fname| File.size(fname)}.reverse[0..9].each do |fname|
  puts "#{File.basename(fname)}\t#{File.size(fname)}"
end

puts "\n"

puts "The Different file types in #{DIRNAME}/** are: \n\n"
# SHOWS FILES TYPES, NUMBER OF FILES AND SIZE OF THE FILES
hash = Dir.glob("#{DIRNAME}/**/*.*").inject({}) do |hsh, fname|
  ext = File.basename(fname).split('.')[-1].to_s.downcase
  hsh[ext] ||= [0, 0]
  hsh[ext][0] += 1
  hsh[ext][1] += File.size(fname)
  hsh
end

File.open("file-analysis.txt","w") do |f|
  hash.each do |arr|
    txt = arr.flatten.join("\t\t")
    f.puts txt
    puts txt
  end
end
