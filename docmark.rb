#encoding:UTF-8

# HTML document's header and footer
$HTML_header = "<!DOCTYPE html>\n<html>\n<body>\n"
$HTML_footer = "</body>\n</html>\n"

# Generate tokens without line breaks
# for each HTML tag.
def get_tokens(lines)
  tokens = []
  chunk = ""

  lines.each do |line|
    case line
    when /^[#\+\-]+.*$/  # Headers
      unless chunk == ""
        tokens += [chunk.strip]
        chunk = ""
      end

      tokens += [line.strip]
    when /^\s*$/  # Ends or Starts of paragraphs
      unless chunk == ""
        tokens += [chunk.strip]
        chunk = ""
      end
    else #Paragraphs
      chunk += line.strip + " "
    end
  end

  tokens += [chunk.strip] unless chunk == ""
  tokens
end

# Parse tokens to generate HTML tags.
def parse_lines(lines)
  html_body = ""
  tokens = get_tokens(lines)

  tokens.each do |token|
    case token
    when /^######([^#]*)#*\s*$/, /^\+\+\+\+\+\+([^\+]*)\+*\s*$/, /^\-\-\-\-\-\-([^\-]*)\-*\s*$/
      html_body += "<h6>#{$1.strip}</h6>\n"
    when /^#####([^#]*)#*\s*$/, /^\+\+\+\+\+([^\+]*)\+*\s*$/, /^\-\-\-\-\-([^\-]*)\-*\s*$/
      html_body += "<h5>#{$1.strip}</h5>\n"
    when /^####([^#]*)#*\s*$/, /^\+\+\+\+([^\+]*)\+*\s*$/, /^\-\-\-\-([^\-]*)\-*\s*$/
      html_body += "<h4>#{$1.strip}</h4>\n"
    when /^###([^#]*)#*\s*$/, /^\+\+\+([^\+]*)\+*\s*$/, /^\-\-\-([^\-]*)\-*\s*$/
      html_body += "<h3>#{$1.strip}</h3>\n"
    when /^##([^#]*)#*\s*$/, /^\+\+([^\+]*)\+*\s*$/, /^\-\-([^\-]*)\-*\s*$/
      html_body += "<h2>#{$1.strip}</h2>\n"
    when /^#([^#]*)#*\s*$/, /^\+([^\+]*)\+*\s*$/, /^\-([^\-]*)\-*\s*$/
      html_body += "<h1>#{$1.strip}</h1>\n"
    else
      html_body += "<p>#{token}</p>\n"
    end
  end

  html_body
end

# Read file and get list of lines.
def read_input_file(input_path)
  all_lines = []

  File.open(input_path, "r:UTF-8") do |file|
    while (line = file.gets)
      all_lines += [line]
    end
  end

  all_lines
end

# Generate output HTML file.
def write_output_file(output_file, body)
  File.open(output_file, 'w:UTF-8') do |file|
    file.puts $HTML_header
    file.puts body
    file.puts $HTML_footer
  end
end

# Entry point
def main(path)
  lines = read_input_file(path)
  body =  parse_lines(lines)
  write_output_file(path.split(/\./)[0] + ".htm", body)
  puts("\"#{path.split(/\./)[0]}.htm\" file has been produced.")
end

# Command line validation
unless ARGV.length == 1
  puts "Usage:\n    docmark.rb <file-name>.txt\n" 
  exit()
end

unless File.exist?(ARGV[0])
  puts "File not found."
  exit()
end

main(ARGV[0])