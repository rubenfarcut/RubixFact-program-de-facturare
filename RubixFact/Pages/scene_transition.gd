extends CanvasLayer


func change_scene(target:String)->void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer,"animation_finished")
	#warning-ignore:unused_variable
	var ch=get_tree().change_scene(target)
	$AnimationPlayer.play_backwards("dissolve")
var firma_mea ={
	nume="",
	reg_com="",
	cif="",
	adresa="",
	iban="",
	banca="",
	swift="",
	telefon="",
	email="",
	capital_social="",
	responsabil={
		nume="",
		cnp="",
	},
	delegat={
		nume="",
		ci="",
		auto="",
		agent_vanzari=""
	},
	logo=""
}

func _ready():
	
	var save_file = File.new()
	save_file.open("res://date_firma.save", File.READ)
	var content=save_file.get_as_text().split(";")
	firma_mea.nume=content[0]
	firma_mea.reg_com=content[1]
	firma_mea.cif=content[2]
	firma_mea.adresa=content[3]
	firma_mea.iban=content[4]
	firma_mea.banca=content[5]
	firma_mea.swift=content[6]
	firma_mea.telefon=content[7]
	firma_mea.email=content[8]
	firma_mea.capital_social=content[9]
	firma_mea.responsabil.nume=content[10]
	firma_mea.responsabil.cnp=content[11]
	firma_mea.delegat.nume=content[12]
	firma_mea.delegat.ci=content[13]
	firma_mea.delegat.auto=content[14]
	firma_mea.delegat.agent_vanzari=content[15]
	firma_mea.logo=content[16]
	save_file.close()
