#define SPECIAL_ROLE_FUGITIVE "Fugitive"

/datum/event/spawn_fugitive
	announceWhen = 120
	var/key_of_fugitive

/datum/event/spawn_fugitive/announce()
	//GLOB.event_announcement.Announce("Unknown entity detected aboard [station_name()]. Please report any sightings to local authority.", "Bioscan Alert", 'sound/hispania/effects/oldman/alert.ogg')

/datum/event/spawn_fugitive/proc/fugitivo()
	spawn()
		var/list/candidates = pollCandidatesWithVeto("Do you want to play as the fugitive?", null, TRUE, source = /mob/living/carbon/human)
		if(!length(candidates))
			key_of_fugitive = null
			kill()
			return
		var/mob/C = pick(candidates)
		key_of_fugitive = C.key

		if(!key_of_fugitive)
			kill()
			return
		var/datum/mind/player_mind = new /datum/mind(key_of_fugitive)
		player_mind.active = TRUE
		var/list/spawn_locs = list()
		for(var/obj/effect/landmark/L in GLOB.landmarks_list)
			if(isturf(L.loc))
				switch(L.name)
					if("revenantspawn")
						spawn_locs += L.loc
		if(!spawn_locs) //If we can't find either, just spawn the oldman at the player's location
			spawn_locs += get_turf(player_mind.current)
		if(!spawn_locs) //If we can't find THAT, then just retry
			kill()
			return

		var /mob/living/carbon/human/fug = new /mob/living/carbon/human/(pick(spawn_locs))
		var/datum/outfit/ropita = new/datum/outfit/fugitive
		var/obj/item/organ/external/head/H = fug.get_organ("head")

		ropita.equip(fug)
		var/obj/item/card/id/prisoner/random/id = fug.wear_id
		id.name = fug.name
		id.registered_name = fug.name
		id.access = list(12)

		player_mind.transfer_to(fug)
		player_mind.assigned_role = SPECIAL_ROLE_FUGITIVE
		player_mind.special_role = SPECIAL_ROLE_FUGITIVE

		to_chat(fug, "<B>You are an old fugitive of Permabrig, resting like a baby in maint.</B>")
		to_chat(fug, "<B>You are slow, but very durable. Your attacks slows and corrode your victims.</B>")
		to_chat(fug, "<B>You may Click on walls to travel through them, appearing and disappearing from the station at will.</B>")
		to_chat(fug, "<B>You hunger is endless. If you do not find a new meal after the previous one, you will leave this station to continue hunting.</B>")
		to_chat(fug, "<B>Pulling a dead or critical mob while you enter a wall will pull them in with you, healing you and sending them to your pocket dimension.</B>")
		to_chat(fug, "<B><span class ='notice'>You are not currently in the same plane of existence as the station. Click a wall to emerge.</span></B>")

		H.f_style = "Brad"
		fug.regenerate_icons()

		message_admins("[key_name_admin(fug)] has been made into the Fugitive by an event.")
		log_game("[key_name_admin(fug)] was spawned as the Fugitive by an event.")


/datum/event/spawn_fugitive/start()
	fugitivo()
