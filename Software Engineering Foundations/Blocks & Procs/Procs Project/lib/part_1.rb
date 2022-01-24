
def my_map(arr, &prc)
    newArr = []
    arr.each { |el| newArr << prc.call(el) }
    return newArr
end

def my_select(arr, &prc)
    newArr = []
    arr.each { |el| newArr << el if prc.call(el) }
    return newArr
end

def my_count(arr, &prc)
    count = 0
    arr.each { |ele| count += 1 if prc.call(ele) }
    return count
end

def my_any?(arr, &prc)
    flag = false
    arr.each { |el| flag = true if prc.call(el) }
    return flag
end

def my_all?(arr, &prc)
    flag = true
    arr.each { |el| flag = false if !(prc.call(el)) }
    return flag
end

def my_none?(arr, &prc)
    flag = true
    arr.each { |el| flag = false if prc.call(el) }
    return flag
end
