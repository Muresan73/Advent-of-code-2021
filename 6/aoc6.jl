using Lazy
using ThreadsX

fisher(acc,fish) = fish > 0 ? push!(acc, fish-1) : append!(acc, [8,6])

function worker(element)
    fishes = [element]
    i = 80 - 1
    for i in 1:i
        # i % 20 == 0  && println(i)
        fishes = map(x->x-1,fishes)
        zeros = count(x->x==0,fishes)
        if zeros > 0
            sixes = fill(7, zeros)
            eights = fill(9, zeros)
            fishes = vcat(sixes, eights,filter(x->x!=0,fishes))
        end
    end
    return length(fishes)
end


function calulate_offsprint(days)
    days < 0 && return 1
    calulate_offsprint(days-7) + calulate_offsprint(days-9)
end

open("6/input") do input
    fishes = @> read(input,String) split(',')
    fishes = parse.(Int64,fishes)

    # println(ThreadsX.mapreduce(worker,+, fishes))
    @time println(ThreadsX.mapreduce(number -> calulate_offsprint(256-number-1),+, fishes))
end