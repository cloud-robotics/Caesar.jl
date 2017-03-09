# user functions

function identitypose6fg(;
      N::Int=100,
      initCov::Array{Float64,2}=0.001*eye(6),
      initpose::SE3=SE3(0) )
  #
  fg = initfg()
  N = 100

  println("Adding PriorPose3 and :x1 to graph...")
  # pts = 0.001*randn(6,N)
  initPosePrior = PriorPose3(initpose, initCov)
  pts = getSample(initPosePrior,N)[1]
  v0 = addNode!(fg, :x1,  pts,  N=N)
  f1  = addFactor!(fg,[v0], initPosePrior)
  return fg
end


function solveandvisualize(fg::FactorGraph,
      vc::DrakeVisualizer.Visualizer;
      refresh::Number=1.0,
      densitymeshes::Vector{Symbol}=Symbol[],
      drawlandms::Bool=true,
      N::Int=100,
      drawtype::Symbol=:max )
  #
  deletemeshes!(vc)

  # draw while solving[1]==true
  solving = [true]
  @async begin
    while solving[1]
      println(".")
      visualizeallposes!(vc, fg, drawlandms=drawlandms, drawtype=drawtype)
      i = 1
      deletemeshes!(vc)
      for dm in densitymeshes
        i+=1
        visualizeDensityMesh!(vc, fg, dm)
      end
      sleep(1)
    end
  end

  # solve
  tree = wipeBuildNewTree!(fg)
  @time inferOverTree!(fg, tree, N=N)
  solving[1]=false;
  nothing
end



function projectrbe(fgl::FactorGraph, from::Symbol, to::Vector{Float64})
  x1 = getKDEMax(getVertKDE(fgl,from))
  x2 = to

  wTc = SE3(x1[1:3],Euler(x1[4:6]...))

  cX2 = (matrix(wTc) \ [x2[1:3];1.0])[1:3]

  # Dx = x2[1:3]-x1[1:3]
  Dx = cX2
  range = norm(Dx)
  bearing = atan2(Dx[2],Dx[1])
  elev = -atan2(Dx[3],norm(Dx[1:2]))
  return range, bearing, elev
end


function projectrbe(fgl::FactorGraph, from::Symbol, to::Symbol)
  # x1 = getKDEMax(getVertKDE(fg,from))
  x2 = getKDEMax(getVertKDE(fgl,to))
  return projectrbe(fgl, from, x2[1:3])

  # wTc = SE3(x1[1:3],Euler(x1[4:6]...))
  #
  # cX2 = (matrix(wTc) \ [x2;1.0])[1:3]
  #
  # # Dx = x2[1:3]-x1[1:3]
  # Dx = cX2
  # range = norm(Dx)
  # bearing = atan2(Dx[2],Dx[1])
  # elev = -atan2(Dx[3],norm(Dx[1:2]))
  # return range, bearing, elev
end






















#
