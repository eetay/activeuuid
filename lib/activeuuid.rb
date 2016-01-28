require 'activeuuid/version'
require 'activeuuid/patches'
require 'activeuuid/uuid'
require 'activeuuid/railtie' if defined?(Rails::Railtie)

def uuid_to_binary(value)
  aa = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0].map do |x|
    a = 256 + value % 256
    value = value / 256
    a.to_s(16)[1,2]
  end
  return "x'#{aa.join}'"
end

def uuid_serialize(value)
  byebug
  return nil if value.nil?
  return value if value.is_a?(Integer)
  if value.is_a?(String)
    result = value.bytes.inject([0,1]) {|sum,x| [x*sum[1] + sum[0], sum[1]*256]}
    result[0]
  else
    byebug
    raise "error unexpected value type: #{value.class} expected Bignum or Binary(16)"
  end
end

module ActiveUUID
end

ActiveUUID::Patches.apply!
