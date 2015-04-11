class HelpResponder
  def help_for_command(help)
    res = "#{sprintf('%-30s', help[:phrase])} - #{help[:description]}"
    if help[:examples]
      res << "\n#{sprintf('%-30s', '')}     Examples: \"#{help[:examples].join('", "')}\""
    end
    res
  end
end
