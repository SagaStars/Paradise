/obj/item/gun/proc/radial_check(mob/living/carbon/human/H)
	if(!QDELETED(src)|| !Adjacent(H) || H.incapacitated())
		return FALSE
	return TRUE
