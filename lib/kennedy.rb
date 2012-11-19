require "kennedy/engine"

module Kennedy

  mattr_accessor :templates
  @@templates = %w(one-column sidebar-left sidebar-right)

  def self.setup
    yield self
  end
end