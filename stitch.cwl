cwlVersion: v1.0
class: CommandLineTool

label: MIST plugin
doc: Microscopy Image Stitching Tool

baseCommand: ["/usr/bin/java", "-jar", "/opt/executables/MIST.jar"]
hints:
  DockerRequirement:
    dockerPull: wipp/mist:2.0.7
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outputPath)
        writable: true
inputs:
  imageDir:
    type: Directory
    label: "Input Images"
    inputBinding:
      prefix: --imageDir
  filenamePatternType:
    type:
      type: enum
      label: "Filename Pattern Type"
      symbols: [ROWCOL, SEQUENTIAL]
    inputBinding:
      prefix: --filenamePatternType
  filenamePattern:
    type: string
    label: "Filename Pattern"
    inputBinding:
      prefix: --filenamePattern
  gridOrigin:
    type:
      type: enum
      label: "Starting Point"
      symbols: [UL, UR, LL, LR]
    inputBinding:
      prefix: --gridOrigin
  # numberingPattern:
  #   type:
  #     - "null"
  #     - type: enum
  #       label: "Direction"
  #       symbols: [VERTICALCOMBING, VERTICALCONTINUOUS, HORIZONTALCOMBING, HORIZONTALCONTINUOUS]
  #   inputBinding:
  #     prefix: --numberingPattern
  gridWidth:
    type: int
    label: "Grid Width"
    inputBinding:
      prefix: --gridWidth
  gridHeight:
    type: int
    label: "Grid Height"
    inputBinding:
      prefix: --gridHeight
  # startTile:
  #   type:
  #     - "null"
  #     - type: enum
  #       label: "Start tile"
  #       symbols: [0, 1]
  #   inputBinding:
  #     prefix: --startTile
  startTileRow:
    type:
      type: enum
      label: "Start tile row"
      symbols: ["0", "1"]
    inputBinding:
      prefix: --startTileRow
  startTileCol:
    type:
      type: enum
      label: "Start tile column"
      symbols: ["0", "1"]
    inputBinding:
      prefix: --startTileCol
  startRow:
    type: int
    label: "Subgrid start row"
    inputBinding:
      prefix: --startRow
  startCol:
    type: int
    label: "Subgrid start column"
    inputBinding:
      prefix: --startCol
  extentWidth:
    type: int
    label: "Subgrid extent width"
    inputBinding:
      prefix: --extentWidth
  extentHeight:
    type: int
    label: "Subgrid extent height"
    inputBinding:
      prefix: --extentHeight
  isTimeSlices:
    type: 
      type: enum
      label: "Start tile column"
      symbols: ["false", "true"]
    label: "Has timeslices"
    inputBinding:
      prefix: --isTimeSlices
  timeSlices:
    type: string?
    label: "Timeslices"
    inputBinding:
      prefix: --timeSlices
  assembleNoOverlap:
    type:
      type: enum
      label: "Whether or not to assemble images without overlap"
      symbols: ["False", "True"]
    inputBinding:
      prefix: --assembleNoOverlap
  stageRepeatability:
    type: int
    label: "Stage repeatability"
    inputBinding:
      prefix: --stageRepeatability
  horizontalOverlap:
    type: int?
    label: "Horizontal Overlap"
    inputBinding:
      prefix: --horizontalOverlap
  verticalOverlap:
    type: int?
    label: "Vertical Overlap"
    inputBinding:
      prefix: --verticalOverlap
  overlapUncertainty:
    type: int
    label: "Overlap Uncertainty"
    inputBinding:
      prefix: --overlapUncertainty
  programType:
    type:
      type: enum
      label: "Stitching Program"
      symbols: [JAVA, FFTW, CUDA]
    inputBinding:
      prefix: --programType
  outputPath:
    type: Directory
    label: "Output stitching vector"
    inputBinding:
      prefix: --outputPath
outputs:
  output:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-stitch-outputPath'