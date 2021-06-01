/datum/chemical_reaction/emp_pulse
	name = "EMP Pulse"
	required_reagents = list(/datum/reagent/uranium = 1, /datum/reagent/iron = 1) // Yes, laugh, it's the best recipe I could think of that makes a little bit of sense

/datum/chemical_reaction/emp_pulse/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	// 100 created volume = 4 heavy range & 7 light range. A few tiles smaller than traitor EMP grandes.
	// 200 created volume = 8 heavy range & 14 light range. 4 tiles larger than traitor EMP grenades.
	empulse(location, round(created_volume / 24), round(created_volume / 14), 1)
	holder.clear_reagents()

/datum/chemical_reaction/serotrotium
	name = "Serotrotium"
	results = list(/datum/reagent/serotrotium = 1) //Weird emotes, chance of minor drowsiness.
	required_reagents = list(/datum/reagent/medicine/paracetamol = 1, /datum/reagent/medicine/tramadol = 1)

/datum/chemical_reaction/toxin_two //Space Atropine!
	name = "Toxin"
	results = list(/datum/reagent/toxin = 3)
	required_reagents = list(/datum/reagent/medicine/synaptizine = 1, /datum/reagent/toxin/xeno_neurotoxin = 8)

/datum/chemical_reaction/sdtoxin
	name = "Toxin"
	results = list(/datum/reagent/toxin/sdtoxin = 2)
	required_reagents = list(/datum/reagent/medicine/synaptizine = 1, /datum/reagent/medicine/dylovene = 1)

/datum/chemical_reaction/sleeptoxin
	name = "Soporific"
	results = list(/datum/reagent/toxin/sleeptoxin = 5)
	required_reagents = list(/datum/reagent/toxin/chloralhydrate = 1, /datum/reagent/consumable/sugar = 4)

/datum/chemical_reaction/mutagen
	name = "Unstable mutagen"
	results = list(/datum/reagent/toxin/mutagen = 3)
	required_reagents = list(/datum/reagent/radium = 1, /datum/reagent/phosphorus = 1, /datum/reagent/chlorine = 1)

/datum/chemical_reaction/water //I can't believe we never had this.
	name = "Water"
	results = list(/datum/reagent/water = 1)
	required_reagents = list(/datum/reagent/oxygen = 1, /datum/reagent/hydrogen = 2)

/datum/chemical_reaction/lexorin
	name = "Lexorin"
	results = list(/datum/reagent/toxin/lexorin = 3)
	required_reagents = list(/datum/reagent/toxin/phoron = 1, /datum/reagent/hydrogen = 1, /datum/reagent/nitrogen = 1)

/datum/chemical_reaction/space_drugs
	name = "Space Drugs"
	results = list(/datum/reagent/space_drugs = 3)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/lithium = 1)

/datum/chemical_reaction/lube
	name = "Space Lube"
	results = list(/datum/reagent/lube = 4)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/silicon = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/pacid
	name = "Polytrinic acid"
	results = list(/datum/reagent/toxin/acid/polyacid = 3)
	required_reagents = list(/datum/reagent/toxin/acid = 1, /datum/reagent/chlorine = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/impedrezene
	name = "Impedrezene"
	results = list(/datum/reagent/impedrezene = 2)
	required_reagents = list(/datum/reagent/mercury = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/cryptobiolin
	name = "Cryptobiolin"
	results = list(/datum/reagent/cryptobiolin = 3)
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/oxygen = 1, /datum/reagent/consumable/sugar = 1)

/datum/chemical_reaction/glycerol
	name = "Glycerol"
	results = list(/datum/reagent/glycerol = 1)
	required_reagents = list(/datum/reagent/consumable/cornoil = 3, /datum/reagent/toxin/acid = 1)

/datum/chemical_reaction/flash_powder
	name = "Flash powder"
	required_reagents = list(/datum/reagent/aluminum = 1, /datum/reagent/potassium = 1, /datum/reagent/sulfur = 1)

/datum/chemical_reaction/flash_powder/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
	s.set_up(2, 1, location)
	s.start()
	for(var/mob/living/carbon/M in viewers(WORLD_VIEW, location))
		switch(get_dist(M, location))
			if(0 to 3)
				if(M.flash_act())
					M.Paralyze(30 SECONDS)

			if(4 to 5)
				if(M.flash_act())
					M.Stun(10 SECONDS)


/datum/chemical_reaction/napalm
	name = "Napalm"
	required_reagents = list(/datum/reagent/aluminum = 1, /datum/reagent/toxin/phoron = 1, /datum/reagent/toxin/acid = 1 )

/datum/chemical_reaction/napalm/on_reaction(datum/reagents/holder, created_volume, radius)
	var/location = get_turf(holder.my_atom)
	radius = round(created_volume/45)
	if(radius < 0) radius = 0
	if(radius > 3) radius = 3

	for(var/turf/T in range(radius,location))
		if(T.density)
			continue
		if(istype(T,/turf/open/space))
			continue
		T.ignite(5 + rand(0,11))


/datum/chemical_reaction/chemsmoke
	name = "Chemsmoke"
	required_reagents = list(/datum/reagent/potassium = 1, /datum/reagent/consumable/sugar = 1, /datum/reagent/phosphorus = 1)

/datum/chemical_reaction/chemsmoke/on_reaction(datum/reagents/holder, created_volume)
	var/smoke_radius = round(sqrt(created_volume * 1.5), 1)
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/smoke_spread/chem/S = new(location)
	playsound(location, 'sound/effects/smoke.ogg', 50, 1, -3)
	S?.set_up(holder, smoke_radius, location)
	S?.start()
	if(holder?.my_atom)
		holder.clear_reagents()


/datum/chemical_reaction/chloralhydrate
	name = "Chloral Hydrate"
	results = list(/datum/reagent/toxin/chloralhydrate = 1)
	required_reagents = list(/datum/reagent/consumable/ethanol = 1, /datum/reagent/chlorine = 3, /datum/reagent/water = 1)

/datum/chemical_reaction/potassium_chloride
	name = "Potassium Chloride"
	results = list(/datum/reagent/toxin/potassium_chloride = 2)
	required_reagents = list(/datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/potassium = 1)

/datum/chemical_reaction/potassium_chlorophoride
	name = "Potassium Chlorophoride"
	results = list(/datum/reagent/toxin/potassium_chlorophoride = 4)
	required_reagents = list(/datum/reagent/toxin/potassium_chloride = 1, /datum/reagent/toxin/phoron = 1, /datum/reagent/toxin/chloralhydrate = 1)

/datum/chemical_reaction/zombiepowder
	name = "Zombie Powder"
	results = list(/datum/reagent/toxin/zombiepowder = 2)
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 5, /datum/reagent/toxin/sleeptoxin = 5, /datum/reagent/copper = 5)

/datum/chemical_reaction/rezadone
	name = "Rezadone"
	results = list(/datum/reagent/medicine/rezadone = 3)
	required_reagents = list(/datum/reagent/toxin/carpotoxin = 1, /datum/reagent/cryptobiolin = 1, /datum/reagent/copper = 1)

/datum/chemical_reaction/mindbreaker
	name = "Mindbreaker Toxin"
	results = list(/datum/reagent/toxin/mindbreaker = 3)
	required_reagents = list(/datum/reagent/silicon = 1, /datum/reagent/hydrogen = 1, /datum/reagent/medicine/dylovene = 1)

/datum/chemical_reaction/lipozine
	name = "Lipozine"
	results = list(/datum/reagent/lipozine = 3)
	required_reagents = list(/datum/reagent/consumable/sodiumchloride = 1, /datum/reagent/consumable/ethanol = 1, /datum/reagent/radium = 1)

/datum/chemical_reaction/phoronsolidification
	name = "Solid Phoron"
	required_reagents = list(/datum/reagent/iron = 5, /datum/reagent/consumable/frostoil = 5, /datum/reagent/toxin/phoron = 20)

/datum/chemical_reaction/phoronsolidification/on_reaction(datum/reagents/holder, created_volume)
	var/location = get_turf(holder.my_atom)
	new /obj/item/stack/sheet/mineral/phoron(location)

/datum/chemical_reaction/plastication
	name = "Plastic"
	required_reagents = list(/datum/reagent/toxin/acid/polyacid = 10, /datum/reagent/toxin/plasticide = 20)

/datum/chemical_reaction/plastication/on_reaction(datum/reagents/holder)
	new /obj/item/stack/sheet/mineral/plastic(get_turf(holder.my_atom),10)

/datum/chemical_reaction/virus_food
	name = "Virus Food"
	results = list(/datum/reagent/consumable/virus_food = 15)
	required_reagents = list(/datum/reagent/water = 5, /datum/reagent/consumable/drink/milk = 5, /datum/reagent/oxygen = 5)


///////////////////////////////////////////////////////////////////////////////////
// foam and foam precursor

/datum/chemical_reaction/surfactant
	name = "Foam surfactant"
	results = list(/datum/reagent/fluorosurfactant = 5)
	required_reagents = list(/datum/reagent/fluorine = 2, /datum/reagent/carbon = 2, /datum/reagent/toxin/acid = 1)


/datum/chemical_reaction/foam
	name = "Foam"
	required_reagents = list(/datum/reagent/fluorosurfactant = 1, /datum/reagent/water = 1)
	mob_react = FALSE

/datum/chemical_reaction/foam/on_reaction(datum/reagents/holder, created_volume)
	var/turf/location = get_turf(holder.my_atom)
	location.visible_message("<span class='warning'>The solution spews out foam!</span>")
	var/datum/effect_system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 0)
	s.start()
	holder.clear_reagents()


/datum/chemical_reaction/metalfoam
	name = "Metal Foam"
	required_reagents = list(/datum/reagent/aluminum = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/toxin/acid/polyacid = 1)
	mob_react = FALSE

/datum/chemical_reaction/metalfoam/on_reaction(datum/reagents/holder, created_volume)
	var/turf/location = get_turf(holder.my_atom)
	location.visible_message("<span class='warning'>The solution spews out a metalic foam!</span>")

	var/datum/effect_system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 1)
	s.start()
	holder.clear_reagents()


/datum/chemical_reaction/ironfoam
	name = "Iron Foam"
	required_reagents = list(/datum/reagent/iron = 3, /datum/reagent/foaming_agent = 1, /datum/reagent/toxin/acid = 1)
	mob_react = FALSE

/datum/chemical_reaction/ironfoam/on_reaction(datum/reagents/holder, created_volume)
	var/turf/location = get_turf(holder.my_atom)
	location.visible_message("<span class='warning'>The solution spews out a metallic foam!</span>")
	var/datum/effect_system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 1)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/razorburn
	name = "Razorburn Gas"
	required_reagents = list(/datum/reagent/foaming_agent = 1, /datum/reagent/toxin/nanites = 1)

/datum/chemical_reaction/razorburn/on_reaction(datum/reagents/holder, created_volume)
	var/turf/location = get_turf(holder.my_atom)
	location.visible_message("<span class='danger'>The solution spews out a dense, ground-hugging gas! Get away!</span>")
	var/datum/effect_system/foam_spread/s = new()
	s.set_up(created_volume, location, holder, 2)
	s.start()
	holder.clear_reagents()

/datum/chemical_reaction/foaming_agent
	name = "Foaming Agent"
	results = list(/datum/reagent/foaming_agent = 1)
	required_reagents = list(/datum/reagent/lithium = 1, /datum/reagent/hydrogen = 1)

/datum/chemical_reaction/ammonia
	name = "Ammonia"
	results = list(/datum/reagent/ammonia = 3)
	required_reagents = list(/datum/reagent/hydrogen = 3, /datum/reagent/nitrogen = 1)

/datum/chemical_reaction/diethylamine
	name = "Diethylamine"
	results = list(/datum/reagent/diethylamine = 2)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/consumable/ethanol = 1)

/datum/chemical_reaction/space_cleaner
	name = "Space cleaner"
	results = list(/datum/reagent/space_cleaner = 2)
	required_reagents = list(/datum/reagent/ammonia = 1, /datum/reagent/water = 1)

/datum/chemical_reaction/plantbgone
	name = "Plant-B-Gone"
	results = list(/datum/reagent/toxin/plantbgone = 5)
	required_reagents = list(/datum/reagent/toxin = 1, /datum/reagent/water = 4)

/datum/chemical_reaction/laughter
	name = "laughter"
	results = list(/datum/reagent/consumable/laughter = 5)
	required_reagents = list(/datum/reagent/consumable/sugar = 1, /datum/reagent/consumable/drink/banana = 1)

/datum/chemical_reaction/phenol
	name = "Phenol"
	id = /datum/reagent/phenol
	results = list(/datum/reagent/phenol = 3)
	required_reagents = list(/datum/reagent/water = 1, /datum/reagent/chlorine = 1, /datum/reagent/oil = 1)

/datum/chemical_reaction/acetone
	name = "Acetone"
	id = /datum/reagent/acetone
	results = list(/datum/reagent/acetone = 3)
	required_reagents = list(/datum/reagent/oil = 1, /datum/reagent/fuel = 1, /datum/reagent/oxygen = 1)

/datum/chemical_reaction/oil
	name = "Oil"
	id = /datum/reagent/oil
	results = list(/datum/reagent/oil = 3)
	required_reagents = list(/datum/reagent/fuel = 1, /datum/reagent/carbon = 1, /datum/reagent/hydrogen = 1)