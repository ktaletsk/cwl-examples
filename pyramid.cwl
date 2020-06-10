cwlVersion: v1.0
class: CommandLineTool

label: WIPP Pyramid building
doc: Pyramid building using NIST accelerated algorithm

baseCommand: ["/usr/bin/java", "-jar", "/opt/executables/wipp-pyramid-plugin.jar"]
hints:
  DockerRequirement:
    dockerPull: ktaletsk/wipp-pyramid-plugin:0.0.6

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
  blending:
    type:
      - "null"
      - type: enum
        symbols: ["overlay", "max"]
        label: "Blending method when assembling tiles"
    inputBinding:
      prefix: --blending
  depth:
    type:
      type: enum
      symbols: ["8U", "16U"]
      label: "Image depth"
    inputBinding:
      prefix: --depth
  expert:
    type: string?
    label: "Undocumented parameter for advanced control"
    inputBinding:
      prefix: --expert
  output:
    type: Directory
    label: "Output pyramid"
    inputBinding:
      prefix: --output
outputs:
  output_pyramid:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-pyr'