class Object
  def try(name, *args, &block)
    send(name, *args, &block) if respond_to?(name)
  end
end