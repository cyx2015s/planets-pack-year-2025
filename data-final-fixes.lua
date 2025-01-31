for _, recipe in pairs(data.raw["recipe"]) do
    local recipe_results = recipe.results
    if recipe_results and #recipe_results == 1 then 
        local result = recipe_results[1]
        if result.name == "rocket-part" then 
            local new_recipe = table.deepcopy(recipe)
            new_recipe.maximum_productivity = 15
            data:extend({new_recipe})
        end
    end
end