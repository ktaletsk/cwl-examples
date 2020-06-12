cwlVersion: v1.0
class: CommandLineTool

label: WIPP Mask labeling
doc: Mask labeling using NIST connected components algorithm

baseCommand: ["/usr/bin/java", "-jar", "/opt/executables/wipp-mask-labeling-plugin.jar"]
hints:
  DockerRequirement:
    dockerPull: wipp/wipp-mask-labeling-plugin:0.0.2
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
  connectedness:
    type:
      type: enum
      symbols: ["FOUR_CONNECTED","EIGHT_CONNECTED"]
      label: "Connectedness"
    inputBinding:
      prefix: --connectedness
  output:
    type: Directory
    label: "Output labeled mask"
    inputBinding:
      prefix: --output
outputs:
  masked_labeled_collection:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-label-output'