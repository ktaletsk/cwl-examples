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
  greedy: int
  applyLabel: string
  minhole: int
  minobject: int
  connectedness:
    type:
      type: enum
      symbols: ["FOUR_CONNECTED","EIGHT_CONNECTED"]
      label: "Connectedness"
  iP: string
  pP: string
  features: string[]
  outputPath: Directory
  pyramidCollection: Directory
  assembledCollection: Directory
  segmentedCollection: Directory
  maskLabeledCollection: Directory
  featuresCollection: Directory
outputs:
  stitchVector:
    type: Directory
    outputSource: stitch/output
  pyramid:
    type: Directory
    outputSource: pyramid/output_pyramid
  assembled:
    type: Directory
    outputSource: assemble/assembled_collection
  segmented:
    type: Directory
    outputSource: segment/output
  maskedLabeled:
    type: Directory
    outputSource: mask_label/masked_labeled_collection
  features:
    type: Directory
    outputSource: extract_features/output
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
      output: pyramidCollection
    out: [output_pyramid]
  assemble:
    run: assemble.cwl
    in:
      inputImages: imageDir
      inputStitchingVector: stitch/output
      output: assembledCollection
    out: [assembled_collection]
  segment:
    run: segment.cwl
    in:
      images: assemble/assembled_collection
      output_images: segmentedCollection
      minhole: minhole
      minobject: minobject
      greedy: greedy
      depth: depth
      applyLabel: applyLabel
    out: [output]
  mask_label:
    run: mask-label.cwl
    in:
      inputImages: segment/output
      connectedness: connectedness
      output: maskLabeledCollection
    out: [masked_labeled_collection]
  extract_features:
    run: feature.cwl
    in:
      imageDir: assemble/assembled_collection
      partitionsDir: mask_label/masked_labeled_collection
      outputDir: featuresCollection
      iP: iP
      pP: pP
      features: features
    out: [output]