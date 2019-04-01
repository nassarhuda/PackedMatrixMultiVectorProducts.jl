function benchmark(A,X)
    @assert A*X ≈ unpack(A*pack(X))
    println("###################")
    println("typeof(A) = $(typeof(A))")
    println("typeof(X) = $(typeof(X))")
    println("size(A) = $(size(A))")
    println("size(X) = $(size(X))")
    println("Benchmark Julia's matmul")
    b = @benchmark $A*$X
    display(b)
    println("")
    println("Benchmark PackedMatrixMultiVectorProducts")
    b = @benchmark unpack($A*pack($X))
    display(b)
    println("###################")
end

function benchmark(n::Int64,p::Float64,k::Int64)
    A = sprand(n,n,p)
    X = randn(n,k)
    Xt = randn(k,n)'
    At = A'
    benchmark(A,X)
    benchmark(A,Xt)
    benchmark(At,X)
    benchmark(At,Xt)
end

function benchmark()
    n = 50_000
    p = 10/50_000
    k = 16
    benchmark(n,p,k)
end