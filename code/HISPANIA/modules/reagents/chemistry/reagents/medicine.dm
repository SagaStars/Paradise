/datum/reagent/medicine/moa_complement
	name = "CentComm certified oxygen"
	id = "moa_complement"
	reagent_state = LIQUID
	heart_rate_decrease = 1
	can_synth = FALSE
	taste_description = "a mint leaf"

/datum/reagent/medicine/moa_complement/on_mob_life(mob/living/M)
		var/update_flags = STATUS_UPDATE_NONE
		update_flags |= M.adjustOxyLoss(-16, FALSE)
		update_flags |= M.SetEyeBlind(1, FALSE)
		M.SetSlowed(3)
		return ..() | update_flags