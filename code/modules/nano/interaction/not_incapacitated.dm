 /**
  * This state only checks if the user isn't incapacitated
 **/

/var/global/datum/topic_state/not_incapacitated_state/not_incapacitated_state = new()

 /**
  * This state checks if the user isn't incapacitated and that their loc is a turf
 **/

/var/global/datum/topic_state/not_incapacitated_state/not_incapacitated_turf_state = new(no_turfs = TRUE)

/datum/topic_state/not_incapacitated_state
	var/turf_check = FALSE

/datum/topic_state/not_incapacitated_state/New(loc, no_turfs = FALSE)
	..()
	turf_check = no_turfs

/datum/topic_state/not_incapacitated_state/can_use_topic(src_object, mob/user)
	if(user.stat)
		return STATUS_CLOSE
	if(user.incapacitated()|| (turf_check && !isturf(user.loc)))
		return STATUS_DISABLED
	return STATUS_INTERACTIVE