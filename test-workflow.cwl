cwlVersion: v1.0
class: Workflow
inputs:
  imageDir: Directory
  filenamePatternType:
    type:
      type: enum
      label: "Filename Pattern Type"
      symbols: [ROWCOL, SEQUENTIAL]
  filenamePattern: string
  gridOrigin:
    type:
      type: enum
      label: "Starting Point"
      symbols: [UL, UR, LL, LR]
  numberingPattern:
    type:
      - "null"
      - type: enum
        label: "Direction"
        symbols: [VERTICALCOMBING, VERTICALCONTINUOUS, HORIZONTALCOMBING, HORIZONTALCONTINUOUS]
  gridWidth:
    type: int
    label: "Grid Width"
  gridHeight:
    type: int
    label: "Grid Height"
  startTile:
    type:
      - "null"
      - type: enum
        label: "Start tile"
        symbols: ["0", "1"]
  startTileRow:
    type:
      type: enum
      label: "Start tile row"
      symbols: ["0", "1"]
  startTileCol:
    type:
      type: enum
      label: "Start tile column"
      symbols: ["0", "1"]
  startRow:
    type: int
    label: "Subgrid start row"
  startCol:
    type: int
    label: "Subgrid start column"
  extentWidth:
    type: int
    label: "Subgrid extent width"
  extentHeight:
    type: int
    label: "Subgrid extent height"
  isTimeSlices:
    type: 
      type: enum
      label: "Start tile column"
      symbols: ["false", "true"]
    label: "Has timeslices"
  timeSlices:
    type: string?
    label: "Timeslices"
  assembleNoOverlap:
    type:
      type: enum
      label: "Whether or not to assemble images without overlap"
      symbols: ["False", "True"]
  stageRepeatability:
    type: int
    label: "Stage repeatability"
  horizontalOverlap:
    type: int?
    label: "Horizontal Overlap"
  verticalOverlap:
    type: int?
    label: "Vertical Overlap"
  overlapUncertainty:
    type: int
    label: "Overlap Uncertainty"
  programType:
    type:
      type: enum
      label: "Stitching Program"
      symbols: [JAVA, FFTW, CUDA]
  outputPath:
    type: Directory
    label: "Output stitching vector"
  blending:
    type:
      - "null"
      - type: enum
        symbols: ["overlay", "max"]
        label: "Blending method when assembling tiles"
  depth:
    type:
      type: enum
      symbols: ["8U", "16U"]
      label: "Image depth"
  expert: string?
  output: Directory
outputs:
  stitchVector:
    type: Directory
    outputSource: stitch/output
  pyramid:
    type: Directory
    outputSource: pyramid/output_pyramid

steps:
  stitch:
    run: stitch.cwl
    in:
      imageDir: imageDir
      filenamePatternType: filenamePatternType
      filenamePattern: filenamePattern
      gridOrigin: gridOrigin
      numberingPattern: numberingPattern
      gridWidth: gridWidth
      gridHeight: gridHeight  
      startTile: startTile
      startTileRow: startTileRow
      startTileCol: startTileCol
      startRow: startRow
      startCol: startCol
      extentWidth: extentWidth
      extentHeight: extentHeight
      isTimeSlices: isTimeSlices
      timeSlices: timeSlices
      assembleNoOverlap: assembleNoOverlap
      stageRepeatability: stageRepeatability
      horizontalOverlap: horizontalOverlap
      verticalOverlap: verticalOverlap
      overlapUncertainty: overlapUncertainty
      programType: programType
      outputPath: outputPath
    out: [output]
  pyramid:
    run: pyramid.cwl
    in:
      inputImages: imageDir
      inputStitchingVector: stitch/output
      blending: blending
      depth: depth
      expert: expert
      output: output
    out: [output_pyramid]