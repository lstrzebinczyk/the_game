require "opal"

class Accessor
  attr_accessor :field
end

class Definer
  def field
    @field
  end

  def field=(field)
    @field = field
  end
end

time_begin = Time.now
iterations = 0
accessor = Accessor.new

while Time.now - time_begin < 2
  accessor.field
  iterations += 1
end

accessor_read = iterations

p "Accessor#field: #{iterations}"

time_begin = Time.now
iterations = 0
accessor = Accessor.new

while Time.now - time_begin < 2
  accessor.field = nil
  iterations += 1
end

accessor_write = iterations

p "Accessor#field=: #{iterations}"

time_begin = Time.now
iterations = 0
definer = Definer.new

while Time.now - time_begin < 2
  definer.field
  iterations += 1
end

definer_read = iterations

p "Definer#field: #{iterations}"

time_begin = Time.now
iterations = 0
definer = Definer.new

while Time.now - time_begin < 2
  definer.field = nil
  iterations += 1
end

definer_write = iterations

p "Definer#field=: #{iterations}"

p "Definer write is #{definer_write.to_f / accessor_write} times faster"
p "Definer read is #{definer_read.to_f / accessor_read} times faster"
