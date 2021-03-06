class CommandFactory

  def initialize(terminal)
    @terminal = terminal
    commands = File.join(File.dirname(__FILE__), "commands")  + "/*"
    Dir[commands].each { |file| eval "require '#{file}'" }
  end

  # Instantiates the command object corresponding to `key`.
  # @param key [Symbol] the key the user pressed on the keyboard.
  # @return [Command] the command the user wishes to execute.
  def command(key)
    keys = configuration.instance.keys
    cmd = eval "#{keys}.#{key}"
    cmd.capitalize! << "Command"
    case cmd
    when /QuitCommand/
      QuitCommand.new(@terminal)
    else
      NoOpCommand.new
    end
  end

end
