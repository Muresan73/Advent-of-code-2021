

@enum Sagittal Desc Asc

function travers(list,orientation,set::Set,get_pos,index)
    if length(list) < 2
        orientation == :desc && push!(set, (get_pos(index),parse(Int,list[1])))
        return set
    end

    (current,next,tail...) = list
    if current < next
        orientation == :desc && push!(set, (get_pos(index),parse(Int,current)))
        travers([next,tail...],:asc,set,get_pos,index+1)
    else
        travers([next,tail...],:desc,set,get_pos,index+1)
    end
end


# travers([1,2,3,0,1,2,0],:desc,Set(),1,1)


open("9/input") do input
     geo_map =  collect.(eachline(input))
      geo_map_v = map(x-> getindex.(geo_map,x),1:length(geo_map[1]))

    low = mapreduce(((index, value),) -> travers(value,:desc,Set(),i->(i,index),1),union,enumerate(geo_map))
    low_v = mapreduce(((index, value),) -> travers(value,:desc,Set(),i->(index,i),1),union,enumerate(geo_map_v))
    mapreduce(x->x[2]+1,+,intersect(low,low_v))
end