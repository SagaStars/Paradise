/datum/quirk/no_taste
	name = "Ageusia"
	desc = "La comida no te sabe a nada, eso si, el veneno igual si lo saboreas."
	value = 0
	mob_trait = TRAIT_AGEUSIA
	gain_text = "<span class='notice'>Se te durmio la lengua!</span>"
	lose_text = "<span class='notice'>Nom nom nom.</span>"
	medical_record_text = "Paciente padece de Ageusia."

/datum/quirk/terminator
	name = "IPC || Lata Dura"
	desc = "Eres un IPC con una capa exterior mas resistente y pesada, no eres tan rapido como los demas."
	value = 0
	lose_text = "<span class='notice'>Tu cuerpo se aligera, pero te sientes fragil.</span>"

/datum/quirk/terminator/add()
	if(ismachineperson(quirk_holder))
		quirk_holder.dna.species.brute_mod -= 1
		quirk_holder.dna.species.burn_mod -= 1
		quirk_holder.dna.species.speed_mod += 2
		to_chat(quirk_holder, "<span class='notice'>Te sientes resistente, pero lento.</span>")
