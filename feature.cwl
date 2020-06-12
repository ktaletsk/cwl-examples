cwlVersion: v1.0
class: CommandLineTool
baseCommand: ["java", "-cp", "/opt/executables/ImageFeatureExtraction-1.0-SNAPSHOT/*", "gov.nist.itl.featureextraction.FeatureExtraction"]
hints:
  DockerRequirement:
    dockerPull: wipp/wipp-feature2djava-plugin:1.4.0
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.outputDir) 
        writable: true
inputs:
  imageDir:
    type: Directory
    label: "Images (raw)"
    inputBinding:
      prefix: --imageDir
  partitionsDir:
    type: Directory?
    label: "Images partitions (masks)"
    inputBinding:
      prefix: --partitionsDir
  outputDir:
    type: Directory
    label: "Output CSV files"
    inputBinding:
      prefix: --outputDir
  iP:
    type: string
    label: "Image names pattern (regular expression)"
    inputBinding:
      prefix: --iP
  pP:
    type: string?
    label: "Mask names pattern (regular expression)"
    inputBinding:
      prefix: --pP
  features:
    type: string[]
    inputBinding:
      prefix: --features
      itemSeparator: ","
outputs:
  output:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-feat-outputDir'