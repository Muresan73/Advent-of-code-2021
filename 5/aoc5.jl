using Lazy

struct Point
    x
    y
end

Point(string) = Point(parse.(Int64,split(string,','))...)

open("5/input") do input
    @show point_pair = @>> Iterators.take(eachline(input),5) map(list -> Point.(deleteat!(split(list),2))) filter(((a,b),) -> a.x == b.x || a.y == b.y)

end
