def leer(file_name)
  begin
    archivo = File.open(file_name, "r")
    result = archivo.inject("") { |content,line| content + line }
    archivo.close
    result
  rescue SystemCallError
    STDERR.puts "Failed to open #{file_name}: #{$!}"
    archivo = File.new(file_name, "w")
    archivo.close
    ""
  end
end
