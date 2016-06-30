class Team
  Member = Struct.new(:name)

  def initialize
    @members = []
  end

  def <<(name)
    @members << Member.new(name)
  end

  def members_names
    @members.map(&:name)
  end

  def print(options = {})
    if options[:printer].nil?
      printer = ProPrinter.new   # ProPrinter is de-facto default printer
    else
      printer = self.class.const_get(options[:printer].to_s.capitalize + "Printer").new
      options.delete(:printer)
    end

    printer.print(members_names, options)
  end
end

class ProPrinter
  def print(members_names, options = {})
    options[:limit].nil? ? limit = 10 : limit = options[:limit]

    members_names.take(limit).each { |name| puts name.capitalize }
  end
end

class ReversePrinter
  def print(members_names, options = {})
    members_names.reverse.each { |name| puts name.reverse.downcase }
  end
end

class PresentationPrinter
  # TODO: add multiple presentation options (sort, shuffle, reverse)
  def print(members_names, options = {})
    options[:shuffle].nil? ? shuffle = true : shuffle = options[:shuffle]

    puts "Members:"
    if shuffle
      members_names.shuffle.each { |name| puts "* #{name}" }
    else
      members_names.each { |name| puts "* #{name}" }
    end
  end
end

class FunnyPrinter
  def print(members_names, options = {})
    # TODO: not implemented
  end
end
