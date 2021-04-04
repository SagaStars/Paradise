/obj/machinery/tcomms/core/station/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/pendrive))
		var/datum/game_mode/fugitive/fugitive = SSticker.mode.eventmode
		if(fugitive)
			do_sparks(3, 1, src)
			ion = TRUE
			update_icon()
			//mandarevento
			qdel(O)
			spawn()
				sleep(3000) // 5 Minutos sin comms, looool
				ion = FALSE
				update_icon()
		else
			do_sparks(3, 1, src)
			qdel(O)
	..()

/obj/machinery/computer/message_monitor/attackby(obj/item/O, mob/user, params)
	if(istype(O, /obj/item/pendrive))
		var/datum/game_mode/fugitive/fugitive = SSticker.mode.eventmode
		if(fugitive)
			do_sparks(3, 1, src)
			qdel(O)
		else
			do_sparks(3, 1, src)
			qdel(O)
	..()
