using Match
using Pipe

function get_code(code_dict)
    intersect_size(code, index) = @pipe (Set(code), code_dict[index]) |> intersect(_...) |> length
    code -> @match (length(code), intersect_size(code, 4), intersect_size(code, 2)) begin
        (2, _, _) => '1'
        (3, _, _) => '7'
        (4, _, _) => '4'
        (7, _, _) => '8'
        (5, 2, _) => '2'
        (5, 3, 1) => '5'
        (5, 3, 2) => '3'
        (6, 4, _) => '9'
        (6, 3, 1) => '6'
        (6, 3, 2) => '0'
    end
end

collect_numbers((code_dict, codes))::Int = @pipe split(codes) .|> get_code(code_dict) |> String |> parse(Int, _)

open("8/input") do input
    code = map(x -> (Dict(length(code) => Set(code) for code in split(x[1])), x[2]), split.(eachline(input), '|'))
    mapreduce(collect_numbers, +, code)
end