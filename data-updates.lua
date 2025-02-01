local tree_data = {
    ["ashland-lichen-tree"] = {{name = "carbon", type = "item", amount = 2}},
    ["ashland-lichen-tree-flaming"] = {
        {amount = 2, name = "carbon", type = "item"}
    },
    ["cuttlepop"] = {
        {amount = 8, name = "spoilage", type = "item"},
        {amount = 2, name = "wood", type = "item"}
    },
    ["slipstack"] = {
        {amount = 6, name = "spoilage", type = "item"},
        {amount = 4, name = "stone", type = "item"}
    },
    ["funneltrunk"] = {
        {amount = 4, name = "spoilage", type = "item"},
        {amount = 6, name = "wood", type = "item"}
    },
    ["hairyclubnub"] = {
        {amount = 5, name = "spoilage", type = "item"},
        {amount = 5, name = "wood", type = "item"}
    },
    ["teflilly"] = {
        {amount = 5, name = "spoilage", type = "item"},
        {amount = 5, name = "wood", type = "item"}
    },
    ["lickmaw"] = {{amount = 10, name = "spoilage", type = "item"}},
    ["stingfrond"] = {
        {amount = 8, name = "spoilage", type = "item"},
        {amount = 2, name = "wood", type = "item"}
    },
    ["boompuff"] = {
        {amount = 6, name = "spoilage", type = "item"},
        {amount = 4, name = "wood", type = "item"}
    },
    ["sunnycomb"] = {{amount = 10, name = "spoilage", type = "item"}},
    ["water-cane"] = {{amount = 1, name = "wood", type = "item"}}
}

for _, tree in pairs(data.raw.tree) do
    if tree_data[tree.name] then
        tree.minable.results = tree_data[tree.name]
        tree.minable.count = nil
        tree.minable.result = nil
    end
end
