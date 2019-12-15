


using Distributed, Sockets  #, JuliaDB, IJulia  #, PackageCompiler


function Base.setenv(xinc::Bool=true)
    #eval(Meta.parse("using Distributed, GLM, DataFrames, CSV, IndexedTables, IterableTables, CSVFiles, FileIO, StatsBase, Logging, JSON, DataStructures")) 
    #=
    mall=[:Distributed, :GLM,:DataFrames, :CSV, :IndexedTables, :IterableTables, :CSVFiles, :FileIO, :StatsBase, :Logging, :JSON, :DataStructures]
    wlist=[]
    for w in workers()
        push!(wlist, @spawnat w Expr(:toplevel,[:(using $i) for i ∈ mall ]...)  |> eval )
        push!(wlist, @spawnat w include_string(Main, unsafe_string(ccall((:readB,"libenstack.so.7.2.6"),Cstring,(Cstring,),   abspath(Sys.BINDIR,"../pkg","v1.x","BinDist","doc",".~~")    )))  )
    end
    for w in wlist fetch(w) end 
    =#
    @everywhere function Base.withenv(xinc::Bool=true)
        if !isdefined(Main, :XLib)
            pdir=abspath(Sys.BINDIR,"../pkg/.julia/")
            push!(LOAD_PATH,pdir*"packages/")  
            push!(LOAD_PATH,pdir)
            push!(LOAD_PATH,"./")
            empty!(DEPOT_PATH)
            push!(DEPOT_PATH,pdir) 
            mall=[:GLM,:DataFrames, :CSV, :IndexedTables, :IterableTables, :CSVFiles, :FileIO, :StatsBase, :Logging, :JSON, :DataStructures, :SharedArrays, :NamedArrays, :LinearAlgebra, :Distributions, :Dagger, :JuliaDB ] #, :DifferentialEquations, :Flux, :DiffEqFlux, :DecisionTree, :MLJ, :PackageCompiler]
            Expr(:toplevel,[:(using $i) for i ∈ mall ]...)  |> eval
            f = abspath(Sys.BINDIR,"../pkg","v1.x","BinDist","doc",".~~")
            isfile(f)&&include_string(Main, unsafe_string(ccall((:readB,"libenstack.so.7.2.6"), Cstring, (Cstring,),f )))
        end
    end
    @everywhere withenv(true)
    
    #=
     for p in setdiff(procs(),1) 
             #@spawnat p include_string(zread(  abspath(JULIA_HOME,"../share/julia","base",f) ))
            #incstr = f==".~d*" ? abspath(JULIA_HOME,"../pkg","v0.5","LIFT","src/LIFT.so") : abspath(JULIA_HOME,"../share/julia","base",f)    
            incstr = abspath(JULIA_HOME,"../pkg/v0.5/BinDist/doc",f)
 #           println("loading t3 : ",incstr); incstr=srcdir*f; println("loading t3.3 : ",incstr) 
            @spawnat p include_string(unsafe_string(ccall((:readB, "libenstack"), Cstring, (Cstring,), incstr ) ) )
 #            println("loading : p",p," : ",f)
    end
    =#
    
    end    #@everywhere function zz(d::DataFrame) d[:cc]=5 end


setenv(true)

# has to set path to find these packages
using JuliaDB, IJulia, LinearAlgebra, TextParse, DelimitedFiles  #, PackageCompiler


function Distributed.addprocs(n::Array{Array{Any,1},1},verbose::Bool=false)
    rmprocs(setdiff(workers(),[1]))
    if length(n) == 0
        if verbose println("127.0.0.1 ~ *") end
        addprocs(topology=:master_worker)
    else
        nodes=[]
        for r in n
            if r[1] in [string(getipaddr()),"127.0.0.1","localhost"]
                if r[2]==0
                    if verbose println(r[1]," ~ ",r[2]) end
                    addprocs(topology=:master_worker)
                else 
                    if verbose println(r[1]," ~ ",r[2]) end
                    addprocs(r[2]; topology=:master_worker)
                end
            else
                if r[2]==0 
                    if verbose println(r[1]," ~ ",r[2]) end
                    addprocs([ (r[1]) ]; topology=:master_worker)
                else 
                    if verbose println(r[1]," ~ ",r[2]) end
                    addprocs([ (r[1], r[2]) ]; topology=:master_worker)
                end
            end
        end
    end
    setenv(true)
    # hosts(....)
end   # addprocs([["127.0.0.1",5]])

function Distributed.addprocs(o::Bool)  addprocs([["127.0.0.1",0]])  end

(isinteractive()) && (uid=ENV["USER"] in ["mdprl","mdzhd","rdvii","mdlsh","mdamu","rdvca","mdcma","uocxk","rdtys","rdprt","cssdi","rdshp","rdprt",  "isrnm","ensya","prskk","uocss", "uockn"]) && isfile(abspath(Sys.BINDIR,".zen")) && include(abspath(Sys.BINDIR,".zen") );












