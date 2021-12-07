using Lazy
using Statistics

open("7/input") do input
    crabs = @> read(input,String) split(',')
    crabs = parse.(Int64,crabs)
    median = Statistics.median(crabs)
    mapreduce(x->abs(x-median),+,crabs)
end