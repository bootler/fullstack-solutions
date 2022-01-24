# Alex Boutilier - RSpec Exercises 4
# Verify RSpec installation with 'bundle install' then use 'bundle exec rspec'
require('byebug')

def my_reject(arr, &prc)
    arr.select { |el| !prc.call(el) }
end

def my_one?(arr, &prc)
    arr.select { |el| prc.call(el) }
        .length == 1
end

def hash_select(hsh, &prc)
    hsh.reject { |k,v| !prc.call(k,v) }
end

def xor_select(arr, prc_a, prc_b)
    arr.select { |el| prc_a.call(el) ^ prc_b.call(el) }
end

def proc_count(val, arr)
    arr.select { |el| el.call(val) }.length
end
