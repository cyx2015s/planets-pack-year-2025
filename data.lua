local lignumis_recipe_names = {
    "low-density-structure-gold",
    "rocket-fuel-from-wood-pulp-and-peat"
}

for _, recipe_name in pairs(lignumis_recipe_names) do
    if data.raw.recipe[recipe_name] then
        local not_recyclable_recipe = table.deepcopy(data.raw.recipe[recipe_name])
        not_recyclable_recipe["auto_recycle"] = false
        data:extend({not_recyclable_recipe})
    end
end