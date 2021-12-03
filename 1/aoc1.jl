
open("input") do input
    buffer = map(x->parse(Int64,x),eachline(input))
    b2 = buffer[2:end]
    b3 = buffer[3:end]
    bufferZip = zip(buffer,b2,b3)
    a1 = map(sum,bufferZip)
    a2 = a1[2:end]
    sumZip = zip(a1,a2)
    print( count(((prev,current),) -> prev < current ,sumZip) )
end

