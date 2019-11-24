/datum/martial_art/seclat
	name = "Seclat"
	block_chance = 30 // Tiene alta probabilidad debido a que solo se puede activar cuando esta en modo throw y con un item en la mano, bruh.
	var/datum/action/heart_boom/heart_boom = new/datum/action/heart_boom()
	var/datum/action/advanced_neck_chop/advanced_neck_chop = new/datum/action/advanced_neck_chop()

/datum/action/heart_boom
	name = "Heart Break Shot - A powerful corkscrew to the chest, stopping the heart for less than a second. Deals stamina damage and lauches the enemy forward"
	button_icon_state = "heart_boom"

/datum/action/heart_boom/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't use Seclat while you're incapacitated.</span>")
		return
	to_chat(owner, "<b><i>Your next attack will be a Heart Break Shot!.</i></b>")
	owner.visible_message("<span class='danger'>[owner] assumes a strange stance... Looks like he is aiming for the heart!</span>")
	var/mob/living/carbon/human/H = owner
	H.martial_art.streak = "heart_boom"

/datum/action/advanced_neck_chop
	name = "Advanced Neck Chop - Injures the neck, stopping the victim from speaking for a while. Deals an average amount of damage."
	button_icon_state = "advanced_neck_chop"

/datum/action/advanced_neck_chop/Trigger()
	if(owner.incapacitated())
		to_chat(owner, "<span class='warning'>You can't use Seclat while you're incapacitated.</span>")
		return
	to_chat(owner, "<b><i>Your next attack will be a Advanced Neck Chop.</i></b>")
	owner.visible_message("<span class='danger'>[owner] raises his palm with a cool looking stance!</span>")
	var/mob/living/carbon/human/H = owner
	H.martial_art.streak = "advanced_neck_chop"

/datum/martial_art/seclat/teach(var/mob/living/carbon/human/H,var/make_temporary=0)
	..()
	to_chat(H, "<span class = 'userdanger'>May the space law be with you!</span>")
	heart_boom.Grant(H)
	advanced_neck_chop.Grant(H)

/datum/martial_art/seclat/proc/check_streak(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	switch(streak)
		if("heart_boom")
			streak = ""
			heart_boom(A,D)
			return 1
		if("advanced_neck_chop")
			streak = ""
			advanced_neck_chop(A,D)
			return 1
	return 0

/datum/martial_art/seclat/proc/heart_boom(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	D.visible_message("<span class='warning'>[A] punches [D]'s in the chest in a spinning fashion!</span>", \
				  	"<span class='userdanger'>[A] hits you fiercely in the chest, for a moment you feel completly numb as your heart stopped for less than a second... you're still recovering from the hit!</span>")
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.apply_damage(13, BRUTE, "chest")
	D.apply_damage(14, STAMINA)
	D.Weaken(0.5)
	D.AdjustLoseBreath(1)
	var/atom/throw_target = get_edge_target_turf(D, A.dir)
	D.throw_at(throw_target, 1, 14, A)
	return 1

/datum/martial_art/seclat/proc/advanced_neck_chop(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	D.visible_message("<span class='warning'>[A] fiercily chops [D]'s neck with his bare hands!</span>", \
				  	"<span class='userdanger'>[A] karate chops your neck, rendering you unable to speak for a relatively short time... Woah that hurts!</span>")
	playsound(get_turf(A), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.apply_damage(8, BRUTE, "head")
	D.AdjustSilence(15)
	return 1

/datum/martial_art/seclat/proc/Suplex(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)

	D.visible_message("<span class='danger'>[A] suplexes [D]!</span>", \
								"<span class='userdanger'>[A] suplexes [D]!</span>")
	D.forceMove(A.loc)
	var/armor_block = D.run_armor_check(null, "melee")
	D.apply_damage(36, BRUTE, null, armor_block)
	D.apply_effect(2, WEAKEN, armor_block)
	add_attack_logs(A, D, "Melee attacked with [src] (SUPLEX)")

	A.SpinAnimation(10,1)

	D.SpinAnimation(10,1)
	spawn(3)
		armor_block = A.run_armor_check(null, "melee")
		A.apply_effect(2, WEAKEN, armor_block)
	return

/datum/martial_art/seclat/disarm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(istype(A.get_inactive_hand(),/obj/item/grab))
		var/obj/item/grab/G = A.get_inactive_hand()
		if(G.affecting == D)
			Suplex(A,D)
			return 1

/datum/martial_art/seclat/grab_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	add_to_streak("G", D)
	if(check_streak(A, D))
		return TRUE
	var/obj/item/grab/G = D.grabbedby(A, 1)
	if(G)
		G.state = GRAB_AGGRESSIVE //Instant aggressive grab
		add_attack_logs(A, D, "Melee attacked with martial-art [src] : aggressively grabbed", ATKLOG_ALL)

/datum/martial_art/seclat/harm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(check_streak(A,D))
		return 1
	add_attack_logs(A, D, "Melee attacked with [src]")
	var/picked_hit_type = pick("pivot jabs", "inverse kicks", "throws a flurry of punches at", "backflip kicks")
	var/bonus_damage = 12.
	if(D.weakened || D.resting || D.lying)
		bonus_damage += 4
		picked_hit_type = "beats the shit out of"
	D.apply_damage(bonus_damage, BRUTE)
	if(picked_hit_type == "inverse kicks")
		bonus_damage += 2
		A.do_attack_animation(D, ATTACK_EFFECT_KICK)
		playsound(get_turf(D), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	if(picked_hit_type == "backflip kicks")
		bonus_damage += 4
		A.SpinAnimation(5,1)
		playsound(get_turf(D), 'sound/effects/hit_kick.ogg', 50, 1, -1)
	else
		A.do_attack_animation(D, ATTACK_EFFECT_PUNCH)
		playsound(get_turf(D), 'sound/effects/hit_punch.ogg', 50, 1, -1)
	D.visible_message("<span class='danger'>[A] [picked_hit_type] [D]!</span>", \
					  "<span class='userdanger'>[A] [picked_hit_type] you!</span>")
	return 1