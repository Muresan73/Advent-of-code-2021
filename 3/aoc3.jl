using Lazy

get_gamma(size, code) = map(x-> x > size/2 ? 1 : 0, code)

get_epsilon(size, code)  = map(x-> x > size/2 ? 0 : 1, code)

open("input") do input
    count_and_code = @>> eachline(input) map(list->[1,(collect(Iterators.map(x->parse(Int, x),list)))...]) reduce(+)
    size, code = Iterators.peel(count_and_code)
    
    gammaBin = join(get_gamma(size, code))
    epsilonBin = join(get_epsilon(size, code))
 
    gamma = parse(Int, gammaBin; base=2)
    epsilon = parse(Int, epsilonBin; base=2)
    println(gamma * epsilon)
end