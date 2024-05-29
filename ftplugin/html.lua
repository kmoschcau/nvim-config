local has_otter, otter = pcall(require, "otter")
if has_otter then
  otter.activate { "css", "javascript" }
end
