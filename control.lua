local function random_teleport(player)
    local candidates = {}
    local on_planet = false
    for _, planet in pairs(game.planets) do
        if planet.surface == nil then goto continue end -- if not visited
        if player.surface == planet.surface then -- must on a planet, and cannot teleport to original planet
            on_planet = true
            goto continue
        end
        if planet.prototype.hidden then goto continue end -- deal with trench
        if planet.name == "nauvis" and
            player.force.technologies["planet-discovery-nauvis"].researched ==
            false then goto continue end -- deal with lignumis mod
        candidates[#candidates + 1] = planet.name
        ::continue::
    end
    if #candidates == 0 or on_planet ~= true then
        player.print({"random-teleport-no-planet"})
        return
    end
    local surface_name = candidates[math.random(1, #candidates)]
    local surface = game.surfaces[surface_name]
    local position = surface.find_non_colliding_position("character", {0, 0},
                                                         100, 1, true)
    if position == nil then
        player.print({"random-teleport-no-space", surface_name})
        return
    end
    player.teleport(position, surface_name, true)
    storage.last_teleport_time[player.name] = game.tick
    game.print({"random-teleported", player.name, surface_name})
end

commands.add_command("random_teleport", {"random-teleport-help"},
                     (function(command)
    if command.player_index == nil then return end
    local player = game.players[command.player_index]
    local player_name = player.name
    storage.last_teleport_time = storage.last_teleport_time or {}
    storage.last_teleport_time[player_name] =
        storage.last_teleport_time[player_name] or 0
    local delta_time = game.tick - storage.last_teleport_time[player_name]
    if delta_time < 60 * 60 * 30 and player.admin ~= true then
        player.print({
            "random-teleport-cooldown", 30, math.floor((delta_time) / 3600)
        })
        return
    end
    for _, inventory_id in pairs({
        defines.inventory.character_main, defines.inventory.character_ammo,
        defines.inventory.character_trash
    }) do
        local inventory = player.get_inventory(inventory_id)
        if inventory == nil or inventory.is_empty() == false then
            player.print({"random-teleport-inventory-not-empty"})
            return
        end
    end
    random_teleport(game.players[command.player_index])
end))

script.on_init(function() storage.last_teleport_time = {} end)

script.on_event(defines.events.on_player_joined_game, (function(event)
    local player = game.players[event.player_index]
    if #game.players == 1 then return end -- skip the first player
    if storage.last_teleport_time[player.name] then return end -- skip if already played once
    random_teleport(player)
    game.print({"server-welcome", player.name})
end))

local function starts_with(str, start)
    return str:sub(1, #start) == start
end

script.on_event(defines.events.on_cutscene_started, function(event)
    local player_index = event.player_index
    if player_index == nil then return end
    player = game.get_player(player_index)
    if player_index == 1 then return end
    player.exit_cutscene()
    local surface = player.surface
    local names = {}
    local entities = surface.find_entities({{-100, -100}, {100, 100}})
    for _, entity in pairs(entities) do
        if starts_with(entity.name, "crash-site") then
            entity.destroy()
        end
    end
end)


commands.add_command("fix_cutscene", {"fix-cutscene-help"}, (function (event)
    for _, player in pairs(game.players) do
        if player.gui.screen.skip_cutscene_label then
            player.gui.screen.skip_cutscene_label.destroy()
        end
    end
end))

