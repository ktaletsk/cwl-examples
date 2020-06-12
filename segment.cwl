cwlVersion: v1.0
class: CommandLineTool

label: EGTSegmentation plugin
doc: Efficient EGT Segmentation (C++)

baseCommand: /home/commandLineCli
hints:
  DockerRequirement:
    dockerPull: ktaletsk/wipp-egt-plugin:1.1.7
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.output_images) 
        writable: true
inputs:
  images:
    type: Directory
    inputBinding:
      prefix: --images
  output_images:
    type: Directory
    inputBinding:
      prefix: --output
  minhole:
    type: int
    inputBinding:
      prefix: --minhole
  minobject:
    type: int
    inputBinding:
      prefix: --minobject
  greedy:
    type: int?
    inputBinding:
      prefix: --greedy
  depth:
    type: string
    inputBinding:
      prefix: --depth
  applyLabel:
    type: string?
    inputBinding:
      prefix: --label
  expert:
    type: string?
    label: "Undocumented parameter for advanced control"
    inputBinding:
      prefix: --expert
outputs:
  output:
    type: Directory
    outputBinding:
      glob: 'small-fluoro-test-seg-output'