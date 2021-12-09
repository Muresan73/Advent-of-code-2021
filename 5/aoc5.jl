using Lazy

struct Point
    x::Int
    y::Int
end

Point(string) = Point(parse.(Int64, split(string, ','))...)


function is_intersect(p0, p1, p2, p3)

    p0.x == p1.x == p2.x == p3.x && (max(p0.y,p1.y) > min(p2.y,p3.y) && max(p2.y,p3.y) > min(p0.y,p1.y)) && return true
    p0.y == p1.y == p2.y == p3.y && (max(p0.x,p1.x) > min(p2.x,p3.x) && max(p2.x,p3.x) > min(p0.x,p1.x)) && return true

    s10_x = p1.x - p0.x
    s10_y = p1.y - p0.y
    s32_x = p3.x - p2.x
    s32_y = p3.y - p2.y

    denom = s10_x * s32_y - s32_x * s10_y
    denom == 0 && return false # collinear

    denom_is_positive = denom > 0

    s02_x = p0.x - p2.x
    s02_y = p0.y - p2.y

    s_numer = s10_x * s02_y - s10_y * s02_x

    (s_numer < 0) == denom_is_positive && return false # no collision

    t_numer = s32_x * s02_y - s32_y * s02_x

    (t_numer < 0) == denom_is_positive && return false # no collision

    (s_numer > denom) == denom_is_positive || (t_numer > denom) == denom_is_positive && return false # no collision

    true
end

function get_intersection(p0, p1, p2, p3)

    p0.x == p1.x == p2.x == p3.x &&

    s32_x = p3.x - p2.x
    s32_y = p3.y - p2.y
    s02_x = p0.x - p2.x
    s02_y = p0.y - p2.y
    s10_x = p1.x - p0.x
    s10_y = p1.y - p0.y
    denom = s10_x * s32_y - s32_x * s10_y
    t_numer = s32_x * s02_y - s32_y * s02_x
    t = t_numer / denom

    intersection_point = Point(p0.x + (t * s10_x), p0.y + (t * s10_y))
    return intersection_point
end

println(get_intersection(Point(0, 0), Point(0, 3), Point(0, 0), Point(0, 1)))
# println(is_intersect(Point(0, 0), Point(0, 1), Point(0, 2), Point(0, 3)))
# println(get_intersection(Point(0, 0), Point(0, 3), Point(3, 0), Point(0, 0)))


# open("5/test") do input
#     point_pair = @>> eachline(input) map(list -> Point.(deleteat!(split(list), 2))) filter(((a, b),) -> a.x == b.x || a.y == b.y)
#     Set([get_intersection(p1..., p2...) for p1 in point_pair for p2 in point_pair if is_intersect(p1..., p2...)])
# end