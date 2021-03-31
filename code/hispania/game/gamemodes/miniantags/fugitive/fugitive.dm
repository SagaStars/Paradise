#define SPECIAL_ROLE_FUGITIVE 			"Fugitive"
#define SPECIAL_ROLE_FUGITIVEFRIEND 	"FugitiveFriend"
#define SPECIAL_ROLE_FUGITIVESHUTTLE 	"FugitiveShuttleOwner"

/datum/game_mode/fugitive
	name = "fugitive"
	config_tag = "fugitive"
	votable = 0
	var/datum/mind/fugitivo
	var/datum/mind/lefriend
	var/datum/mind/shuttleowner

/datum/game_mode/fugitive/proc/setup_rescatists()
	var/list/compadres = pollCandidatesWithVeto(src,usr,2,"Do you want to play as the fugitive?",null,null,10 SECONDS,TRUE,null,TRUE,FALSE, source = image('icons/hispania/obj/event_icon.dmi', "fugitive"))
	if(length(compadres) < 2)
		// UUUUHH... a reintentar
		return

	var/mob/friendo = pick(compadres)
	compadres -= friendo

	var/mob/ladroncillo = pick(compadres)

	if(!ladroncillo.key || !friendo.key)
		// UHHHH.... a reintentar
		return

	var/list/spawn_locs1 = list()
	var/list/spawn_locs2 = list()
	for(var/obj/effect/landmark/L in GLOB.landmarks_list)
		if(isturf(L.loc))
			switch(L.name)
				if("fugitivefriend")
					spawn_locs1 += L.loc
				if("fugitiveshuttlestoler")
					spawn_locs2 += L.loc
	if(!spawn_locs1 || !spawn_locs2) // Pues si no los encontramos es por que han de haber jodido algo alla, asi que no mas rescatistas.
		// CANCELAR
		return

	var/datum/mind/lefriend_mind = new /datum/mind(friendo.key)
	lefriend_mind.active = TRUE
	var/datum/mind/shuttle_mind = new /datum/mind(ladroncillo.key)
	shuttle_mind.active = TRUE

	lefriend = lefriend_mind
	shuttleowner = shuttle_mind

	var /mob/living/carbon/human/fugfriend = new /mob/living/carbon/human/(pick(spawn_locs1))
	var/datum/outfit/galan = new/datum/outfit/fugitive2
	galan.equip(fugfriend)

	var /mob/living/carbon/human/fugshuttle = new /mob/living/carbon/human/(pick(spawn_locs2))
	var/datum/outfit/culero = new/datum/outfit/fugitive3
	culero.equip(fugshuttle)

	lefriend_mind.transfer_to(fugfriend)
	lefriend_mind.assigned_role = SPECIAL_ROLE_FUGITIVEFRIEND
	lefriend_mind.special_role = SPECIAL_ROLE_FUGITIVEFRIEND

	var/obj/item/organ/external/head/H = fugfriend.get_organ("head")
	H.f_style = "Brad" // Barba bros
	fugfriend.regenerate_icons()

	shuttle_mind.transfer_to(fugshuttle)
	shuttle_mind.assigned_role = SPECIAL_ROLE_FUGITIVESHUTTLE
	shuttle_mind.special_role = SPECIAL_ROLE_FUGITIVESHUTTLE

	to_chat(fugfriend, "<B>You are an old fugitive of Permabrig, resting like a baby in maint.</B>")
	to_chat(fugfriend, "<B>You are slow, but very durable. Your attacks slows and corrode your victims.</B>")
	to_chat(fugfriend, "<B>You may Click on walls to travel through them, appearing and disappearing from the station at will.</B>")
	to_chat(fugfriend, "<B>You hunger is endless. If you do not find a new meal after the previous one, you will leave this station to continue hunting.</B>")
	to_chat(fugfriend, "<B>Pulling a dead or critical mob while you enter a wall will pull them in with you, healing you and sending them to your pocket dimension.</B>")

	to_chat(fugshuttle, "<B>You are an old fugitive of Permabrig, resting like a baby in maint.</B>")
	to_chat(fugshuttle, "<B>You are slow, but very durable. Your attacks slows and corrode your victims.</B>")
	to_chat(fugshuttle, "<B>You may Click on walls to travel through them, appearing and disappearing from the station at will.</B>")
	to_chat(fugshuttle, "<B>You hunger is endless. If you do not find a new meal after the previous one, you will leave this station to continue hunting.</B>")
	to_chat(fugshuttle, "<B>Pulling a dead or critical mob while you enter a wall will pull them in with you, healing you and sending them to your pocket dimension.</B>")

	//var/datum/objective/contact/con = new
	//con.owner = fug.mind
	//con.explanation_text = "Make contact with the Syndicate."
	//fug.mind.objectives += con

	to_chat(fugfriend, "<span class='notice'>A phone is ringing in the live room, prepare and get out.</span>")
	to_chat(fugshuttle, "<span class='notice'>A phone is ringing in the live room, prepare and get out.</span>")

/datum/game_mode/fugitive/proc/setup_fugitive(datum/mind/player_mind)
	var/list/spawn_locs = list()
	for(var/obj/effect/landmark/L in GLOB.landmarks_list)
		if(isturf(L.loc))
			switch(L.name)
				if("fugitive")
					spawn_locs += L.loc
	if(!spawn_locs) //If we can't find either, just spawn the oldman at the player's location
		spawn_locs += get_turf(player_mind.current)
	fugitivo = player_mind
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
	//to_chat(fug, "<B><span class ='notice'>You are not currently in the same plane of existence as the station. Click a wall to emerge.</span></B>")

	var/datum/objective/contact/con = new
	con.owner = fug.mind
	con.explanation_text = "Make contact with the Syndicate."
	fug.mind.objectives += con

	to_chat(fug, "<span class='notice'>You need to make contact with the syndicate for your extraction, there's a paper stored in your backpack with further instructions.</span>")

	H.f_style = "Brad"
	fug.regenerate_icons()
	update_abductor_icons_added(fug)

	return fug

/datum/game_mode/fugitive/eventmode_end()
	check_finished()

/datum/game_mode/fugitive/check_finished()
	var/text = ""
	if(fugitivo)
		var/win = TRUE
		text += "<br><span class='medium'><b>The fugitive was:</b></span><br>"
		text += printplayer(fugitivo)
		text += "<br>"
		var/list/O = fugitivo.objectives
		if(O && O.len)//If the traitor had no objectives, don't need to process this.
			var/count = 1
			for(var/datum/objective/o in O)
				if(o.check_completion())
					text += "<br><B>Objective #[count]</B>: [o.explanation_text] <font color='green'><B>Success!</B></font>"
					SSblackbox.record_feedback("nested tally", "traitor_objective", 1, list("[o.type]", "SUCCESS"))
				else
					text += "<br><B>Objective #[count]</B>: [o.explanation_text] <font color='red'>Fail.</font>"
					SSblackbox.record_feedback("nested tally", "traitor_objective", 1, list("[o.type]", "FAIL"))
					win = FALSE
		if(win)
			text += "<br><font color='green'><B>The fugitive was successful!</B></font><br>"
			SSblackbox.record_feedback("tally", "fugitive_success", 1, "SUCCESS")
		else
			text += "<br><font color='red'><B>The fugitive has failed!</B></font><br>"
			SSblackbox.record_feedback("tally", "fugitive_success", 1, "FAIL")
	to_chat(world, text)

/obj/effect/landmark/fugitive
	name = "fugitive"

/obj/effect/landmark/fugitive/friend
	name = "fugitivefriend"

/obj/effect/landmark/fugitive/shuttle
	name = "fugitiveshuttlestoler"

/* Para mas tarde, descansa mi dulce principe
/datum/game_mode/proc/muertealfugitive(datum/mind/abductor_mind)
	if(abductor_mind in abductors)
		SSticker.mode.abductors -= abductor_mind
		abductor_mind.special_role = null
		abductor_mind.current.create_attack_log("<span class='danger'>No longer abductor</span>")
		abductor_mind.current.create_log(CONVERSION_LOG, "No longer abductor")
		if(issilicon(abductor_mind.current))
			to_chat(abductor_mind.current, "<span class='userdanger'>You have been turned into a robot! You are no longer an abductor.</span>")
		else
			to_chat(abductor_mind.current, "<span class='userdanger'>You have been brainwashed! You are no longer an abductor.</span>")
		SSticker.mode.update_abductor_icons_removed(abductor_mind)
*/
/datum/game_mode/proc/update_fugitive_icons_added(datum/mind/alien_mind)
	var/datum/atom_hud/antag/hud = GLOB.huds[ANTAG_HUD_ABDUCTOR]
	hud.join_hud(alien_mind.current)
	set_antag_hud(alien_mind.current, ((alien_mind in abductors) ? "abductor" : "abductee"))

/datum/game_mode/proc/update_fugitive_icons_removed(datum/mind/alien_mind)
	var/datum/atom_hud/antag/hud = GLOB.huds[ANTAG_HUD_ABDUCTOR]
	hud.leave_hud(alien_mind.current)
	set_antag_hud(alien_mind.current, null)
