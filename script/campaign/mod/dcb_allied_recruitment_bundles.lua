-- Check if MCT is installed and, if so, check the user-defined multiplier value and ensure it's valid. Default otherwise is 2400.
local function dcb_mct_check()
	if not get_mct then return 2400 end;
	local value = get_mct():get_mod_by_key("dcb_allied_recruit_buffs"):get_option_by_key("multiplier"):get_finalized_setting();
	if type(value) ~= "number" or value < 1 then return 2400 end;
	out("MCT found, user-defined multiplier slider value is " .. tostring(value) .. ".");
	return (math.floor(value) * 100);
end;

-- wh3_main_effect_allegiance_points_mod = Percentage allied allegiance point gain adjustment
-- wh3_main_effect_allegiance_points_loan_army_mod = Percentage cost adjustment for borrowing an allied army

local function dcb_points_gain_bundle(faction_bundle)
    local multiplier = dcb_mct_check();
	faction_bundle:add_effect("wh3_main_effect_allegiance_points_mod", "faction_to_faction_own_unseen", multiplier);
	out("Final bundle multiplier is " .. tostring(multiplier) .. ".");
	out("");
end;

-- Parse all factions to identify human players, apply bundle.
local function dcb_apply_bundle()
    local faction_list = cm:model():world():faction_list();
    local points_bundle = cm:create_new_custom_effect_bundle("dcb_allied_recruitment_add_points");
    
    for i = 0, faction_list:num_items() - 1 do
        local current_faction = faction_list:item_at(i);
        local current_faction_name = current_faction:name();
        
        if current_faction:is_human() then
            out("Faction " .. current_faction_name .. " is human. Turn number is " .. tostring(cm:turn_number()) .. ".");
			out("Applying allegiance points gain multiplier bundle.");

			-- Add the effects to the bundle, then apply the bundle to the faction. Will overwrite an existing bundle with the same name.
			dcb_points_gain_bundle(points_bundle);
			cm:apply_custom_effect_bundle_to_faction(points_bundle, cm:get_faction(current_faction_name));
        end;
    end;
end;

cm:add_first_tick_callback(
    function()
        out("");
        out("======================== DCB ALLIED RECRUITMENT BUFFS: ========================");
        out("");
        
        dcb_apply_bundle();
        
        out("===============================================================================");
        out("");
    end
);