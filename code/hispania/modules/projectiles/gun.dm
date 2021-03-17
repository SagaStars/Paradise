/obj/item/gun/proc/radial_check(mob/M)
	var/mob/living/carbon/human/H = M
	if(!src || !Adjacent(H) || H.incapacitated())
		return FALSE
	return TRUE
