/datum/quirk/nonviolent
	name = "Pacifista"
	desc = "La violencia te da asco. Nunca le harias dano a nadie."
	value = -2
	mob_trait = TRAIT_PACIFISM
	gain_text = "<span class='danger'>Sientes un gran sentimiento de repulsion a la violencia.</span>"
	lose_text = "<span class='notice'>VIOLENCIA.</span>"
	medical_record_text = "Paciente se encuentra con una gran empatia que le hace incapaz de dañar a otros."

/datum/quirk/boludo
	name = "Punteria Terrible"
	desc = "Mantener tus manos quietas mientras sostienes algo apuntando a un blanco, no es lo tuyo."
	value = -2
	mob_trait = TRAIT_POOR_AIM
	gain_text = "<span class='danger'>Stormtrooper wannabe.</span>"
	lose_text = "<span class='notice'>Sientes que puedes apuntar con armas sin temblar.</span>"
	medical_record_text = "Paciente se encuentra con problemas de autoestima debido a su pobre puntería."

/datum/quirk/sincara
	name = "Prosopagnosia"
	desc = "No puedes reconocer las caras de la gente."
	value = -1
	mob_trait = TRAIT_PROSOPAGNOSIA
	gain_text = "<span class='danger'>Tu vision se siente extraña.</span>"
	lose_text = "<span class='notice'>Las caras de los demas se ven menos borrosas.</span>"
	medical_record_text = "Paciente se padeciendo de Prosopagnosia."

/datum/quirk/social_anxiety
	name = "Ansiedad Social"
	desc = "Se te hace dificil hablar con gente, tiendes a tartamudear o congelarte. EMPEORA CON MULTITUDES."
	value = -3
	gain_text = "<span class='danger'>Te comienza a preocupar todo lo que dices.</span>"
	lose_text = "<span class='notice'>Sientes una nueva soltura para hablar.</span>" //if only it were that easy!
	medical_record_text = "Paciente se encuentra con transtornos ansiosos en multitudes."
	mob_trait = TRAIT_ANXIOUS
	var/dumb_thing = TRUE

/datum/quirk/social_anxiety/add()
	RegisterSignal(quirk_holder, COMSIG_MOB_EYECONTACT, .proc/eye_contact)
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, .proc/handle_speech)

/datum/quirk/social_anxiety/remove()
	UnregisterSignal(quirk_holder, list(COMSIG_MOB_EYECONTACT, COMSIG_MOB_EXAMINATE, COMSIG_MOB_SAY))

/datum/quirk/social_anxiety/proc/handle_speech(datum/source, mensaje)
	SIGNAL_HANDLER

	var/nearby_people = 0
	for(var/mob/living/carbon/human/H in oview(3, quirk_holder))
		if(H.client)
			nearby_people++
	var/message = mensaje
	if(message)
		var/list/message_split = splittext(message, " ")
		var/list/new_message = list()
		var/mob/living/carbon/human/quirker = quirk_holder
		for(var/word in message_split)
			if(prob(8))
				new_message += pick("uh,","erm,","um,")
				if(prob(min(5,(1*nearby_people)))) //Max 1 in 20 chance of cutoff after a succesful filler roll, for 50% odds in a 15 word sentence
					quirker.silent = max(3, quirker.silent)
					to_chat(quirker, "<span class='danger'>You feel self-conscious and stop talking. You need a moment to recover!</span>")
					break
			if(prob(max(10,(nearby_people*20)))) //Minimum 1/10 chance of stutter
				word = html_decode(word)
				var/leng = length(word)
				var/stuttered = ""
				var/newletter = ""
				var/rawchar = ""
				var/static/regex/nostutter = regex(@@[aeiouAEIOU ""''()[\]{}.!?,:;_`~-]@)
				for(var/i = 1, i <= leng, i += length(rawchar))
					rawchar = newletter = word[i]
					if(prob(80) && !nostutter.Find(rawchar))
						if(prob(10))
							newletter = "[newletter]-[newletter]-[newletter]-[newletter]"
						else if(prob(20))
							newletter = "[newletter]-[newletter]-[newletter]"
						else
							newletter = "[newletter]-[newletter]"
					stuttered += newletter
				sanitize(stuttered)
				new_message += stuttered
			else
				new_message += word
		message = jointext(new_message, " ")
	var/mob/living/carbon/human/quirker = quirk_holder
	if(prob(15))
		if(dumb_thing)
			to_chat(quirker, "<span class='userdanger'>You think of a dumb thing you said a long time ago and scream internally.</span>")
			dumb_thing = FALSE //only once per life
		else
			to_chat(quirk_holder, "<span class='warning'>You think that wouldn't add much to the conversation and decide not to say it.</span>")
			if(prob(min(25,(nearby_people*12.75)))) //Max 25% chance of silence stacks after succesful not talking roll
				to_chat(quirker, "<span class='danger'>You retreat into yourself. You <i>really</i> don't feel up to talking.</span>")
				quirker.silent = max(5, quirker.silent)
		message = pick("Uh.","Erm.","Um.")
		quirker.messagereal = message
	else
		quirker.messagereal = message

/datum/quirk/social_anxiety/proc/eye_contact(datum/source, mob/living/other_mob, triggering_examiner)
	SIGNAL_HANDLER

	if(prob(75))
		return
	var/msg
	if(triggering_examiner)
		msg = "You make eye contact with [other_mob], "
	else
		msg = "[other_mob] makes eye contact with you, "

	switch(rand(1,3))
		if(1)
			quirk_holder.Jitter(10)
			msg += "causing you to start fidgeting!"
		if(2)
			quirk_holder.stuttering = max(3, quirk_holder.stuttering)
			msg += "causing you to start stuttering!"
		if(3)
			quirk_holder.Stun(2 SECONDS)
			msg += "causing you to freeze up!"

	addtimer(CALLBACK(GLOBAL_PROC, .proc/to_chat, quirk_holder, "<span class='userdanger'>[msg]</span>"), 3) // so the examine signal has time to fire and this will print after
	return COMSIG_BLOCK_EYECONTACT
