using Match
using Accessors
using Lazy

struct Position
    horizontal
    depth
    aim
end

get_direction(dir) = @match dir begin
        "forward" => forward
        "down" => down
        "up" => up
    end

forward(n, pos::Position) = Position(pos.horizontal + n, pos.depth + (n * pos.aim), pos.aim)
down(n, pos::Position) = @set pos.aim += n
up(n, pos::Position) = @set pos.aim -= n

function get_new_position(state,cmd) 
    dir,n = cmd
    return get_direction(dir)(n,state)
end

parse_value = x -> @set x[2] = parse(Int64,x[2])

open("input2") do input
    pos = @>> eachline(input)  map(parse_value ∘ split) foldl(get_new_position,init=Position(0,0,0))
    print(pos.horizontal * pos.depth)
end