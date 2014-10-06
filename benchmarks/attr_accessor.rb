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
accessor = Accessor.new

10000000.times do
  accessor.field
end

accessor_read = Time.now - time_begin

p "Accessor#field: #{accessor_read}"

time_begin = Time.now
accessor = Accessor.new

10000000.times do
  accessor.field = nil
end

accessor_write = Time.now - time_begin

p "Accessor#field=: #{accessor_write}"

time_begin = Time.now
definer = Definer.new

10000000.times do
  definer.field
end

accessor_read = Time.now - time_begin

p "Definer#field: #{accessor_read}"

time_begin = Time.now
definer = Definer.new

10000000.times do
  definer.field = nil
end

definer_write = Time.now - time_begin

p "Definer#field=: #{definer_write}"

# p "Definer write is #{definer_write.to_f / accessor_write} times faster"
# p "Definer read is #{definer_read.to_f / accessor_read} times faster"
