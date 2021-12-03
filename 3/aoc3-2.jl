using Lazy

get_oxygen(size, code) = map(x-> x < size/2 ? 0 : 1, code)
get_co2(size, code)  = map(x-> x < size/2 ? 1 : 0, code)

function get_rating(list,f,index)

    length(list) < 2 && return list

    list_of_code = @>> list map(list->[1,list...]) reduce(+)
    size, code = Iterators.peel(list_of_code)

    bit = f(size, code)[index]
    list = filter(x->x[index] == bit,list)
    get_rating(list,f,index+1)
end

open("input") do input
    count_and_code = @>> eachline(input) map(list -> collect(Iterators.map(x->parse(Int, x),list))) 
    oxygenBin = get_rating(count_and_code,get_oxygen,1)[1]
    co2Bin = get_rating(count_and_code,get_co2,1)[1]
    oxygen = parse(Int, join(oxygenBin); base=2)
    co2 = parse(Int, join(co2Bin); base=2)
    println("Life support: ",(oxygen * co2))
end
