using Match
using Setfield
using Lazy

struct Position
    horizontal
    depth
end

get_direction(dir) = @match dir begin
        "forward" => forward
        "down" => down
        "up" => up
    end

forward(n, pos::Position) = @set pos.horizontal += n
down(n, pos::Position) = @set pos.depth += n
up(n, pos::Position) = @set pos.depth -= n

function get_new_position(state,cmd) 
    dir,n = cmd
    return get_direction(dir)(n,state)
end

parse_value = x-> @set x[2] = parse(Int64,x[2])

open("input") do input
    pos = @>> eachline(input)  map(parse_value ∘ split) foldl(get_new_position,init=Position(0,0))
    print(pos.horizontal * pos.depth)
end