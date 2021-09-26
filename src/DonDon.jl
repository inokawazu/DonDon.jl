module DonDon

using Statistics, Dates

"Adds the current unix time (Float64) to the end of an array"
function add_time!(times)
    push!(times, datetime2unix(now()))
end

function get_differences(times)
    length(times) < 2 && return zero(times)

    befores = times[1:end-1]
    afters = times[2:end]

    return afters .- befores 
end

function report_beats(times)
    beats_per_min = 60 ./ get_differences(times)
    println("The average beat time is " , mean(beats_per_min), " with an standard deviation of ", std(beats_per_min))
    return
end

function main()
    beat_times = Float64[]
    count = 0
    while true
        println("Press enter to record a beat, enter with q to stop. Beat: $count")
        stop = readline()
        if stop == "q"
            break
        end
        add_time!(beat_times)
        count+=1
    end
    pop!(beat_times)
    popfirst!(beat_times)
    report_beats(beat_times)
    return
end

end # module
