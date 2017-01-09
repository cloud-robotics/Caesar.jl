module Caesar

using
  RoME,
  IncrementalInference,
  Graphs,
  KernelDensityEstimate,
  DrakeVisualizer,
  TransformUtils,
  CoordinateTransformations,
  GeometryTypes,
  Rotations,
  Gadfly,
  Colors,
  ColorTypes,
  JLD,
  HDF5,
  JSON,
  MeshIO,
  FileIO,
  NLsolve
  #CloudGraphs

# using GraphViz, Fontconfig, Cairo, Distributions, DataFrames

export
  # Victoria Park example -- batch
  loadVicPrkDataset,
  # addLandmarksFactoGraph!,
  # appendFactorGraph!,
  # doBatchRun,
  # insitu component
  GenericInSituSystem,
  makeGenericInSituSys,
  InSituSystem,
  makeInSituSys,
  triggerPose,
  poseTrigAndAdd!,
  processTreeTrackersUpdates!,
  advOdoByRules,
  progressExamplePlot,
  plotPoseDict,
  plotTrckStep,
  SLAMWrapper,

  # servers
  tcpStringSLAMServer,
  tcpStringBRTrackingServer,

  # save and load data
  saveSlam,
  loadSlam,

  # cloudgraph
  usecloudgraphsdatalayer!,
  # CloudGraph stuff
  registerGeneralVariableTypes!,
  fullLocalGraphCopy!,
  removeGenericMarginals!,
  setBackendWorkingSet!,
  setDBAllReady!,
  getExVertFromCloud,
  getAllExVertexNeoIDs,
  getPoseExVertexNeoIDs,
  copyAllNodes!,
  copyAllEdges!,
  registerCallback!,

  # drawing functions
  VisualizationContainer,
  startdefaultvisualization,
  newtriad!,
  visualizetriads,
  visualizeallposes!,
  visualizeDensityMesh!,

  # for models
  loadmodel,
  DrawModel,
  DrawROV,

  # more drawing utils
  ArcPointsRangeSolve,
  findaxiscenter!,
  parameterizeArcAffineMap,
  animatearc,

  # default scenes
  defaultscene01!,

  # user functions
  identitypose6fg,
  projectrbe,
  solveandvisualize,

  # repeats from RoME and IIF
  initfg,
  addNode!,
  addFactor!



# include("CloudGraphIntegration.jl") # Work in progress code

include("SlamServer.jl")
include("BearingRangeTrackingServer.jl")

include("DataUtils.jl")

include("VisualizationUtils.jl")
include("ModelVisualizationUtils.jl")

include("UserFunctions.jl")

end
