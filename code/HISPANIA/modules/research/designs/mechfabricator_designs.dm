/datum/design/mechmedbeam
	name = "Exosuit Medical Equipment (Beamgun)"
	desc = "Equipment for medical exosuits. Generates a focused beam of medical nanites."
	id = "mechmedbeamgun"
	build_type = MECHFAB
	req_tech = list("magnets" = 6,"biotech" = 7, "materials" = 7, "engineering" = 8)
	build_path = /obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam
	materials = list(MAT_METAL=10000, MAT_GLASS = 4000, MAT_PLASMA = 5000, MAT_GOLD = 10000, MAT_DIAMOND = 5000)
	construction_time = 300
	category = list("Exosuit Equipment")

/datum/design/protomechmedbeam
	name = "Exosuit Medical Equipment (Prototype Beamgun)"
	desc = "Equipment for medical exosuits. Generates a focused beam of medical nanites. This prototype consumes excessive energy."
	id = "protomechmedbeamgun"
	build_type = MECHFAB
	req_tech = list("magnets" = 6,"biotech" = 7, "materials" = 7, "engineering" = 7)
	build_path = /obj/item/mecha_parts/mecha_equipment/medical/mechmedbeam/protomechmedbeam
	materials = list(MAT_METAL=15000, MAT_GLASS = 8000, MAT_PLASMA = 4000, MAT_GOLD = 8000, MAT_DIAMOND = 2500)
	construction_time = 250
	category = list("Exosuit Equipment")

/datum/design/mech_syringe_gun/large
	name = "Exosuit Medical Equipment (Large Syringe Gun)"
	id = "mech_large_syringe_gun"
	build_type = MECHFAB
	req_tech = list("magnets" = 5,"biotech" = 5, "combat" = 4, "materials" = 5, "engineering" = 4)
	build_path = /obj/item/mecha_parts/mecha_equipment/medical/syringe_gun/large
	materials = list(MAT_METAL=4500,MAT_GLASS=3000,MAT_TITANIUM=3000)
	construction_time = 250
	category = list("Exosuit Equipment")



