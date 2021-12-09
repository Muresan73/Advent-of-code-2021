using Lazy

segment_count = [2, 4, 3, 7]
filter_segment(list) = filter(elem->elem in segment_count,list)

open("8/input") do input
    code = mapreduce(x->x[2] |> split .|> length |> filter_segment |> length, + , split.(eachline(input),'|'))
end
