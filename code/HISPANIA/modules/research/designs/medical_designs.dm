/datum/design/healthanalyzer
	name = "Health Analyzer"
	desc = "A hand-held body scanner able to distinguish vital signs of the subject"
	id = "healthanalyzer"
	req_tech = list("biotech" = 2)
	build_type = PROTOLATHE
	materials = list(MAT_METAL = 500, MAT_GLASS = 50)
	build_path = /obj/item/healthanalyzer
	category = list("Medical")

/datum/design/moa
	name = "M.O.A"
	desc = "(Medbay Oxygen Asissistant) A oxigen assistant that will be sending oxygen to the pacient over a period of time."
	id = "m.o.a"
	req_tech = list("materials" = 5, "biotech" = 4, "engineering" = 5)
	build_type = PROTOLATHE
	materials = list(MAT_METAL=6000, MAT_GLASS=800, MAT_TITANIUM = 850)
	build_path = /obj/item/reagent_containers/moa
	category = list("Medical")