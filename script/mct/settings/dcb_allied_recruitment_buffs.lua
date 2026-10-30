-- Check MCT exists, exit if not
if not get_mct then return end

-- Define mod
local mct = get_mct();
local mod = mct:register_mod("dcb_allied_recruit_buffs");
mod:set_workshop_id("2790221255");
mod:set_author("DrDCB");
mod:set_main_image("ui/images/dcb_allied_recruitment_buffs.png", 300, 300);

-- Other text is defined in localisation keys rather than hardcoded, to allow for easier translation (text/db/dcb_allied_recruitment_buffs_mct.loc).
-- mct_dcb_allied_recruit_buffs_title					Mod title
-- mct_dcb_allied_recruit_buffs_description				Mod description
-- mct_dcb_allied_recruit_buffs_gain_section_text		Section title
-- mct_dcb_allied_recruit_buffs_multiplier_text			Slider description
-- mct_dcb_allied_recruit_buffs_multiplier_tooltip		Slider tooltip

-- Create a sub-section.
mod:add_new_section("gain", "");

-- Add a slider, define extents/values.
local multiplier = mod:add_new_option("multiplier", "slider");
multiplier:slider_set_precision(0);
multiplier:slider_set_step_size(1, 0);
multiplier:slider_set_min_max(1, 500);
multiplier:set_default_value(24);
