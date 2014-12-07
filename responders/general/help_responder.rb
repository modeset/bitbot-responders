class HelpResponder

  def help_for_command(help)
    res = "#{sprintf("%-30s", help[:phrase])} - #{help[:description]}"
    res << "\n#{sprintf("%-30s", '')}     Examples: \"#{help[:examples].join('", "')}\"" if help[:examples]
    res
  end

end
