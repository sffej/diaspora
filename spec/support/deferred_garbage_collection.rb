
# https://makandracards.com/makandra/950-speed-up-rspec-by-deferring-garbage-collection
class DeferredGarbageCollection

  DEFERRED_GC_THRESHOLD = (ENV['DEFER_GC'] || 10.0).to_f #used to be 10.0

  @@last_gc_run = Time.now

  def self.start
    return if unsupported_enviroment
    GC.disable if DEFERRED_GC_THRESHOLD > 0
  end

  def self.memory_threshold
    @mem = %x(free 2>/dev/null).to_s.split(" ")
    return nil if @mem.empty?
    @mem[15].to_i / (@mem[7].to_i/100)
  end

  def self.reconsider
    return if unsupported_enviroment

    if (percent_used = self.memory_threshold)
      running_out_of_memory = percent_used > 90

      # just for info, as soon as we got some numbers remove it
      swap_percent_used = @mem[19].to_i / (@mem[18].to_i/100) rescue 0
      puts "percent memory used #{percent_used} (#{@mem[8]} of #{@mem[7]})"
      puts "percent swap used   #{swap_percent_used} (#{@mem[19]} of #{@mem[18]})"
    else
      running_out_of_memory = false
    end

    if( (DEFERRED_GC_THRESHOLD > 0 && Time.now - @@last_gc_run >= DEFERRED_GC_THRESHOLD) || running_out_of_memory )
      GC.enable
      GC.start
      GC.disable
      @@last_gc_run = Time.now
    end
  end

  def self.unsupported_enviroment
    ENV['TRAVIS'] # TODO: enable for ruby 1.9.3 or more RAM
  end

end
