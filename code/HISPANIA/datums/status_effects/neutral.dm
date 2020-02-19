// holdup is for the person being aimed
/datum/status_effect/heldup
	id = "heldup"
	duration = -1
	status_type = STATUS_EFFECT_MULTIPLE
	alert_type = /obj/screen/alert/status_effect/heldup

/obj/screen/alert/status_effect/heldup
	name = "Held Up"
	desc = "Making any sudden moves would probably be a bad idea!"
	icon_state = "aimed"
	icon = 'icons/hispania/mob/screen_alert.dmi'

// holdup is for the person aiming
/datum/status_effect/holdup
	id = "holdup"
	duration = -1
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /obj/screen/alert/status_effect/holdup

/obj/screen/alert/status_effect/holdup
	name = "Holding Up"
	desc = "You're currently pointing a gun at someone."
	icon_state = "aimed"
	icon = 'icons/hispania/mob/screen_alert.dmi'