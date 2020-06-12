cwlVersion: v1.0
class: CommandLineTool

label: WIPP Image assembling
doc: Image assembling using NIST pyramidio

baseCommand: ["/usr/bin/java", "-jar", "/opt/executables/wipp-image-assembling-plugin.jar"]
hints:
  DockerRequirement:
    dockerPull: wipp/wipp-image-assembling-plugin:0.0.2
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output)
        writable: true
inputs:
  inputImages:
    type: Directory
    label: "Input Images"
    inputBinding:
      prefix: --inputImages
  inputStitchingVector:
    type: Directory
    label: "Input Stitching Vector"
    inputBinding:
      prefix: --inputStitchingVector
  output:
    type: Directory
    label: "Output assembled image"
    inputBinding:
      prefix: --output
outputs:
  assembled_collection:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-assemb-output'